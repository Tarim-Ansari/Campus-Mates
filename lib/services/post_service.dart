import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostService {
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  // ✅ IMAGE UPLOAD
  Future<String> uploadImage(Uint8List imageBytes) async {
    final ref = _storage
        .ref()
        .child("posts")
        .child("${DateTime.now().millisecondsSinceEpoch}.jpg");

    final snapshot = await ref.putData(imageBytes);
    return await snapshot.ref.getDownloadURL();
  }

  // ✅ CREATE POST (NO AUTH CHECK HERE)
  Future<void> createPost({
    required String text,
    required String category,
    required String userEmail,
    String imageUrl = "",
  }) async {
    await _db.collection("posts").add({
      "text": text,
      "category": category,
      "imageUrl": imageUrl,
      "userEmail": userEmail,
      "createdAt": DateTime.now(),
    });
  }

  // ✅ GET POSTS
  Stream<QuerySnapshot> getPosts() {
    return _db
        .collection("posts")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }
}
