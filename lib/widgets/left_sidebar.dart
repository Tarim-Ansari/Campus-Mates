import 'package:flutter/material.dart';

class LeftSidebar extends StatelessWidget {
  const LeftSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff1E3C72), Color(0xff2A5298)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Text(
            "Campus Mates",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),

          sidebarItem(Icons.home, "Home"),
          sidebarItem(Icons.event, "Events"),
          sidebarItem(Icons.people, "Community"),
          sidebarItem(Icons.category, "Categories"),
          sidebarItem(Icons.settings, "Settings"),
          sidebarItem(Icons.logout, "Logout"),
        ],
      ),
    );
  }

  Widget sidebarItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: () {},
    );
  }
}
