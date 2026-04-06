import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_template/core/router/app_router.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';
import 'package:flutter_clean_template/features/meditation_complete/models/meditation_complete_arguments.dart';
import 'package:flutter_clean_template/features/player/components/player_background.dart';
import 'package:flutter_clean_template/features/player/components/player_breathing_ring.dart';
import 'package:flutter_clean_template/features/player/components/player_controls.dart';
import 'package:flutter_clean_template/features/player/components/player_progress_bar.dart';
import 'package:flutter_clean_template/features/player/components/player_session_info.dart';
import 'package:flutter_clean_template/features/player/components/player_top_bar.dart';
import 'package:flutter_clean_template/features/player/player_colors.dart';
import 'package:flutter_clean_template/features/player/player_view_model.dart';
import 'package:flutter_clean_template/features/player/models/player_ui_state.dart';

class PlayerScreen extends ConsumerStatefulWidget {
  const PlayerScreen({super.key});

  @override
  ConsumerState<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends ConsumerState<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen(playerViewModelProvider, (_, state) {
      final event = state.event;
      if (event == null) return;

      switch (event) {
        case PlayerNavigateBack():
          context.pop();
        case PlayerSessionComplete():
          context.go(
            AppRoutes.meditationComplete,
            extra: const MeditationCompleteArguments(streakCount: 7),
          );
      }

      ref.read(playerViewModelProvider.notifier).consumeEvent();
    });

    return Scaffold(
      backgroundColor: PlayerColors.background,
      body: PlayerBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DsSpacing.xl),
            child: Column(
              children: [
                PlayerTopBar(
                  onBackTapped: () => ref
                      .read(playerViewModelProvider.notifier)
                      .onBackTapped(),
                ),
                const Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PlayerBreathingRing(),
                        SizedBox(height: 28),
                        PlayerSessionInfo(),
                      ],
                    ),
                  ),
                ),
                const PlayerProgressBar(),
                const PlayerControls(),
                const SizedBox(height: DsSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
