// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:campus_mates/services/firsestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 🔹 SIGN UP
  Future<User?> signup(String email, String password) async {
    try {
      print("SIGNUP STARTED");

      UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      print("AUTH USER CREATED: ${user?.uid}");

      if (user != null) {
        print("WRITING USER TO FIRESTORE...");
        await FirsestoreService().createUser(
          uid: user.uid,
          email: user.email!,
        );
        print("USER WRITE COMPLETED");
      }

      return user;
    } catch (e) {
      print("SIGNUP ERROR: $e");
      return null;
    }
  }


  // 🔹 LOGIN (🔥 FIXED)
  Future<User?> login(String email, String password) async {
    try {
      UserCredential credential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user != null) {
        // 🔥 ENSURE USER EXISTS IN FIRESTORE
        final docRef = _db.collection('user').doc(user.uid);
        final snap = await docRef.get();

        if (!snap.exists) {
          await FirsestoreService().createUser(
            uid: user.uid,
            email: user.email!,
          );
        }
      }

      return user;
    } catch (e) {
      print("Login error: $e");
      return null;
    }
  }

  // 🔹 LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }

  // 🔹 AUTH STATE
  Stream<User?> get authStateChanges {
    return _auth.authStateChanges();
  }
}
