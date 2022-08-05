import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weight_app/navigation_handler/go.dart';

import '../screens/home_screen.dart';
import '../screens/sign_in_screen.dart';

class AuthController {
  final _auth = FirebaseAuth.instance;

  void checkUserExistence(BuildContext context) {
    if (_auth.currentUser == null) {
      Go.to(context, const SignInScreen());

      return;
    }
    Go.to(context, const HomeScreen());
  }
}
