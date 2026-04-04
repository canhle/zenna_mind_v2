import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';
import 'package:flutter_clean_template/features/home/components/home_app_bar.dart';
import 'package:flutter_clean_template/features/home/components/home_continue_card.dart';
import 'package:flutter_clean_template/features/home/components/home_daily_card.dart';
import 'package:flutter_clean_template/features/home/components/home_greeting_section.dart';
import 'package:flutter_clean_template/features/home/components/home_mood_selector.dart';
import 'package:flutter_clean_template/features/home/components/home_quote_section.dart';
import 'package:flutter_clean_template/features/home/components/home_streak_card.dart';
import 'package:flutter_clean_template/features/home/home_view_model.dart';
import 'package:flutter_clean_template/features/home/models/home_ui_state.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen(homeViewModelProvider, (_, state) {
      final event = state.event;
      if (event == null) return;

      switch (event) {
        case HomeNavigateToMeditation():
          // TODO: Navigate to meditation session
          break;
      }

      ref.read(homeViewModelProvider.notifier).consumeEvent();
    });

    return Scaffold(
      backgroundColor: DsColors.surface,
      body: Column(
        children: [
          const HomeAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: DsSpacing.xl),
                  const HomeGreetingSection(),
                  const SizedBox(height: DsSpacing.xxl),
                  const HomeMoodSelector(),
                  const SizedBox(height: DsSpacing.xxl),
                  HomeDailyCard(
                    onStartTapped: () => ref
                        .read(homeViewModelProvider.notifier)
                        .onStartTapped(),
                  ),
                  const SizedBox(height: DsSpacing.lg),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: DsSpacing.lg,
                    ),
                    child: HomeContinueCard(),
                  ),
                  const SizedBox(height: DsSpacing.lg),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: DsSpacing.lg,
                    ),
                    child: HomeStreakCard(),
                  ),
                  const SizedBox(height: DsSpacing.xxl),
                  const HomeQuoteSection(),
                  const SizedBox(height: DsSpacing.xxl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
