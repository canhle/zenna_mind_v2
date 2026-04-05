import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/features/streak/streak_view_model.dart';

class StreakStatBadges extends ConsumerWidget {
  const StreakStatBadges({super.key});

  static final _pillBg = Colors.white.withValues(alpha: 0.52);
  static final _pillBorder = DsColors.primary.withValues(alpha: 0.18);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context)!;
    final (days, minutes) = ref.watch(
      streakViewModelProvider.select((s) => (s.streakDays, s.totalMinutes)),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      child: Row(
        children: [
          _Pill(emoji: '🔥', value: '$days', label: ' ${l10n.streak_days}'),
          const SizedBox(width: 10),
          _Pill(emoji: '⏱', value: "$minutes'", label: ' ${l10n.streak_minutes}'),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.emoji,
    required this.value,
    required this.label,
  });

  final String emoji;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: StreakStatBadges._pillBg,
        border: Border.all(color: StreakStatBadges._pillBorder, width: 1.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 15)),
          const SizedBox(width: 6),
          Text(
            value,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: DsColors.onSurface,
            ),
          ),
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              fontSize: 10,
              color: DsColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
