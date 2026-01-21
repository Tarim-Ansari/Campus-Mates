import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/event_service.dart';
import '../widgets/event_card.dart';
import '../widgets/create_event_dialog.dart';

class EventsPage extends StatelessWidget {
  final String myId;

  const EventsPage({
    super.key,
    required this.myId,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: EventService().getEvents(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No events found"));
            }

            return ListView(
              padding: const EdgeInsets.all(20),
              children: snapshot.data!.docs.map((doc) {
                return EventCard(
                  data: doc.data() as Map<String, dynamic>,
                );
              }).toList(),
            );

          },
        ),

        // ✅ CREATE EVENT BUTTON (EVENTS ONLY)
        Positioned(
          bottom: 30,
          right: 30,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => CreateEventDialog(myId: myId),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
