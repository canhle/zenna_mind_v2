import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_template/features/player/player_colors.dart';
import 'package:flutter_clean_template/features/player/player_view_model.dart';

class PlayerControls extends ConsumerWidget {
  const PlayerControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlaying = ref.watch(
      playerViewModelProvider.select((s) => s.isPlaying),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _SkipButton(
            icon: Icons.skip_previous,
            onTap: () =>
                ref.read(playerViewModelProvider.notifier).onSkipPrevious(),
          ),
          const SizedBox(width: 22),
          _PlayPauseButton(
            isPlaying: isPlaying,
            onTap: () =>
                ref.read(playerViewModelProvider.notifier).onPlayPauseTapped(),
          ),
          const SizedBox(width: 22),
          _SkipButton(
            icon: Icons.skip_next,
            onTap: () =>
                ref.read(playerViewModelProvider.notifier).onSkipNext(),
          ),
        ],
      ),
    );
  }
}

class _SkipButton extends StatelessWidget {
  const _SkipButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46,
      height: 46,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: PlayerColors.skipBorder),
        ),
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: Icon(icon, size: 22, color: PlayerColors.skipIcon),
          ),
        ),
      ),
    );
  }
}

class _PlayPauseButton extends StatelessWidget {
  const _PlayPauseButton({required this.isPlaying, required this.onTap});

  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 68,
      height: 68,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: PlayerColors.playShadow,
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: PlayerColors.playBg,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              size: 32,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
