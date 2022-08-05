import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthenticationWithEmailAndPassword {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

//////////////////////////sign up method

  Future signUp({String? email, String? password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } on PlatformException catch (e) {
      return e.message;
    } on SocketException catch (e) {
      return e.message;
    }
  }
  //////////////////////////sign in method


  Future signIn({String? email, String? password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } on PlatformException catch (e) {
      return e.message;
    } on SocketException catch (e) {
      return e.message;
    }
  }

  ////////////////// sign out
  Future signOut() async {
    await _auth.signOut();

    print('signed out');
  }
}
