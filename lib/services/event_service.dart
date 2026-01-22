// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class EventService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createEvent({
    required String title,
    required String description,
    required String venue,
    required String registrationLink,
    required DateTime dateTime,
    required String creatorId,
  }) async {
    try {
      await _db.collection('events').add({
        'title': title,
        'description': description,
        'venue': venue,
        'registrationLink': registrationLink,
        'dateTime': Timestamp.fromDate(dateTime),
        'creatorId': creatorId,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("❌ Event create failed: $e");
      rethrow;
    }
  }

  Stream<QuerySnapshot> getEvents() {
    return _db
        .collection('events')
        .orderBy('dateTime')
        .snapshots();
  }
}
