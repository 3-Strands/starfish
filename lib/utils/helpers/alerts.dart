import 'package:flutter/material.dart';
import 'package:starfish/constants/strings.dart';

class Alerts {
  static showMessageBox({
    required BuildContext context,
    String? title,
    String? message,
    String? negativeButtonText = Strings.ok,
    String? positiveButtonText = Strings.yes,
    String? neutralButtonText = Strings.no,
    VoidCallback? negativeActionCallback,
    VoidCallback? positiveActionCallback,
    VoidCallback? callback,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? ''),
          content: Text(message ?? ''),
          actions: [
            if (callback != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  callback();
                },
                child: Text(neutralButtonText!),
              ),
            if (negativeActionCallback != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  negativeActionCallback();
                },
                child: Text(negativeButtonText!),
              ),
            if (positiveActionCallback != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  positiveActionCallback();
                },
                child: Text(positiveButtonText!),
              ),
          ],
        );
      },
    );
  }
}
