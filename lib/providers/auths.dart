import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/models/user_class.dart';

class AuthProvider with ChangeNotifier {
  final authServices = FirebaseAuth.instance;
  UserName? user;

  void logIn(mailController, passwordController) {
    try {
      authServices.signInWithEmailAndPassword(
        email: mailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } catch (e) {
      throw const CircularProgressIndicator();
    }
  }

  Future<void> getUserById(String id) async {
    final documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    final json = documentSnapshot.data();
    user = UserName.fromJson(json!);
    notifyListeners();
  }
}
