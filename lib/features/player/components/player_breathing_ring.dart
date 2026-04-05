import 'package:flutter/material.dart';
import 'package:flutter_clean_template/features/player/player_colors.dart';

class PlayerBreathingRing extends StatefulWidget {
  const PlayerBreathingRing({super.key});

  @override
  State<PlayerBreathingRing> createState() => _PlayerBreathingRingState();
}

class _PlayerBreathingRingState extends State<PlayerBreathingRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Widget _outerRing = SizedBox(
    width: 160,
    height: 160,
    child: DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: PlayerColors.ringOuter, width: 1.5),
      ),
    ),
  );

  late final Widget _midRing = SizedBox(
    width: 120,
    height: 120,
    child: DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: PlayerColors.ringMid),
      ),
    ),
  );

  late final Widget _coreCircle = SizedBox(
    width: 84,
    height: 84,
    child: DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: PlayerColors.ringCore,
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 144,
      height: 144,
      child: AnimatedBuilder(
        animation: _controller,
        child: SizedBox(
          width: 36,
          height: 36,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: PlayerColors.ringDot,
            ),
          ),
        ),
        builder: (context, dotChild) {
          final v = _controller.value;

          return Stack(
            alignment: Alignment.center,
            children: [
              Transform.scale(scale: 1.0 + v * 0.12, child: _outerRing),
              Transform.scale(scale: 1.0 + v * 0.09, child: _midRing),
              Transform.scale(scale: 1.0 + v * 0.06, child: _coreCircle),
              Transform.scale(scale: 1.0 + v * 0.25, child: dotChild),
            ],
          );
        },
      ),
    );
  }
}
