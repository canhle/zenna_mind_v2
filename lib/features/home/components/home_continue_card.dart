import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_radius.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';

class HomeContinueCard extends StatelessWidget {
  const HomeContinueCard({super.key});

  static final _borderColor = DsColors.outlineVariant.withValues(alpha: 0.10);

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: DsColors.surfaceContainerLowest,
        borderRadius: DsRadius.borderRadiusLg,
        border: Border.all(color: _borderColor),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(DsSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    l10n.home_continueTitle,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Icon(
                  Icons.play_circle_outline,
                  color: DsColors.primary,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: DsSpacing.md),

            // Track info
            Row(
              children: [
                // Icon
                const DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: DsRadius.borderRadiusLg,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [DsColors.primary, DsColors.primaryLight],
                    ),
                  ),
                  child: SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(Icons.graphic_eq, color: Colors.white),
                  ),
                ),
                const SizedBox(width: DsSpacing.md),

                // Track name + progress
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thư giãn 5 phút',
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: DsSpacing.sm),
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(DsRadius.full),
                        child: const LinearProgressIndicator(
                          value: 0.6,
                          backgroundColor: DsColors.surfaceContainer,
                          color: DsColors.primary,
                          minHeight: 4,
                        ),
                      ),
                      const SizedBox(height: DsSpacing.xs),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '3:00 / 5:00',
                          style: context.textTheme.labelSmall?.copyWith(
                            fontSize: 10,
                            color: DsColors.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
