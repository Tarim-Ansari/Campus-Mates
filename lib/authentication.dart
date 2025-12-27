// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signup (String email, String password)async{
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password);
      return credential.user;
    }
    catch(e){
      print(e);
      return null;
    }
  }

  Future<User?> login (String email, String password) async {
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<void> logout () async{
    await _auth.signOut();
  }

  Stream <User?> get authStateChanges{
    return _auth.authStateChanges();
  }
}