import 'package:flutter/material.dart';

class Snackbar {
  static void showSuccessMessage(BuildContext context, String value) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text(value, style: TextStyle(color: Colors.white, fontSize: 14.0)),
        backgroundColor: Colors.green,
        elevation: 8.0));
  }

  static void showErrorMessage(BuildContext context, String value) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text(value, style: TextStyle(color: Colors.white, fontSize: 14.0)),
        backgroundColor: Colors.red,
        elevation: 8.0));
  }
}
