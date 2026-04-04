import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_radius.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';

class HomeStreakCard extends StatelessWidget {
  const HomeStreakCard({super.key});

  static final _borderColor = DsColors.outlineVariant.withValues(alpha: 0.05);
  static final _fireBgColor = DsColors.primary.withValues(alpha: 0.10);
  static final _dotInactiveColor =
      DsColors.outlineVariant.withValues(alpha: 0.30);

  // Mock: which days are active (Mon-Sun)
  static const _weekDots = [true, false, true, true, false, false, true];

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: DsColors.surfaceContainerLow,
        borderRadius: DsRadius.borderRadiusLg,
        border: Border.all(color: _borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(DsSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.home_streakTitle,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: DsSpacing.xs),
                      Text(
                        l10n.home_streakCount(4),
                        style: context.textTheme.labelSmall?.copyWith(
                          color: DsColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: _fireBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(DsSpacing.sm),
                    child: Icon(
                      Icons.local_fire_department,
                      color: DsColors.primary,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: DsSpacing.md),

            // Week dots + label
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: _weekDots.map((active) {
                    return Padding(
                      padding: const EdgeInsets.only(right: DsSpacing.sm),
                      child: _Dot(active: active),
                    );
                  }).toList(),
                ),
                Text(
                  l10n.home_streakWeek,
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: DsColors.primary,
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

class _Dot extends StatelessWidget {
  const _Dot({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: active
            ? const LinearGradient(
                colors: [DsColors.primary, DsColors.primaryLight],
              )
            : null,
        color: active ? null : HomeStreakCard._dotInactiveColor,
      ),
    );
  }
}
