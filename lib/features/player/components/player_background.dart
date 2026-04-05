import 'package:flutter/material.dart';
import 'package:flutter_clean_template/features/player/player_colors.dart';

class PlayerBackground extends StatelessWidget {
  const PlayerBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          left: -80,
          child: SizedBox(
            width: 300,
            height: 300,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PlayerColors.blobColor,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -60,
          right: -55,
          child: SizedBox(
            width: 200,
            height: 200,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PlayerColors.blobColor,
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
