import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../chat/chat_service.dart';
import '../chat/chat_page.dart';

class ChatListPage extends StatelessWidget {
  final String myId;
  const ChatListPage({super.key, required this.myId});

  @override
  Widget build(BuildContext context) {
    final chatService = ChatService();

    return StreamBuilder<QuerySnapshot>(
      stream: chatService.getMyChats(myId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No chats yet"));
        }

        final chats = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: chats.length,
          itemBuilder: (context, index) {
            final data = chats[index].data() as Map<String, dynamic>;
            final users = List<String>.from(data['users']);
            final otherUserId = users.firstWhere((id) => id != myId);

            return ListTile(
              leading: const CircleAvatar(),
              title: Text(data['lastMessage'] ?? ''),
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
            );
          },
        );
      },
    );
  }
}
