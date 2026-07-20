import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static TextStyle get h1 => GoogleFonts.poppins(
        fontSize: 28,
        height: 32 / 28,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get h2 => GoogleFonts.poppins(
        fontSize: 22,
        height: 26 / 22,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get h3 => GoogleFonts.poppins(
        fontSize: 18,
        height: 24 / 18,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get body => GoogleFonts.inter(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get caption => GoogleFonts.inter(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.normal,
      );
}
