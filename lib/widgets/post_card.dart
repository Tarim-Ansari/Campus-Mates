import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../chat/chat_page.dart';

class PostCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final String myId;

  const PostCard({
    super.key,
    required this.data,
    required this.myId,
  });


  @override
  Widget build(BuildContext context) {
    final userEmail = data['userEmail'] ?? 'Unknown';
    final userId = data['userId']; // sender uid

    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [AppTheme.softShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 HEADER
          Row(
            children: [
              const CircleAvatar(radius: 20),
              const SizedBox(width: 10),

              // 👉 CLICK USER → CHAT
              GestureDetector(
                onTap: () {
                  if (userId == null || userId == myId) return;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatPage(
                        otherUserId: userId,
                        otherUserName: userEmail,
                      ),
                    ),
                  );
                },
                child: Text(
                  userEmail,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),

              const Spacer(),
              const Icon(Icons.more_horiz),
            ],
          ),

          const SizedBox(height: 15),

          // 🔹 POST TEXT
          Text(data['text'] ?? ""),

          const SizedBox(height: 15),

          // 🔹 IMAGE
          if (data['imageUrl'] != null && data['imageUrl'] != "")
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                data['imageUrl'],
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

          const SizedBox(height: 15),

          // 🔹 ACTIONS
          const Row(
            children: [
              Icon(Icons.favorite_border),
              SizedBox(width: 20),
              Icon(Icons.chat_bubble_outline),
              SizedBox(width: 20),
              Icon(Icons.share),
            ],
          ),
        ],
      ),
    );
  }
}
