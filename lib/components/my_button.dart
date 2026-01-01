import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';
import 'package:thydelivery_mobileapp/theme/design_system.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final Color? color;
  final Color? textColor;
  final bool useGradient;

  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
    this.color,
    this.textColor,
    this.useGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: useGradient ? null : (color ?? Theme.of(context).colorScheme.primary),
            gradient: useGradient ? DesignSystem.primaryGradient : null,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: (color ?? Theme.of(context).colorScheme.primary).withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: AppTextStyles.button.copyWith(
                color: textColor ?? Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

