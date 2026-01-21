import 'package:cloud_firestore/cloud_firestore.dart';


class EventService {
  final _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getEvents() {
    return _db
        .collection('events')
        .orderBy('eventDate')
        .snapshots();
  }

  Future<void> createEvent({
    required String title,
    required String description,
    required String venue,
    required String registrationLink,
    required DateTime eventDate,
    required String createdBy,
  }) async {
    await _db.collection('events').add({
      'title': title,
      'description': description,
      'venue': venue,
      'registrationLink': registrationLink,
      'eventDate': Timestamp.fromDate(eventDate),
      'createdBy': createdBy,
      'createdAt': Timestamp.now(),
    });
  }
}
