import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// 🔹 INIT (safe, lightweight)
  void init() {
    // reserved for future (FCM / background handlers)
    // keeps HomePage clean
  }

  /// 🔔 SEND NOTIFICATION
  Future<void> send({
    required String toUserId,
    required String title,
    required String body,
    required String type, // chat | post | event
    String? refId,
  }) async {
    final fromUser = _auth.currentUser;
    if (fromUser == null) return;

    await _db.collection('notifications').add({
      'toUserId': toUserId,
      'fromUserId': fromUser.uid,
      'title': title,
      'body': body,
      'type': type,
      'refId': refId,
      'isRead': false,
      'createdAt': Timestamp.now(),
    });
  }

  /// 🔹 STREAM (used by bell & page)
  Stream<QuerySnapshot> getMyNotifications() {
    final uid = _auth.currentUser!.uid;

    return _db
        .collection('notifications')
        .where('toUserId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// 🔹 MARK ALL READ
  Future<void> markAllAsRead() async {
    final uid = _auth.currentUser!.uid;

    final snap = await _db
        .collection('notifications')
        .where('toUserId', isEqualTo: uid)
        .where('isRead', isEqualTo: false)
        .get();

    for (final doc in snap.docs) {
      doc.reference.update({'isRead': true});
    }
  }
}
