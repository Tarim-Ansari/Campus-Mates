// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/profile_page.dart'; // ✅ ADD THIS

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                gradient: AppTheme.accentGradient,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.white),
                  SizedBox(width: 10),
                  Text("SEARCH", style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          const Icon(Icons.notifications_none),
          const SizedBox(width: 20),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            },
            child: const CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xFFE1C8FF),
            ),
          ),
        ],
      ),
    );
  }
}
