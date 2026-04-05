import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/core/router/app_router.dart';
import 'package:flutter_clean_template/design_system/components/ds_button.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';
import 'package:flutter_clean_template/features/player/components/player_background.dart';
import 'package:flutter_clean_template/features/player/player_colors.dart';
import 'package:flutter_clean_template/features/streak/components/streak_calendar_card.dart';
import 'package:flutter_clean_template/features/streak/components/streak_done_card.dart';
import 'package:flutter_clean_template/features/streak/components/streak_quote_section.dart';
import 'package:flutter_clean_template/features/streak/components/streak_stat_badges.dart';
import 'package:flutter_clean_template/features/streak/components/streak_suggest_card.dart';
import 'package:flutter_clean_template/features/streak/components/streak_today_card.dart';
import 'package:flutter_clean_template/core/widgets/glass_top_bar.dart';
import 'package:flutter_clean_template/features/streak/models/streak_ui_state.dart';
import 'package:flutter_clean_template/features/streak/streak_view_model.dart';

class StreakScreen extends ConsumerStatefulWidget {
  const StreakScreen({super.key});

  @override
  ConsumerState<StreakScreen> createState() => _StreakScreenState();
}

class _StreakScreenState extends ConsumerState<StreakScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;
    final isTodayCompleted = ref.watch(
      streakViewModelProvider.select((s) => s.isTodayCompleted),
    );

    ref.listen(streakViewModelProvider, (_, state) {
      final event = state.event;
      if (event == null) return;

      switch (event) {
        case StreakNavigateBack():
          context.pop();
        case StreakNavigateToPlayer():
          context.push(AppRoutes.player);
        case StreakNavigateToHome():
          context.go(AppRoutes.home);
      }

      ref.read(streakViewModelProvider.notifier).consumeEvent();
    });

    return Scaffold(
      backgroundColor: PlayerColors.background,
      body: PlayerBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: DsSpacing.lg),
            child: Column(
              children: [
                GlassTopBar(
                  title: l10n.streak_title,
                  onBackTapped: () => ref
                      .read(streakViewModelProvider.notifier)
                      .onBackTapped(),
                ),
                const StreakStatBadges(),
                const StreakCalendarCard(),
                const SizedBox(height: 12),
                const StreakTodayCard(),
                const SizedBox(height: 12),
                if (!isTodayCompleted)
                  const StreakSuggestCard()
                else
                  const StreakDoneCard(),
                const SizedBox(height: 12),
                const StreakQuoteSection(),
                const SizedBox(height: 12),
                if (!isTodayCompleted)
                  DsButton(
                    label: l10n.streak_startToday,
                    onPressed: () => ref
                        .read(streakViewModelProvider.notifier)
                        .onStartTapped(),
                    isExpanded: true,
                  )
                else ...[
                  DsButton(
                    label: l10n.streak_doAnother,
                    onPressed: () => ref
                        .read(streakViewModelProvider.notifier)
                        .onDoAnotherTapped(),
                    isExpanded: true,
                  ),
                  const SizedBox(height: 10),
                  DsButton(
                    label: l10n.streak_goHome,
                    variant: DsButtonVariant.secondary,
                    onPressed: () => ref
                        .read(streakViewModelProvider.notifier)
                        .onGoHomeTapped(),
                    isExpanded: true,
                  ),
                ],
                const SizedBox(height: DsSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
