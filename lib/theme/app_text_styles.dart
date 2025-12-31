import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Headings
  static TextStyle h1 = GoogleFonts.outfit(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  static TextStyle h2 = GoogleFonts.outfit(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
  );

  static TextStyle h3 = GoogleFonts.outfit(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  // Body Text
  static TextStyle bodyL = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static TextStyle bodyM = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static TextStyle bodyS = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  // Specialized Text
  static TextStyle button = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  static TextStyle caption = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );

  static TextStyle price = GoogleFonts.outfit(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: const Color(0xFF2E7D32),
  );

  static TextStyle tag = GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
}
