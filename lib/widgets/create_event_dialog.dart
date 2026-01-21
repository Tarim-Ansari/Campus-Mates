// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../services/event_service.dart';

class CreateEventDialog extends StatefulWidget {
  final String myId;

  const CreateEventDialog({super.key, required this.myId});

  @override
  State<CreateEventDialog> createState() => _CreateEventDialogState();
}

class _CreateEventDialogState extends State<CreateEventDialog> {
  final _title = TextEditingController();
  final _desc = TextEditingController();
  final _venue = TextEditingController();
  final _link = TextEditingController();

  DateTime? eventDate;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Create Event"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            _field(_title, "Title"),
            _field(_desc, "Description", max: 3),
            _field(_venue, "Venue"),
            _field(_link, "Registration Link"),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2035),
                  initialDate: DateTime.now(),
                );

                if (picked == null) return;

                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (time == null) return;

                setState(() {
                  eventDate = DateTime(
                    picked.year,
                    picked.month,
                    picked.day,
                    time.hour,
                    time.minute,
                  );
                });
              },
              child: Text(
                eventDate == null
                    ? "Pick Date & Time"
                    : eventDate.toString(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: loading
              ? null
              : () async {
                  if (eventDate == null) return;

                  setState(() => loading = true);

                  await EventService().createEvent(
                    title: _title.text.trim(),
                    description: _desc.text.trim(),
                    venue: _venue.text.trim(),
                    registrationLink: _link.text.trim(),
                    eventDate: eventDate!,
                    createdBy: widget.myId,
                  );

                  if (!mounted) return;
                  Navigator.pop(context);
                },
          child: loading
              ? const CircularProgressIndicator()
              : const Text("Create"),
        ),
      ],
    );
  }

  Widget _field(TextEditingController c, String label, {int max = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: c,
        maxLines: max,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
