// ignore_for_file: unreachable_switch_case

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants/categories.dart';
import '../widgets/left_sidebar.dart';
import '../widgets/right_sidebar.dart';
import '../widgets/top_bar.dart';

import '../chat/chat_list_page.dart';
import 'community_page.dart';
import 'category_page.dart';
import 'events_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selected = Categories.home;
  late final String myId;

  @override
  void initState() {
    super.initState();
    myId = FirebaseAuth.instance.currentUser!.uid;
  }

  Widget _buildContent() {
    switch (selected) {
      case Categories.chats:
        return ChatListPage(myId: myId);

      case Categories.community:
        return CommunityPage(myId: myId);

      case Categories.events:
        return EventsPage(myId: myId);

      case Categories.academics:
      case Categories.sports:
      case Categories.campusLife:
      case Categories.community:
        return CategoryPage(
          category: selected,
          myId: myId,
        );


      default:
        return CommunityPage(myId: myId);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          LeftSidebar(
            selected: selected,
            onSelect: (value) {
              setState(() => selected = value);
            },
          ),
          Expanded(
            child: Column(
              children: [
                const TopBar(),
                Expanded(child: _buildContent()),
              ],
            ),
          ),
          RightSidebar(myId: myId),
        ],
      ),
    );
  }
}
