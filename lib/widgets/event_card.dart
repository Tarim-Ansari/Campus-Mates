import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class EventCard extends StatefulWidget {
  final Map<String, dynamic> data;

  const EventCard({super.key, required this.data});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  late Timer timer;
  late Duration remaining;

  @override
  void initState() {
    super.initState();
    _update();
    timer = Timer.periodic(const Duration(seconds: 1), (_) => _update());
  }

  void _update() {
    final eventTime =
        (widget.data['eventDate'] as Timestamp).toDate();
    setState(() {
      remaining = eventTime.difference(DateTime.now());
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.data;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(d['title'],
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),

            const SizedBox(height: 6),
            Text(d['description']),
            const SizedBox(height: 6),
            Text("📍 ${d['venue']}"),

            const SizedBox(height: 10),
            Text(
              remaining.isNegative
                  ? "Event started"
                  : "⏳ ${remaining.inDays}d "
                    "${remaining.inHours % 24}h "
                    "${remaining.inMinutes % 60}m "
                    "${remaining.inSeconds % 60}s",
              style: const TextStyle(color: Colors.red),
            ),

            const SizedBox(height: 10),

            TextButton(
              onPressed: () async {
                final url = Uri.parse(d['registrationLink']);
                if (await canLaunchUrl(url)) {
                  launchUrl(url);
                }
              },
              child: const Text("Register"),
            )
          ],
        ),
      ),
    );
  }
}
