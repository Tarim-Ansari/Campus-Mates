import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/post_service.dart';

class CreatePostDialog extends StatefulWidget {
  const CreatePostDialog({super.key});

  @override
  State<CreatePostDialog> createState() => _CreatePostDialogState();
}

class _CreatePostDialogState extends State<CreatePostDialog> {
  final TextEditingController _textController = TextEditingController();
  String selectedCategory = "General";
  Uint8List? imageBytes;
  bool isLoading = false;

  final categories = [
    "General",
    "Academics",
    "Sports",
    "Campus Life",
    "Help",
  ];

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      imageBytes = await picked.readAsBytes();
      setState(() {});
    }
  }

  Future<void> submitPost() async {
    final text = _textController.text.trim();
    final user = FirebaseAuth.instance.currentUser;

    if (text.isEmpty || user == null) return;

    setState(() => isLoading = true);

    String imageUrl = "";

    if (imageBytes != null) {
      imageUrl = await PostService().uploadImage(imageBytes!);
    }

    await PostService().createPost(
      text: text,
      category: selectedCategory,
      imageUrl: imageUrl,
      userEmail: user.email!,
    );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Create Post"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _textController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: "What's on your mind?",
            ),
          ),
          const SizedBox(height: 10),

          DropdownButton<String>(
            value: selectedCategory,
            items: categories
                .map((c) => DropdownMenuItem(
                      value: c,
                      child: Text(c),
                    ))
                .toList(),
            onChanged: (val) => setState(() => selectedCategory = val!),
          ),

          const SizedBox(height: 10),

          ElevatedButton.icon(
            onPressed: pickImage,
            icon: const Icon(Icons.image),
            label: const Text("Add Image"),
          ),

          if (imageBytes != null)
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text("Image Selected ✅"),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: isLoading ? null : submitPost,
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text("Post"),
        ),
      ],
    );
  }
}
