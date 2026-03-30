import 'package:flutter/material.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';

enum DsButtonVariant { primary, secondary, text }
enum DsButtonSize { small, medium, large }

class DsButton extends StatelessWidget {
  const DsButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = DsButtonVariant.primary,
    this.size = DsButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isExpanded = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final DsButtonVariant variant;
  final DsButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final height = switch (size) {
      DsButtonSize.small => 36.0,
      DsButtonSize.medium => 48.0,
      DsButtonSize.large => 56.0,
    };

    final padding = switch (size) {
      DsButtonSize.small => const EdgeInsets.symmetric(horizontal: DsSpacing.sm),
      DsButtonSize.medium => const EdgeInsets.symmetric(horizontal: DsSpacing.md),
      DsButtonSize.large => const EdgeInsets.symmetric(horizontal: DsSpacing.lg),
    };

    final child = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: variant == DsButtonVariant.primary
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.primary,
            ),
          )
        : icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 18),
                  const SizedBox(width: DsSpacing.sm),
                  Text(label),
                ],
              )
            : Text(label);

    final effectiveOnPressed = isLoading ? null : onPressed;

    final style = switch (variant) {
      DsButtonVariant.primary => ElevatedButton.styleFrom(
          minimumSize: Size(isExpanded ? double.infinity : 0, height),
          padding: padding,
        ),
      DsButtonVariant.secondary => OutlinedButton.styleFrom(
          minimumSize: Size(isExpanded ? double.infinity : 0, height),
          padding: padding,
        ),
      DsButtonVariant.text => TextButton.styleFrom(
          minimumSize: Size(isExpanded ? double.infinity : 0, height),
          padding: padding,
        ),
    };

    return switch (variant) {
      DsButtonVariant.primary => ElevatedButton(
          onPressed: effectiveOnPressed,
          style: style,
          child: child,
        ),
      DsButtonVariant.secondary => OutlinedButton(
          onPressed: effectiveOnPressed,
          style: style,
          child: child,
        ),
      DsButtonVariant.text => TextButton(
          onPressed: effectiveOnPressed,
          style: style,
          child: child,
        ),
    };
  }
}
