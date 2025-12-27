// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:campus_mates/authentication.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatelessWidget {
  final AuthService _authService = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login page'),
      ),
      body: Column(

        children: [
          TextField(controller: emailController,decoration: InputDecoration(labelText: 'Email'),),
          TextField(controller: passwordController,decoration: InputDecoration(labelText: 'Password'),),

          SizedBox(height: 20,),

          ElevatedButton(
            onPressed: () async {
              await _authService.login(emailController.text, passwordController.text);
            }, child: Text("Login")),

          SizedBox(height: 20,),

          ElevatedButton(
            onPressed: () async {
              await _authService.signup(emailController.text, passwordController.text);
            }, child: Text("Signup")),

        ],
      ),
    );
  }

}