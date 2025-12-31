import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: const Color(0xFFFF7043), // Same accent color
    secondary: const Color(0xFF2C2C2C), // Deep grey
    tertiary: const Color(0xFF3D3D3D), // Medium grey
    surface: const Color(0xFF1E1E1E), // Near black
    background: const Color(0xFF121212), // Deep black
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    inversePrimary: Colors.grey.shade300,
  ),
  scaffoldBackgroundColor: const Color(0xFF121212),
  useMaterial3: true,
);
