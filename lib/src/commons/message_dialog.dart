import 'package:flutter/material.dart';
import 'package:sa_flutter_flux_sample/src/localization/local_string.dart';

abstract class MessageDialog {
  MessageDialog._();
  static void showError(
    BuildContext context,
    dynamic error,
    StackTrace stackTrace,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(localString.lError),
              Icon(
                Icons.error,
                color: Theme.of(context).colorScheme.error,
              ),
            ],
          ),
          content: Text(
            '$error',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            IconButton(
              onPressed: () => Navigator.pop(dialogContext),
              icon: const Icon(Icons.close),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }

  static Future<bool> confirm(BuildContext context, String message) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(localString.lConfirm),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Text(message),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(localString.lCancel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(localString.lProceed),
            ),
          ],
        );
      },
    ).then((value) => value == true);
  }
}
