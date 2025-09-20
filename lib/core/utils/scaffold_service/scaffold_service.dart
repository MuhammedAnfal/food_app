import 'package:flutter/material.dart';

enum SnackbarType { success, error, info }

class SnackbarService {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    Color backgroundColor;

    switch (type) {
      case SnackbarType.success:
        backgroundColor = Colors.green.shade600;
        break;
      case SnackbarType.error:
        backgroundColor = Colors.red.shade600;
        break;
      case SnackbarType.info:
      default:
        backgroundColor = Colors.blue.shade600;
    }

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            type == SnackbarType.success
                ? Icons.check_circle
                : type == SnackbarType.error
                ? Icons.error
                : Icons.info,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      duration: duration,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
