// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class EventCard extends StatefulWidget {
  final Map<String, dynamic> data;

  const EventCard({super.key, required this.data});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  late Timer _timer;
  late Duration _remaining;
  bool _hovered = false;

  static const List<String> _images = [
    'assets/event_images/hack.jpeg',
    'assets/event_images/ai.jpg',
    'assets/event_images/sports.jpg',
    'assets/event_images/party.jpg',
    'assets/event_images/debate.jpg',
    'assets/event_images/alumni.jpg',
  ];

  late final String _image;

  @override
  void initState() {
    super.initState();

    final eventDate =
        (widget.data['dateTime'] as Timestamp).toDate();
    _remaining = eventDate.difference(DateTime.now());

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _remaining = eventDate.difference(DateTime.now());
      });
    });

    // ✅ stable image selection (no repetition jump)
    final hash = widget.data['title'].hashCode.abs();
    _image = _images[hash % _images.length];
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final d = _remaining;
    final countdown = d.isNegative
        ? "Event ended"
        : "${d.inDays}d ${d.inHours % 24}h ${d.inMinutes % 60}m ${d.inSeconds % 60}s";

    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.75,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            height: 230,
            margin: const EdgeInsets.only(bottom: 22),
            transform: _hovered
                ? (Matrix4.identity()
                  ..translate(0.0, -6.0)
                  ..scale(1.01))
                : Matrix4.identity(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF80DEEA),
                  Color(0xFFE0F7FA),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.teal.withOpacity(_hovered ? 0.28 : 0.14),
                  blurRadius: _hovered ? 22 : 14,
                  offset: const Offset(0, 10),
                ),
              ],
            ),

            // ===== INNER CARD =====
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(1.6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6FEFF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      // ================= LEFT: EVENT DETAILS =================
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(18, 18, 14, 18),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              // TITLE
                              Text(
                                widget.data['title'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              // DESCRIPTION
                              Text(
                                widget.data['description'],
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    const TextStyle(fontSize: 14),
                              ),

                              // VENUE
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 16),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      widget.data['venue'],
                                      maxLines: 1,
                                      overflow:
                                          TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),

                              // DATE
                              Row(
                                children: [
                                  const Icon(
                                      Icons.calendar_today,
                                      size: 16),
                                  const SizedBox(width: 6),
                                  Text(
                                    (widget.data['dateTime']
                                            as Timestamp)
                                        .toDate()
                                        .toString(),
                                  ),
                                ],
                              ),

                              // COUNTDOWN
                              Text(
                                countdown,
                                style: TextStyle(
                                  color: d.isNegative
                                      ? Colors.red
                                      : Colors.teal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              // REGISTER
                              if ((widget.data['registrationLink'] ??
                                      "")
                                  .toString()
                                  .isNotEmpty)
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      final url = Uri.parse(
                                          widget.data[
                                              'registrationLink']);
                                      if (await canLaunchUrl(url)) {
                                        launchUrl(url);
                                      }
                                    },
                                    icon: const Icon(
                                        Icons.open_in_new),
                                    label: const Text("Register"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape:
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(
                                                14),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      // ================= RIGHT: IMAGE =================
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight:
                                Radius.circular(20),
                          ),
                          child: Image.asset(
                            _image,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ===== SLIDER INDICATOR =====
                Positioned(
                  right: 8,
                  top: 26,
                  bottom: 26,
                  child: Container(
                    width: 4,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(8),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF4DD0E1),
                          Color(0xFFB2EBF2),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
