import 'package:flutter/material.dart';
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
    return Stack(
      children: [
        StreamBuilder(
          stream: PostService().getPostsByCategory(category),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No posts found"));
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
        ),

        // ✅ POST BUTTON (CATEGORIES ONLY)
        Positioned(
          bottom: 30,
          right: 30,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => CreatePostDialog(category: category),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
