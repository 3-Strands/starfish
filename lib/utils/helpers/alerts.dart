import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Alerts {
  static showMessageBox({
    required BuildContext context,
    String? title,
    String? message,
    String? negativeButtonText,
    String? positiveButtonText,
    String? neutralButtonText,
    VoidCallback? negativeActionCallback,
    VoidCallback? positiveActionCallback,
    VoidCallback? callback,
  }) {
    final AppLocalizations _appLocalizations = AppLocalizations.of(context)!;
    return showDialog(
      context: context,
      barrierDismissible: false,
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
                child: Text(neutralButtonText ?? _appLocalizations.ok),
              ),
            if (negativeActionCallback != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  negativeActionCallback();
                },
                child: Text(negativeButtonText ?? _appLocalizations.no),
              ),
            if (positiveActionCallback != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  positiveActionCallback();
                },
                child: Text(positiveButtonText ?? _appLocalizations.yes),
              ),
          ],
        );
      },
    );
  }
}
