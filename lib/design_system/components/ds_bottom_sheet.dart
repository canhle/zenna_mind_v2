import 'package:flutter/material.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_radius.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';

abstract class DsBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool isScrollControlled = false,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(DsRadius.lg),
        ),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(DsSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(DsRadius.full),
                ),
              ),
            ),
            if (title != null) ...[
              const SizedBox(height: DsSpacing.md),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
            const SizedBox(height: DsSpacing.md),
            child,
          ],
        ),
      ),
    );
  }
}
