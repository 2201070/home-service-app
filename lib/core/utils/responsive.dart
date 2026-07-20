import 'package:flutter/material.dart';

/// Responsive breakpoint helpers for consistent sizing across device widths.
extension ResponsiveExtensions on BuildContext {
  /// Screen width in logical pixels.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Screen height in logical pixels.
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// True if the screen width is less than 600 (phone).
  bool get isMobile => screenWidth < 600;

  /// True if the screen width is between 600 and 1024 (tablet).
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;

  /// True if the screen width is 1024 or more (desktop).
  bool get isDesktop => screenWidth >= 1024;

  /// Height scaled proportionally to the screen height.
  double scaledHeight(double fraction) => screenHeight * fraction;

  /// Width scaled proportionally to the screen width.
  double scaledWidth(double fraction) => screenWidth * fraction;
}
