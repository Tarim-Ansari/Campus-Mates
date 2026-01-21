import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/post_service.dart';
import '../widgets/post_card.dart';

class CommunityPage extends StatelessWidget {
  final String myId;

  const CommunityPage({
    super.key,
    required this.myId,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: PostService().getCommunityPosts(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No posts yet"));
        }

        return ListView(
          padding: const EdgeInsets.all(20),
          children: snapshot.data!.docs.map((doc) {
            return PostCard(
              data: doc.data() as Map<String, dynamic>,
              myId: myId,
            );
          }).toList(),
        );
      },
    );
  }
}
