import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HapticButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final bool isLight;

  const HapticButton({
    super.key,
    required this.child,
    required this.onTap,
    this.isLight = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isLight) {
          HapticFeedback.lightImpact();
        } else {
          HapticFeedback.mediumImpact();
        }
        onTap();
      },
      child: child,
    );
  }
}
