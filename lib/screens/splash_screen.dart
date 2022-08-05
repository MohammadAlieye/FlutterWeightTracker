import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_weight_app/screens/sign_in_screen.dart';

import '../auth_controller/auth_navigation_controller.dart';
import '../navigation_handler/go.dart';
import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashNavigator();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text("Splash",
              style: TextStyle(
                  color: darkOrangeColor,
                  fontSize: 60,
                  fontWeight: FontWeight.w900)),
        ));
  }

  splashNavigator() {
    Timer(const Duration(seconds: 1), () {
      AuthController().checkUserExistence(context);
    });
  }
}
