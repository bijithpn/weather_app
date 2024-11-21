import 'package:flutter/material.dart';

class UserNotification {
  static late GlobalKey<NavigatorState> _navigatorKey;

  static void init(GlobalKey<NavigatorState> key) {
    _navigatorKey = key;
  }

  static void showSnackBar(String message,
      {Color backgroundColor = Colors.red, SnackBarAction? action}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      action: action,
    );
    if (_navigatorKey.currentContext != null) {
      ScaffoldMessenger.of(_navigatorKey.currentContext!).clearSnackBars();
      ScaffoldMessenger.of(_navigatorKey.currentContext!)
          .showSnackBar(snackBar);
    }
  }

  static void showErrorSnackBar(String errorMessage, {SnackBarAction? action}) {
    showSnackBar(errorMessage, backgroundColor: Colors.red, action: action);
  }

  static void showSuccessSnackBar(String successMessage,
      {SnackBarAction? action}) {
    showSnackBar(successMessage, backgroundColor: Colors.green, action: action);
  }
}
