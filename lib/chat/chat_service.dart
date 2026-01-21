import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 🔹 Create or get chat ID
  String getChatId(String a, String b) {
    return a.hashCode <= b.hashCode ? '${a}_$b' : '${b}_$a';
  }

  // 🔹 Send message
  Future<void> sendMessage(String otherUserId, String text) async {
    final myId = FirebaseAuth.instance.currentUser!.uid;
    final chatId = getChatId(myId, otherUserId);

    final chatRef = _db.collection('chats').doc(chatId);

    await chatRef.set({
      'users': [myId, otherUserId],
      'lastMessage': text,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    await chatRef.collection('messages').add({
      'senderId': myId,
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // 🔹 Messages stream
  Stream<QuerySnapshot> getMessages(String otherUserId) {
    final myId = FirebaseAuth.instance.currentUser!.uid;
    final chatId = getChatId(myId, otherUserId);

    return _db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt')
        .snapshots();
  }

  // 🔹 MY CHATS (🔥 FIXED – requires myId passed)
  Stream<QuerySnapshot> getMyChats(String myId) {
    return _db
        .collection('chats')
        .where('users', arrayContains: myId)
        .orderBy('updatedAt', descending: true)
        .snapshots();
  }
}
