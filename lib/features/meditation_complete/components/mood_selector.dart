import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/features/meditation_complete/meditation_complete_view_model.dart';
import 'package:flutter_clean_template/features/meditation_complete/models/meditation_complete_arguments.dart';

class MoodSelector extends ConsumerWidget {
  const MoodSelector({super.key, required this.args});

  final MeditationCompleteArguments args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context)!;
    final selectedMoodId = ref.watch(
      meditationCompleteViewModelProvider(args)
          .select((s) => s.selectedMoodId),
    );

    final moods = [
      _MoodOption(id: 'peaceful', emoji: '😌', label: l10n.meditationComplete_moodPeaceful),
      _MoodOption(id: 'refreshed', emoji: '✨', label: l10n.meditationComplete_moodRefreshed),
      _MoodOption(id: 'relaxed', emoji: '😴', label: l10n.meditationComplete_moodRelaxed),
      _MoodOption(id: 'happier', emoji: '🙂', label: l10n.meditationComplete_moodHappier),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.meditationComplete_moodLabel,
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 13,
            color: DsColors.completionText.withValues(alpha: 0.40),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: moods.map((mood) {
            final isSelected = selectedMoodId == mood.id;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: _MoodButton(
                  emoji: mood.emoji,
                  label: mood.label,
                  isSelected: isSelected,
                  onTap: () => ref
                      .read(meditationCompleteViewModelProvider(args).notifier)
                      .onMoodSelected(mood.id),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _MoodOption {
  const _MoodOption({
    required this.id,
    required this.emoji,
    required this.label,
  });

  final String id;
  final String emoji;
  final String label;
}

class _MoodButton extends StatelessWidget {
  const _MoodButton({
    required this.emoji,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String emoji;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xA6FFFFFF) // rgba(255,255,255,0.65)
              : const Color(0x59FFFFFF), // rgba(255,255,255,0.35)
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            width: 1.5,
            color: isSelected
                ? const Color(0x590A643C) // rgba(10,100,60,0.35)
                : Colors.transparent,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 5),
            Text(
              label,
              style: context.textTheme.labelSmall?.copyWith(
                color: DsColors.completionText.withValues(alpha: 0.55),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
