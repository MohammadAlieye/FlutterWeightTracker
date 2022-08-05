import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastOverlay {
  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
    );
  }
}
