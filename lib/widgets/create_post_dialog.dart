// ignore_for_file: unused_import, use_build_context_synchronously

import 'package:flutter/material.dart';
import '../services/post_service.dart';
import '../constants/categories.dart';

class CreatePostDialog extends StatefulWidget {
  final String category;

  const CreatePostDialog({
    super.key,
    required this.category,
  });

  @override
  State<CreatePostDialog> createState() => _CreatePostDialogState();
}

class _CreatePostDialogState extends State<CreatePostDialog> {
  final TextEditingController _textController = TextEditingController();
  final PostService _postService = PostService();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Create Post"),
      content: TextField(
        controller: _textController,
        maxLines: 4,
        decoration: const InputDecoration(
          hintText: "What's on your mind?",
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: isLoading
              ? null
              : () async {
                  if (_textController.text.trim().isEmpty) return;

                  setState(() => isLoading = true);

                  await _postService.createPost(
                    text: _textController.text.trim(),
                    category: widget.category,
                  );


                  if (!mounted) return;
                  Navigator.pop(context);
                },
          child: isLoading
              ? const CircularProgressIndicator()
              : const Text("Post"),
        ),
      ],
    );
  }
}
