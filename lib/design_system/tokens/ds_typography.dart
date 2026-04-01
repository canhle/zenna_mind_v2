import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class DsTypography {
  static TextTheme get textTheme {
    final headlineTextTheme = GoogleFonts.plusJakartaSansTextTheme();
    final bodyTextTheme = GoogleFonts.manropeTextTheme();

    return TextTheme(
      displayLarge: headlineTextTheme.displayLarge!.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
      ),
      displayMedium: headlineTextTheme.displayMedium!.copyWith(
        fontWeight: FontWeight.w700,
      ),
      displaySmall: headlineTextTheme.displaySmall!.copyWith(
        fontWeight: FontWeight.w600,
      ),
      headlineLarge: headlineTextTheme.headlineLarge!.copyWith(
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: headlineTextTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: headlineTextTheme.headlineSmall!.copyWith(
        fontWeight: FontWeight.w600,
      ),
      titleLarge: headlineTextTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w600,
      ),
      titleMedium: bodyTextTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      titleSmall: bodyTextTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      bodyLarge: bodyTextTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyMedium: bodyTextTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      bodySmall: bodyTextTheme.bodySmall!.copyWith(
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      labelLarge: bodyTextTheme.labelLarge!.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
      labelMedium: bodyTextTheme.labelMedium!.copyWith(
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
      labelSmall: bodyTextTheme.labelSmall!.copyWith(
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
    );
  }
}
