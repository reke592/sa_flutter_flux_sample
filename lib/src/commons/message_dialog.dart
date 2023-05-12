import 'package:flutter/material.dart';

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
              const Text('Error'),
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
}
