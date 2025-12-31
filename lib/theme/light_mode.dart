import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    primary: const Color(0xFFFF7043), // Premium Coral/Orange
    secondary: const Color(0xFFFFAB91), // Lighter Coral
    tertiary: Colors.white,
    surface: Colors.grey.shade100,
    background: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade900,
  ),
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,
);
