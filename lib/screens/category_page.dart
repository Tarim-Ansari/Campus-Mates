import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/post_service.dart';
import '../widgets/post_card.dart';
import '../widgets/create_post_dialog.dart';

class CategoryPage extends StatelessWidget {
  final String category;
  final String myId;

  const CategoryPage({
    super.key,
    required this.category,
    required this.myId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: PostService().getPostsByCategory(category),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.only(bottom: 90),
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
      ),

      // ✅ POST BUTTON (same as Events page)
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE1C8FF),
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => CreatePostDialog(category: category),
          );
        },
      ),
    );
  }
}
