import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryNavy = Color(0xFF0F2A4A);
  static const Color accentOrange = Color(0xFFF5843A);
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color textDark = Color(0xFF0F2A4A);
  static const Color textSecondaryLight = Color(0xFF7A828A);

  static const Color backgroundDark = Color(0xFF121417);
  static const Color surfaceDark = Color(0xFF1E2124);
  static const Color textLight = Color(0xFFF2F2F2);
  static const Color textSecondaryDark = Color(0xFF9AA0A6);

  static const Color figmaBackground = Color(0xFFF8F9FC);
  static const Color figmaNavy = Color(0xFF00344C);
  static const Color figmaOrange = Color(0xFFFE893C);
  static const Color figmaBrown = Color(0xFF672C00);
  static const Color figmaTextGray = Color(0xFF41474D);
  static const Color figmaBorder = Color(0xFFC1C7CD);
  static const Color figmaLightOrangeBg = Color(0x19FE893C);
  static const Color figmaCardShadow = Color(0x0C1B4B66);
  static const Color figmaShadow = Color(0x0C1B4B66);
  static const Color figmaLightGrayBg = Color(0xFFECEEF0);
}

class AppColor {
  final BuildContext _context;
  const AppColor(this._context);

  bool get _isDark => Theme.of(_context).brightness == Brightness.dark;

  Color get background => _isDark ? AppColors.backgroundDark : AppColors.figmaBackground;
  Color get surface => _isDark ? AppColors.surfaceDark : Colors.white;
  Color get headingText => _isDark ? AppColors.textLight : AppColors.figmaNavy;
  Color get bodyText => _isDark ? AppColors.textLight : AppColors.figmaTextGray;
  Color get secondaryText => _isDark ? AppColors.textSecondaryDark : AppColors.figmaTextGray;
  Color get accent => _isDark ? AppColors.accentOrange : AppColors.figmaOrange;
  Color get brownText => _isDark ? AppColors.textLight : AppColors.figmaBrown;
  Color get border => _isDark
      ? Colors.white.withValues(alpha: 0.08)
      : AppColors.figmaBorder.withValues(alpha: 0.3);

  List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: _isDark
              ? Colors.black.withValues(alpha: 0.3)
              : AppColors.figmaShadow.withValues(alpha: 0.08),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  Color get divider => _isDark
      ? Colors.white.withValues(alpha: 0.08)
      : AppColors.figmaBorder.withValues(alpha: 0.3);
}
