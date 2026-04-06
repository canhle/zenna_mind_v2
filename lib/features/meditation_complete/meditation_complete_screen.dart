import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/core/router/app_router.dart';
import 'package:flutter_clean_template/design_system/components/ds_button.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';
import 'package:flutter_clean_template/features/player/components/player_background.dart';
import 'package:flutter_clean_template/features/player/player_colors.dart';
import 'package:flutter_clean_template/features/meditation_complete/components/completion_ring.dart';
import 'package:flutter_clean_template/features/meditation_complete/components/inspirational_quote.dart';
import 'package:flutter_clean_template/features/meditation_complete/components/mood_selector.dart';
import 'package:flutter_clean_template/features/meditation_complete/components/streak_badge.dart';
import 'package:flutter_clean_template/features/meditation_complete/meditation_complete_view_model.dart';
import 'package:flutter_clean_template/features/meditation_complete/models/meditation_complete_arguments.dart';
import 'package:flutter_clean_template/features/meditation_complete/models/meditation_complete_ui_state.dart';

class MeditationCompleteScreen extends ConsumerStatefulWidget {
  const MeditationCompleteScreen({super.key, required this.args});

  final MeditationCompleteArguments args;

  @override
  ConsumerState<MeditationCompleteScreen> createState() =>
      _MeditationCompleteScreenState();
}

class _MeditationCompleteScreenState
    extends ConsumerState<MeditationCompleteScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;
    final provider = meditationCompleteViewModelProvider(widget.args);
    final (:streakCount, :quoteText, :quoteAuthor) = ref.watch(
      provider.select(
        (s) => (
          streakCount: s.streakCount,
          quoteText: s.quoteText,
          quoteAuthor: s.quoteAuthor,
        ),
      ),
    );

    ref.listen(provider, (_, state) {
      final event = state.event;
      if (event == null) return;

      switch (event) {
        case MeditationCompleteNavigateToBrowse():
          context.go(AppRoutes.browse);
        case MeditationCompleteNavigateToHome():
          context.go(AppRoutes.home);
      }

      ref.read(provider.notifier).consumeEvent();
    });

    return Scaffold(
      backgroundColor: PlayerColors.background,
      body: PlayerBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: DsSpacing.xl,
              right: DsSpacing.xl,
              bottom: DsSpacing.xl,
            ),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      const Spacer(),
                      const CompletionRing(),
                      const SizedBox(height: 28),
                      Text(
                        l10n.meditationComplete_title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lora(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: DsColors.completionText,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 14),
                      StreakBadge(
                        streakText: l10n.home_streakCount(streakCount),
                      ),
                      const SizedBox(height: 18),
                      InspirationalQuote(
                        text: quoteText,
                        author: quoteAuthor,
                      ),
                      const Spacer(),
                      const SizedBox(height: DsSpacing.md),
                      MoodSelector(args: widget.args),
                      const SizedBox(height: 22),
                      DsButton(
                        label: l10n.meditationComplete_nextCta,
                        onPressed: () =>
                            ref.read(provider.notifier).onNextTapped(),
                        size: DsButtonSize.large,
                        isExpanded: true,
                      ),
                      const SizedBox(height: 11),
                      DsButton(
                        label: l10n.meditationComplete_homeCta,
                        onPressed: () =>
                            ref.read(provider.notifier).onHomeTapped(),
                        variant: DsButtonVariant.secondary,
                        size: DsButtonSize.large,
                        isExpanded: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
