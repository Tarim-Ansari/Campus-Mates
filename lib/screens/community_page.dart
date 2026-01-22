import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/post_service.dart';
import '../widgets/post_card.dart';

class CommunityPage extends StatelessWidget {
  final String myId;
  const CommunityPage({super.key, required this.myId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: PostService().getCommunityPosts(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            data['id'] = doc.id;

            return PostCard(
              data: data,
              myId: myId,
            );
          }).toList(),
        );
      },
    );
  }
}
