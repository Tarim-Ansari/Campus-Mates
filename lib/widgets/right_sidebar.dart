// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class RightSidebar extends StatelessWidget {
  final String myId;
  const RightSidebar({super.key, required this.myId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(color: Color(0xFFEAEAEA)),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== HEADER CONTAINER =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: [Color(0xFFEADCF8), Color(0xFFF7EEFF)],
                ),
              ),
              child: const Center(
                child: Text(
                  "Campus Mates",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8E44AD),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 26),

            // ===== RECENT CHATS =====
            _sectionHeader("Recent Chats", Icons.notifications_none),
            const SizedBox(height: 14),

            _chatCard(
              name: "Amaan",
              message: "Joining the event?",
              imagePath: "assets/profile_images/amaan.jpeg",
            ),
            _chatCard(
              name: "Wasim",
              message: "Submission today 😭",
              imagePath: "assets/profile_images/wasim.jpeg",
            ),
            _chatCard(
              name: "Riya",
              message: "Can you share notes?",
              imagePath: "assets/profile_images/riya.jpeg",
            ),

            const SizedBox(height: 30),

            // ===== UPCOMING EVENTS =====
            _sectionHeader("Upcoming Events", Icons.calendar_today),
            const SizedBox(height: 14),

            _eventCard(
              title: "Hackathon 2026",
              date: "29 Jan · 2:00 PM",
              timeLeft: "6d 25h left",
            ),
            _eventCard(
              title: "AI Workshop",
              date: "30 Jan · 11:00 AM",
              timeLeft: "7d 1h left",
            ),
            _eventCard(
              title: "Sports Meet",
              date: "1 Feb · 9:00 AM",
              timeLeft: "9d left",
            ),
          ],
        ),
      ),
    );
  }

  // ================== HELPERS ==================

  Widget _sectionHeader(String text, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(icon, size: 18, color: Colors.grey),
      ],
    );
  }

  // ===== CHAT CARD (IMAGE ONLY ADDED) =====
  Widget _chatCard({
    required String name,
    required String message,
    String? imagePath,
  }) {
    return Container(
      height: 64,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7D3C98), Color(0xFF9B59B6)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFEADCF8),
            backgroundImage:
                imagePath != null ? AssetImage(imagePath) : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===== EVENT CARD (UNCHANGED) =====
  Widget _eventCard({
    required String title,
    required String date,
    required String timeLeft,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE6F7F6), Color(0xFFF3FCFB)],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              date,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              timeLeft,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
