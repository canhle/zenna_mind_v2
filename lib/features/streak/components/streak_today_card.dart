import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_radius.dart';
import 'package:flutter_clean_template/features/streak/models/streak_mock_data.dart';
import 'package:flutter_clean_template/features/streak/streak_view_model.dart';

class StreakTodayCard extends ConsumerWidget {
  const StreakTodayCard({super.key});

  static final _cardBg = Colors.white.withValues(alpha: 0.38);
  static final _cardBorder = Colors.white.withValues(alpha: 0.50);
  static final _iconDoneBg = DsColors.primaryDim.withValues(alpha: 0.15);
  static final _badgeBg = DsColors.primaryDim.withValues(alpha: 0.10);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context)!;
    final isTodayCompleted = ref.watch(
      streakViewModelProvider.select((s) => s.isTodayCompleted),
    );

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _cardBg,
        border: Border.all(color: _cardBorder),
        borderRadius: DsRadius.borderRadiusLg,
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isTodayCompleted ? _iconDoneBg : DsColors.primaryDim,
              borderRadius: DsRadius.borderRadiusMd,
            ),
            child: Icon(
              isTodayCompleted ? Icons.check : Icons.access_time,
              size: 22,
              color: isTodayCompleted ? DsColors.primaryDim : Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.streak_today,
                  style: context.textTheme.labelSmall?.copyWith(
                    letterSpacing: 1.0,
                    color: DsColors.outline,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isTodayCompleted
                      ? l10n.streak_completed
                      : mockTodayDate,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: DsColors.onSurface,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  isTodayCompleted
                      ? '$mockDoneSessionTitle · $mockSuggestDuration'
                      : l10n.streak_notDoneYet,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: DsColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: _badgeBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              isTodayCompleted
                  ? '${l10n.streak_dayCount(7)} ✓'
                  : l10n.streak_dayCount(7),
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: DsColors.primaryDim,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
