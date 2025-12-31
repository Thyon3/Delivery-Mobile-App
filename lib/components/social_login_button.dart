import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String logoPath;
  final String label;
  final VoidCallback onTap;

  const SocialLoginButton({
    super.key,
    required this.logoPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Placeholder - In a real app, use SvgPicture or Image.asset
              Icon(
                label == 'Google' ? Icons.g_mobiledata : Icons.apple,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
