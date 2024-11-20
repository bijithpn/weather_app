import 'package:flutter/material.dart';

class UserNotification {
  static late GlobalKey<NavigatorState> _navigatorKey;

  static void init(GlobalKey<NavigatorState> key) {
    _navigatorKey = key;
  }

  static void showSnackBar(String message,
      {Color backgroundColor = Colors.red}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    );
    if (_navigatorKey.currentContext != null) {
      ScaffoldMessenger.of(_navigatorKey.currentContext!).clearSnackBars();
      ScaffoldMessenger.of(_navigatorKey.currentContext!)
          .showSnackBar(snackBar);
    }
  }

  static void showErrorSnackBar(String errorMessage) {
    showSnackBar(errorMessage, backgroundColor: Colors.red);
  }

  static void showSuccessSnackBar(String successMessage) {
    showSnackBar(successMessage, backgroundColor: Colors.green);
  }
}
