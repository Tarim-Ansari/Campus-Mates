// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../chat/chat_service.dart';
import '../chat/chat_page.dart';
import '../theme/app_theme.dart';

class RightSidebar extends StatelessWidget {
  final String myId;
  const RightSidebar({super.key, required this.myId});

  @override
  Widget build(BuildContext context) {
    final chatService = ChatService();

    return SizedBox(
      width: 260,
      child: Column(
        children: [
          // 🔹 CHATS PREVIEW
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppTheme.accentGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: StreamBuilder(
              stream: chatService.getMyChats(myId),
              builder: (context, snapshot) {
                if (!snapshot.hasData ||
                    snapshot.data!.docs.isEmpty) {
                  return const Text(
                    "No chats yet",
                    style: TextStyle(color: Colors.white70),
                  );
                }

                final chats = snapshot.data!.docs.take(3).toList();

                return Column(
                  children: chats.map((doc) {
                    final data =
                        doc.data() as Map<String, dynamic>;
                    final users =
                        List<String>.from(data['users']);
                    final otherUserId =
                        users.firstWhere((id) => id != myId);

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatPage(
                              otherUserId: otherUserId,
                              otherUserName: otherUserId,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          data['lastMessage'] ?? '',
                          style: const TextStyle(
                              color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
