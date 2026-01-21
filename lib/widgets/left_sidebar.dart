// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants/categories.dart';

class LeftSidebar extends StatelessWidget {
  final String selected;
  final Function(String) onSelect;

  const LeftSidebar({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  Widget item(
    BuildContext context,
    String value,
    String label,
  ) {
    final active = selected == value;

    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: active
          ? Container(width: 4, height: 20, color: Colors.white)
          : null,
      onTap: () async {
        if (value == "logout") {
          await FirebaseAuth.instance.signOut();
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (_) => false);
          return;
        }

        onSelect(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0E2A47), Color(0xFF3B0F52)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Image.asset("assets/images/logo.png", height: 80),
          const SizedBox(height: 30),

          item(context, Categories.home, "Home"),
          item(context, Categories.community, "Community"),
          item(context, Categories.chats, "Chats"),

          ExpansionTile(
            title: const Text(
              "Categories",
              style: TextStyle(color: Colors.white),
            ),
            iconColor: Colors.white,
            children: [
              item(context, Categories.academics, "Academics"),
              item(context, Categories.sports, "Sports"),
              item(context, Categories.campusLife, "Campus Life"),
            ],
          ),

          item(context, Categories.events, "Events"),

          const Spacer(),
          item(context, "settings", "Settings"),
          item(context, "logout", "Logout"),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
