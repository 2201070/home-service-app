import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      primaryColor: AppColors.primaryNavy,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryNavy,
        secondary: AppColors.accentOrange,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.primaryNavy,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.figmaNavy,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(color: AppColors.figmaNavy),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.figmaLightGrayBg,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.figmaBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.figmaBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accentOrange, width: 2),
        ),
        hintStyle: const TextStyle(
          color: AppColors.textSecondaryLight,
          fontFamily: 'Inter',
          fontSize: 14,
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: AppTypography.h1.copyWith(color: AppColors.textDark),
        headlineMedium: AppTypography.h2.copyWith(color: AppColors.textDark),
        titleLarge: AppTypography.h3.copyWith(color: AppColors.textDark),
        bodyLarge: AppTypography.body.copyWith(color: AppColors.textDark),
        bodyMedium: AppTypography.body.copyWith(color: AppColors.textDark),
        bodySmall: AppTypography.caption.copyWith(color: AppColors.textSecondaryLight),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      primaryColor: AppColors.accentOrange,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentOrange,
        secondary: AppColors.accentOrange,
        surface: AppColors.surfaceDark,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: AppColors.textLight,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.textLight,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(color: AppColors.textLight),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDark,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accentOrange, width: 2),
        ),
        hintStyle: const TextStyle(
          color: AppColors.textSecondaryDark,
          fontFamily: 'Inter',
          fontSize: 14,
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: AppTypography.h1.copyWith(color: AppColors.textLight),
        headlineMedium: AppTypography.h2.copyWith(color: AppColors.textLight),
        titleLarge: AppTypography.h3.copyWith(color: AppColors.textLight),
        bodyLarge: AppTypography.body.copyWith(color: AppColors.textLight),
        bodyMedium: AppTypography.body.copyWith(color: AppColors.textLight),
        bodySmall: AppTypography.caption.copyWith(color: AppColors.textSecondaryDark),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      useMaterial3: true,
    );
  }
}
