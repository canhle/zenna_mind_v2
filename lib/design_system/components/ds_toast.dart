import 'package:flutter/material.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';

enum DsToastVariant { info, success, warning, error }

abstract class DsToast {
  static void show(
    BuildContext context, {
    required String message,
    DsToastVariant variant = DsToastVariant.info,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    final (backgroundColor, foregroundColor) = switch (variant) {
      DsToastVariant.info => (
          colorScheme.inverseSurface,
          colorScheme.onInverseSurface,
        ),
      DsToastVariant.success => (
          colorScheme.tertiaryContainer,
          colorScheme.onTertiaryContainer,
        ),
      DsToastVariant.warning => (
          colorScheme.secondaryContainer,
          colorScheme.onSecondaryContainer,
        ),
      DsToastVariant.error => (
          colorScheme.errorContainer,
          colorScheme.onErrorContainer,
        ),
    };

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: TextStyle(color: foregroundColor)),
          backgroundColor: backgroundColor,
          duration: duration,
          action: action,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(DsSpacing.md),
        ),
      );
  }
}
