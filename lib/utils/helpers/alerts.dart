import 'package:flutter/material.dart';
import 'package:starfish/constants/strings.dart';

class Alerts {
  static showMessageBox({
    required BuildContext context,
    String? title,
    String? message,
    VoidCallback? callback,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? ''),
          content: Text(message ?? ''),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (callback != null) {
                  callback();
                }
              },
              child: Text(Strings.ok),
            ),
          ],
        );
      },
    );
  }
}
