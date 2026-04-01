import 'package:flutter/material.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_radius.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_typography.dart';

abstract class DsTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: DsColors.primary,
        onPrimary: DsColors.onPrimary,
        primaryContainer: DsColors.primaryContainer,
        onPrimaryContainer: DsColors.onPrimaryContainer,
        secondary: DsColors.secondary,
        onSecondary: DsColors.onSecondary,
        secondaryContainer: DsColors.secondaryContainer,
        onSecondaryContainer: DsColors.onSecondaryContainer,
        tertiary: DsColors.tertiary,
        onTertiary: DsColors.onTertiary,
        tertiaryContainer: DsColors.tertiaryContainer,
        onTertiaryContainer: DsColors.onTertiaryContainer,
        error: DsColors.error,
        onError: DsColors.onError,
        errorContainer: DsColors.errorContainer,
        surface: DsColors.surface,
        onSurface: DsColors.onSurface,
        onSurfaceVariant: DsColors.onSurfaceVariant,
        outline: DsColors.outline,
        outlineVariant: DsColors.outlineVariant,
        shadow: DsColors.shadow,
        scrim: DsColors.scrim,
        inverseSurface: DsColors.inverseSurface,
        onInverseSurface: DsColors.inverseOnSurface,
        inversePrimary: DsColors.inversePrimary,
        surfaceTint: DsColors.surfaceTint,
      ),
      textTheme: DsTypography.textTheme,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DsRadius.sm),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: DsSpacing.md,
          vertical: DsSpacing.sm + DsSpacing.xs,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DsRadius.sm),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DsRadius.md),
        ),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: DsColors.primary,
        brightness: Brightness.dark,
      ),
      textTheme: DsTypography.textTheme,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DsRadius.sm),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: DsSpacing.md,
          vertical: DsSpacing.sm + DsSpacing.xs,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DsRadius.sm),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DsRadius.md),
        ),
      ),
    );
  }
}
