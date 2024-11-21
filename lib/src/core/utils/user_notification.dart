import 'package:flutter/material.dart';

class UserNotification {
  static late GlobalKey<NavigatorState> _navigatorKey;

  static void init(GlobalKey<NavigatorState> key) {
    _navigatorKey = key;
  }

  static void showSnackBar(String message,
      {Color backgroundColor = Colors.black, SnackBarAction? action}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      action: action,
    );
    if (_navigatorKey.currentContext != null) {
      ScaffoldMessenger.of(_navigatorKey.currentContext!).clearSnackBars();
      ScaffoldMessenger.of(_navigatorKey.currentContext!)
          .showSnackBar(snackBar);
    }
  }

  static void showMaterialBanner(String message, {SnackBarAction? action}) {
    MaterialBanner materialBanner = MaterialBanner(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      actions: const [SizedBox()],
    );
    if (_navigatorKey.currentContext != null) {
      ScaffoldMessenger.of(_navigatorKey.currentContext!)
          .hideCurrentMaterialBanner();
      ScaffoldMessenger.of(_navigatorKey.currentContext!)
          .showMaterialBanner(materialBanner);
    }
  }

  static void showErrorSnackBar(String errorMessage, {SnackBarAction? action}) {
    showSnackBar(errorMessage, action: action);
  }

  static void showBanner(String errorMessage, {SnackBarAction? action}) {
    showMaterialBanner(errorMessage, action: action);
  }

  static void hideBanner() {
    ScaffoldMessenger.of(_navigatorKey.currentContext!)
        .hideCurrentMaterialBanner();
  }

  static void showSuccessSnackBar(String successMessage,
      {SnackBarAction? action}) {
    showSnackBar(successMessage, action: action);
  }
}
