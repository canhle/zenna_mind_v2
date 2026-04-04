import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';
import 'package:flutter_clean_template/features/home/components/home_mood_item.dart';
import 'package:flutter_clean_template/features/home/home_view_model.dart';
import 'package:flutter_clean_template/features/home/models/home_ui_state.dart';

class HomeMoodSelector extends ConsumerWidget {
  const HomeMoodSelector({super.key});

  static final _happyBg = DsColors.primaryContainer.withValues(alpha: 0.40);
  static final _anxiousBg =
      DsColors.secondaryContainer.withValues(alpha: 0.50);
  static final _stressedBg = DsColors.errorContainer.withValues(alpha: 0.40);
  static final _peacefulBg = DsColors.primary.withValues(alpha: 0.20);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context)!;
    final selectedMood = ref.watch(
      homeViewModelProvider.select((s) => s.selectedMood),
    );

    final moods = [
      _MoodData(MoodType.happy, '😄', l10n.home_moodHappy, _happyBg),
      _MoodData(MoodType.anxious, '😟', l10n.home_moodAnxious, _anxiousBg),
      _MoodData(
        MoodType.tired,
        '😴',
        l10n.home_moodTired,
        DsColors.surfaceContainerHigh,
      ),
      _MoodData(
        MoodType.stressed,
        '😡',
        l10n.home_moodStressed,
        _stressedBg,
      ),
      _MoodData(MoodType.peaceful, '😌', l10n.home_moodPeaceful, _peacefulBg),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DsSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.home_moodLabel,
            style: context.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 3.0,
              color: DsColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: DsSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: moods.map((mood) {
              return HomeMoodItem(
                emoji: mood.emoji,
                label: mood.label,
                backgroundColor: mood.backgroundColor,
                isSelected: selectedMood == mood.type,
                onTap: () => ref
                    .read(homeViewModelProvider.notifier)
                    .onMoodSelected(mood.type),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _MoodData {
  const _MoodData(this.type, this.emoji, this.label, this.backgroundColor);
  final MoodType type;
  final String emoji;
  final String label;
  final Color backgroundColor;
}
