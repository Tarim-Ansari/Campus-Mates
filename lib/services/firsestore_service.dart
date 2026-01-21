import 'package:cloud_firestore/cloud_firestore.dart';

class FirsestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser({
    required String uid,
    required String email,
  }) async {
    await _db.collection('user').doc(uid).set({
      'uid': uid,
      'email': email,
      'role': 'student',
      'createdAt': Timestamp.now(),
    });
  }
}
