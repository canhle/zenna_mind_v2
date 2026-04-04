import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_radius.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';

class HomeDailyCard extends StatelessWidget {
  const HomeDailyCard({super.key, required this.onStartTapped});

  final VoidCallback onStartTapped;

  static final _labelColor = DsColors.onPrimary.withValues(alpha: 0.80);
  static final _durationColor = DsColors.onPrimary.withValues(alpha: 0.60);

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DsSpacing.lg),
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: DsRadius.borderRadiusXxl,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [DsColors.primary, DsColors.primaryLight],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(DsSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top: label + title
                Column(
                  children: [
                    const SizedBox(height: DsSpacing.md),
                    Text(
                      l10n.home_dailyLabel,
                      style: context.textTheme.labelSmall?.copyWith(
                        letterSpacing: 4.0,
                        color: _labelColor,
                      ),
                    ),
                    const SizedBox(height: DsSpacing.md),
                    Text(
                      '10 phút xoa dịu\ncăng thẳng',
                      textAlign: TextAlign.center,
                      style: context.textTheme.headlineMedium?.copyWith(
                        color: DsColors.onPrimary,
                      ),
                    ),
                  ],
                ),

                // Center: start button
                Material(
                  color: DsColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(DsRadius.full),
                  elevation: 8,
                  child: InkWell(
                    onTap: onStartTapped,
                    borderRadius: BorderRadius.circular(DsRadius.full),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.play_arrow,
                            color: DsColors.primary,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            l10n.home_startButton,
                            style: context.textTheme.labelLarge?.copyWith(
                              fontSize: 18,
                              color: DsColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Bottom: duration
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.timer_outlined, size: 14, color: _durationColor),
                    const SizedBox(width: DsSpacing.xs),
                    Text(
                      '10 Phút • Sơ cấp',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: _durationColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
