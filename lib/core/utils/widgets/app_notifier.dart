import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';

class AppNotifier {
  static Color _getBackgroundColor(MessageType type) {
    switch (type) {
      case MessageType.success:
        return AppColors.success;
      case MessageType.error:
        return AppColors.error;
      case MessageType.info:
        return AppColors.info;
      case MessageType.warning:
        return AppColors.warning;
    }
  }

  static IconData _getIconData(MessageType type) {
    switch (type) {
      case MessageType.success:
        return Icons.check_circle;
      case MessageType.error:
        return Icons.error;
      case MessageType.info:
        return Icons.info;
      case MessageType.warning:
        return Icons.warning;
    }
  }

  static void showToast(String message, {MessageType type = MessageType.info}) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: _getBackgroundColor(type),
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void showSnackBar(
    BuildContext context,
    String message, {
    MessageType type = MessageType.info,
  }) {
    final bgColor = _getBackgroundColor(type);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(_getIconData(type), color: AppColors.white),
            const SizedBox(width: 8),
            Text(message, style: const TextStyle(color: AppColors.white)),
          ],
        ),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  static void showDialogMessage(
    BuildContext context, {
    required String title,
    required String message,
    MessageType type = MessageType.info,
  }) {
    final titleColor = _getBackgroundColor(type);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title, style: TextStyle(color: titleColor)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
