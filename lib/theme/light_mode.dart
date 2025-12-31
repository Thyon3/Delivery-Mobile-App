import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  textTheme: GoogleFonts.outfitTextTheme().copyWith(
    displayLarge: GoogleFonts.outfit(fontWeight: FontWeight.bold),
    displayMedium: GoogleFonts.outfit(fontWeight: FontWeight.bold),
    bodyLarge: GoogleFonts.poppins(),
    bodyMedium: GoogleFonts.poppins(),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFF7043),
      foregroundColor: Colors.white,
      minimumSize: const Offset(double.infinity, 56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade100,
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
