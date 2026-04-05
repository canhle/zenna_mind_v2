import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/features/player/player_colors.dart';

class PlayerTopBar extends StatelessWidget {
  const PlayerTopBar({super.key, required this.onBackTapped});

  final VoidCallback onBackTapped;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _IconCircle(
            icon: Icons.chevron_left,
            onTap: onBackTapped,
          ),
          Text(
            l10n.player_nowPlaying,
            style: context.textTheme.labelLarge?.copyWith(
              letterSpacing: 2.0,
              color: PlayerColors.textHint,
            ),
          ),
          _IconCircle(
            icon: Icons.more_vert,
            onTap: () {
              // TODO: Show options menu
            },
          ),
        ],
      ),
    );
  }
}

class _IconCircle extends StatelessWidget {
  const _IconCircle({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Material(
        color: PlayerColors.iconBtnBg,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Icon(icon, size: 22, color: PlayerColors.textMain),
        ),
      ),
    );
  }
}
