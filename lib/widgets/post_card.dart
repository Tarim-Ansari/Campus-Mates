// ignore_for_file: deprecated_member_use, curly_braces_in_flow_control_structures, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import '../screens/comments_page.dart';
import '../chat/chat_page.dart';
import '../services/post_service.dart';

class PostCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final String myId;

  const PostCard({
    super.key,
    required this.data,
    required this.myId,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _hovered = false;

  static const List<String> _images = [
    'assets/post_images/p1.png',
    'assets/post_images/p2.png',
    'assets/post_images/p3.pngg',
    'assets/post_images/p4.png',
    'assets/post_images/p5.png',
    'assets/post_images/p6.png',
  ];

  late final String _image;

  @override
  void initState() {
    super.initState();
    final hash = widget.data['id'].hashCode.abs();
    _image = _images[hash % _images.length];
  }

  @override
  Widget build(BuildContext context) {
    final likes = List<String>.from(widget.data['likes'] ?? []);
    final isLiked = likes.contains(widget.myId);

    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.75,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            height: 200, // ✅ Taller card
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
                  Color(0xFFB388FF),
                  Color(0xFFE1BEE7),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.deepPurple.withOpacity(_hovered ? 0.28 : 0.14),
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
                    color: const Color(0xFFFDF7FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      // ================= LEFT: CONTENT =================
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(18, 18, 14, 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              /// USER EMAIL → DM
                              GestureDetector(
                                onTap: () {
                                  if (widget.data['userId'] ==
                                      widget.myId) return;

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ChatPage(
                                        otherUserId:
                                            widget.data['userId'],
                                        otherUserName:
                                            widget.data['userEmail'],
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  widget.data['userEmail'] ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                    decoration:
                                        TextDecoration.underline,
                                  ),
                                ),
                              ),

                              // POST TEXT
                              Expanded(
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      widget.data['text'] ?? "",
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14.5,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // ACTIONS
                              Row(
                                children: [
                                  _iconButton(
                                    icon: isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isLiked
                                        ? Colors.red
                                        : Colors.grey,
                                    label: likes.length.toString(),
                                    onTap: () {
                                      PostService().toggleLike(
                                          widget.data['id']);
                                    },
                                  ),
                                  const SizedBox(width: 24),
                                  _iconButton(
                                    icon:
                                        Icons.comment_outlined,
                                    color: Colors.grey,
                                    label: "Comment",
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              CommentsPage(
                                                  postId: widget
                                                      .data['id']),
                                        ),
                                      );
                                    },
                                  ),
                                ],
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
                            bottomRight: Radius.circular(20),
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
                      borderRadius: BorderRadius.circular(8),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF9575CD),
                          Color(0xFFD1C4E9),
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

  // ================= ICON BUTTON =================

  Widget _iconButton({
    required IconData icon,
    required Color color,
    required String label,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
