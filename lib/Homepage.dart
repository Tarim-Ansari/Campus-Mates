// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:campus_mates/authentication.dart';
import 'package:flutter/material.dart';


class Homepage extends StatelessWidget{
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page'),
      actions: [IconButton(onPressed: _authService.logout, icon: Icon(Icons.logout))],),
      body: Center(child: Text("You are sucessfully Logged in")),
    );
  }
}