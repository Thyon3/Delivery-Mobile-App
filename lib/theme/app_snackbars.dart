import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';

class AppSnackbars {
  static void showSuccess(BuildContext context, String message) {
    _showCustomSnackBar(
      context: context,
      message: message,
      icon: Icons.check_circle_rounded,
      backgroundColor: const Color(0xFF4CAF50),
    );
  }

  static void showError(BuildContext context, String message) {
    _showCustomSnackBar(
      context: context,
      message: message,
      icon: Icons.error_outline_rounded,
      backgroundColor: const Color(0xFFE53935),
    );
  }

  static void showWarning(BuildContext context, String message) {
    _showCustomSnackBar(
      context: context,
      message: message,
      icon: Icons.warning_amber_rounded,
      backgroundColor: const Color(0xFFFFA000),
    );
  }

  static void showInfo(BuildContext context, String message) {
    _showCustomSnackBar(
      context: context,
      message: message,
      icon: Icons.info_outline_rounded,
      backgroundColor: const Color(0xFF1976D2),
    );
  }

  static void _showCustomSnackBar({
    required BuildContext context,
    required String message,
    required IconData icon,
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: AppTextStyles.bodyM.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
