import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: const Color(0xFFFF7043), // Same accent color
    secondary: const Color(0xFF2C2C2C), // Deep grey
    tertiary: const Color(0xFF3D3D3D), // Medium grey
    surface: const Color(0xFF1E1E1E), // Deep black
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    inversePrimary: Colors.grey.shade300,
  ),
  scaffoldBackgroundColor: const Color(0xFF121212),
  useMaterial3: true,
  textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
    displayLarge: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white),
    bodyLarge: GoogleFonts.poppins(color: Colors.white),
    bodyMedium: GoogleFonts.poppins(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFF7043),
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF2C2C2C),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Color(0xFFFF7043), width: 2),
    ),
  ),
);
