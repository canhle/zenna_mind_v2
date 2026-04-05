import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/features/player/player_colors.dart';
import 'package:flutter_clean_template/features/player/player_view_model.dart';

class PlayerProgressBar extends ConsumerWidget {
  const PlayerProgressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (current, total) = ref.watch(
      playerViewModelProvider
          .select((s) => (s.currentPosition, s.totalDuration)),
    );

    final progress =
        total.inMilliseconds > 0 ? current.inMilliseconds / total.inMilliseconds : 0.0;
    final remaining = total - current;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          // Time labels
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(current),
                  style: context.textTheme.labelSmall?.copyWith(
                    color: PlayerColors.textHint,
                  ),
                ),
                Text(
                  '-${_formatDuration(remaining)}',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: PlayerColors.textHint,
                  ),
                ),
              ],
            ),
          ),

          // Seekable track
          GestureDetector(
            onTapDown: (d) => _seekTo(d.localPosition.dx, context, ref),
            onHorizontalDragUpdate: (d) => _seekTo(d.localPosition.dx, context, ref),
            child: SizedBox(
              height: 20,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  // Track background
                  Container(
                    height: 3,
                    decoration: BoxDecoration(
                      color: PlayerColors.progTrack,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // Fill
                  FractionallySizedBox(
                    widthFactor: progress.clamp(0.0, 1.0),
                    child: Container(
                      height: 3,
                      decoration: BoxDecoration(
                        color: PlayerColors.progFill,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // Dot
                  Positioned(
                    child: FractionallySizedBox(
                      widthFactor: progress.clamp(0.0, 1.0),
                      alignment: Alignment.centerLeft,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 11,
                          height: 11,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: PlayerColors.progDot,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _seekTo(double localDx, BuildContext context, WidgetRef ref) {
    final box = context.findRenderObject()! as RenderBox;
    final fraction = (localDx / box.size.width).clamp(0.0, 1.0);
    ref.read(playerViewModelProvider.notifier).onSeek(fraction);
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
