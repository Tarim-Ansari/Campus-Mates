import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ================= POSTS =================

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
      'likes': [],
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getCommunityPosts() {
    return _db
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getPostsByCategory(String category) {
    return _db
        .collection('posts')
        .where('category', isEqualTo: category)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // ================= LIKES =================

  Future<void> toggleLike(String postId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final postRef = _db.collection('posts').doc(postId);

    await _db.runTransaction((transaction) async {
      final snapshot = await transaction.get(postRef);
      if (!snapshot.exists) return;

      final data = snapshot.data()!;
      final List likes = List.from(data['likes'] ?? []);

      if (likes.contains(user.uid)) {
        transaction.update(postRef, {
          'likes': FieldValue.arrayRemove([user.uid]),
        });
      } else {
        transaction.update(postRef, {
          'likes': FieldValue.arrayUnion([user.uid]),
        });
      }
    });
  }

  // ================= COMMENTS =================

  Stream<QuerySnapshot> getComments(String postId) {
    return _db
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> addComment(String postId, String text) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _db
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add({
      'text': text,
      'userId': user.uid,
      'userEmail': user.email,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
