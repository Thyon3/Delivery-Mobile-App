import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool obscureText;
  final IconData? prefixIcon;
  final String? errorText;

  const MyTextField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.obscureText,
    this.prefixIcon,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: TextField(
          controller: textEditingController,
          obscureText: obscureText,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            prefixIcon: prefixIcon != null 
              ? Icon(prefixIcon, color: Theme.of(context).colorScheme.primary.withOpacity(0.7)) 
              : null,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
              fontWeight: FontWeight.normal,
            ),
            errorText: errorText,
            contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          ),
        ),
      ),
    );
  }
}
