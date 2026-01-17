import 'package:flutter/material.dart';
import '../widgets/left_sidebar.dart';
import '../widgets/right_sidebar.dart';
import '../widgets/post_card.dart';
import '../widgets/create_post_dialog.dart';
import '../services/post_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      // ✅ SINGLE POST BUTTON
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const CreatePostDialog(),
          );
        },
        label: const Text("Post"),
        icon: const Icon(Icons.add),
        backgroundColor: const Color(0xff009688),
      ),

      body: Row(
        children: [
          const LeftSidebar(),

          // CENTER FEED
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: StreamBuilder(
                stream: PostService().getPosts(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final posts = snapshot.data!.docs;

                  if (posts.isEmpty) {
                    return const Center(child: Text("No posts yet"));
                  }

                  return ListView(
                    children: [
                      const Text(
                        "TIMELINE",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      ...posts.map((doc) {
                        final data =
                            doc.data() as Map<String, dynamic>;

                        return PostCard(
                          email: data['userEmail'] ?? '',
                          text: data['text'] ?? '',
                          category: data['category'] ?? '',
                          imageUrl: data['imageUrl'] ?? '',
                        );
                      }).toList(),
                    ],
                  );
                },
              ),
            ),
          ),

          const RightSidebar(),
        ],
      ),
    );
  }
}
