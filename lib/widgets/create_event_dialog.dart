// ignore_for_file: unused_import, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/event_service.dart';

class CreateEventDialog extends StatefulWidget {
  final String myId;

  const CreateEventDialog({super.key, required this.myId});

  @override
  State<CreateEventDialog> createState() => _CreateEventDialogState();
}

class _CreateEventDialogState extends State<CreateEventDialog> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _venue = TextEditingController();
  final _link = TextEditingController();

  DateTime? selectedDate;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Create Event"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: _title, decoration: const InputDecoration(labelText: "Title")),
            TextField(controller: _description, decoration: const InputDecoration(labelText: "Description")),
            TextField(controller: _venue, decoration: const InputDecoration(labelText: "Venue")),
            TextField(controller: _link, decoration: const InputDecoration(labelText: "Registration Link")),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  initialDate: DateTime.now(),
                );

                if (picked == null) return;

                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (time == null) return;

                setState(() {
                  selectedDate = DateTime(
                    picked.year,
                    picked.month,
                    picked.day,
                    time.hour,
                    time.minute,
                  );
                });
              },
              child: Text(
                selectedDate == null
                    ? "Pick Date & Time"
                    : selectedDate.toString(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: loading
              ? null
              : () async {
                  if (_title.text.isEmpty ||
                      _description.text.isEmpty ||
                      _venue.text.isEmpty ||
                      selectedDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Fill all fields")),
                    );
                    return;
                  }

                  setState(() => loading = true);

                  try {
                    await EventService().createEvent(
                      title: _title.text.trim(),
                      description: _description.text.trim(),
                      venue: _venue.text.trim(),
                      registrationLink: _link.text.trim(),
                      dateTime: selectedDate!,
                      creatorId: widget.myId,
                    );

                    if (!mounted) return;
                    Navigator.pop(context); // ✅ CLOSE dialog
                  } catch (e) {
                    setState(() => loading = false);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Failed to create event")),
                    );
                  }
                },
          child: loading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text("Post Event"),
        ),

      ],
    );
  }
}
