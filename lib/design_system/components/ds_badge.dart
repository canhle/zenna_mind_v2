import 'package:flutter/material.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_radius.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';

enum DsBadgeVariant { info, success, warning, error }

class DsBadge extends StatelessWidget {
  const DsBadge({
    super.key,
    required this.label,
    this.variant = DsBadgeVariant.info,
  });

  final String label;
  final DsBadgeVariant variant;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final (backgroundColor, foregroundColor) = switch (variant) {
      DsBadgeVariant.info => (
          colorScheme.primaryContainer,
          colorScheme.onPrimaryContainer,
        ),
      DsBadgeVariant.success => (
          colorScheme.tertiaryContainer,
          colorScheme.onTertiaryContainer,
        ),
      DsBadgeVariant.warning => (
          colorScheme.secondaryContainer,
          colorScheme.onSecondaryContainer,
        ),
      DsBadgeVariant.error => (
          colorScheme.errorContainer,
          colorScheme.onErrorContainer,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DsSpacing.sm,
        vertical: DsSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(DsRadius.xs),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: foregroundColor,
            ),
      ),
    );
  }
}
