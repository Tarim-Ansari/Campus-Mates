import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/notification_service.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = NotificationService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        actions: [
          TextButton(
            onPressed: () {
              service.markAllAsRead();
            },
            child: const Text(
              "Mark all read",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: service.getMyNotifications(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No notifications"));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;

              return ListTile(
                leading: Icon(
                  data['type'] == 'chat'
                      ? Icons.chat
                      : data['type'] == 'post'
                          ? Icons.post_add
                          : Icons.notifications,
                ),
                title: Text(data['title']),
                subtitle: Text(data['body']),
                trailing: data['isRead']
                    ? null
                    : const Icon(Icons.circle, size: 10, color: Colors.red),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
