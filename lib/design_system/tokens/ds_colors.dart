import 'package:flutter/material.dart';

abstract class DsColors {
  // Primary (Teal)
  static const Color primary = Color(0xFF0D9488);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFCCFBF1);
  static const Color onPrimaryContainer = Color(0xFF134E4A);

  // Secondary (Teal 400)
  static const Color secondary = Color(0xFF2DD4BF);
  static const Color onSecondary = Color(0xFF134E4A);
  static const Color secondaryContainer = Color(0xFFCCFBF1);
  static const Color onSecondaryContainer = Color(0xFF134E4A);

  // Tertiary
  static const Color tertiary = Color(0xFF4E6356);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFD0E9D7);
  static const Color onTertiaryContainer = Color(0xFF0B2016);

  // Error
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);

  // Surface hierarchy
  static const Color surface = Color(0xFFF0FDFA);
  static const Color surfaceDim = Color(0xFFE0F2F1);
  static const Color surfaceBright = Color(0xFFF0FDFA);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF8FAFC);
  static const Color surfaceContainer = Color(0xFFF1F5F9);
  static const Color surfaceContainerHigh = Color(0xFFE2E8F0);
  static const Color surfaceContainerHighest = Color(0xFFCBD5E1);
  static const Color onSurface = Color(0xFF0F172A);
  static const Color onSurfaceVariant = Color(0xFF475569);

  // Background
  static const Color background = Color(0xFFF0FDFA);
  static const Color onBackground = Color(0xFF0F172A);

  // Outline
  static const Color outline = Color(0xFF94A3B8);
  static const Color outlineVariant = Color(0xFFCBD5E1);

  // Inverse
  static const Color inverseSurface = Color(0xFF0F172A);
  static const Color inverseOnSurface = Color(0xFFF0FDFA);
  static const Color inversePrimary = Color(0xFF2DD4BF);

  // Misc
  static const Color shadow = Color(0xFF000000);
  static const Color scrim = Color(0xFF000000);
  static const Color surfaceTint = Color(0xFF0D9488);

  // App-specific
  static const Color primaryDim = Color(0xFF0F766E);
}
