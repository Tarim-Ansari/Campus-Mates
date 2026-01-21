import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ✅ CREATE POST
  Future<void> createPost({
    required String text,
    required String category,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _db.collection('posts').add({
      'text': text,
      'category': category,
      'userId': user.uid,
      'userEmail': user.email,
      'imageUrl': '',
      'createdAt': Timestamp.now(),
    });
  }

  // ✅ COMMUNITY POSTS
  Stream<QuerySnapshot> getCommunityPosts() {
    return _db
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // ✅ POSTS BY CATEGORY
  Stream<QuerySnapshot> getPostsByCategory(String category) {
    return _db
        .collection('posts')
        .where('category', isEqualTo: category)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
