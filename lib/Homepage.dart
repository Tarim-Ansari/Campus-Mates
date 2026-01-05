// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:campus_mates/authentication.dart';
import 'package:campus_mates/firsestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Homepage extends StatelessWidget{
  final AuthService _authService = AuthService();

  Future<DocumentSnapshot> getUserProfile(){
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return FirsestoreService().getUser(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: (Colors.blue),
      appBar: AppBar(title: Text('Home Page'),
      actions: [IconButton(onPressed: _authService.logout, icon: Icon(Icons.logout))],),
      body: 
       Center(
       child: FutureBuilder(
  future: getUserProfile(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) return CircularProgressIndicator();

    var data = snapshot.data!.data() as Map<String, dynamic>;

    return Column(
      children: [
        Text("Email: ${data['email']}"),
        Text("Role: ${data['role']}"),
      ],
    );
  },
)
),
    );
  }
}