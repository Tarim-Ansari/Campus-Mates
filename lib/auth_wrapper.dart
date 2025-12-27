// ignore_for_file: use_key_in_widget_constructors, camel_case_types

import 'package:campus_mates/Homepage.dart';
import 'package:campus_mates/authentication.dart';
import 'package:campus_mates/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'auth_service.dart';

class Auth_wrapper extends StatelessWidget{
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder <User?>(
      stream: _authService.authStateChanges,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Scaffold(
            body: Center(child: CircularProgressIndicator(),),
          );
        }
        if(snapshot.hasData){
          return Homepage();
        }
        else {
          return Loginpage();
        }
      },
    );
    
  }
}