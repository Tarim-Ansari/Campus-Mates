import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/left_sidebar.dart';
import '../widgets/right_sidebar.dart';
import '../widgets/top_bar.dart';

import '../screens/community_page.dart';
import '../screens/events_page.dart';
import '../screens/category_page.dart';
import '../constants/categories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String myId = FirebaseAuth.instance.currentUser!.uid;
  String selected = Categories.home;

  Widget _buildContent() {
    switch (selected) {
      case Categories.events:
        return EventsPage(myId: myId);

      case Categories.academics:
      case Categories.sports:
      case Categories.campusLife:
        return CategoryPage(
          category: selected,
          myId: myId,
        );

      case Categories.community:
      default:
        return CommunityPage(myId: myId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // ⬅️ LEFT SIDEBAR
          LeftSidebar(
            selected: selected,
            onSelect: (value) {
              setState(() => selected = value);
            },
          ),

          // 🟣 MAIN CONTENT + TOP BAR
          Expanded(
            child: Column(
              children: [
                const TopBar(),
                Expanded(child: _buildContent()),
              ],
            ),
          ),

          // ➡️ RIGHT SIDEBAR
          RightSidebar(myId: myId),
        ],
      ),
    );
  }
}
