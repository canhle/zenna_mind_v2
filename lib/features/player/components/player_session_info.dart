import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/features/player/player_colors.dart';
import 'package:flutter_clean_template/features/player/player_view_model.dart';

class PlayerSessionInfo extends ConsumerWidget {
  const PlayerSessionInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (title, description) = ref.watch(
      playerViewModelProvider
          .select((s) => (s.sessionTitle, s.sessionDescription)),
    );

    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w300,
            color: PlayerColors.textMain,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 240,
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: PlayerColors.textMuted,
              height: 1.65,
            ),
          ),
        ),
      ],
    );
  }
}
