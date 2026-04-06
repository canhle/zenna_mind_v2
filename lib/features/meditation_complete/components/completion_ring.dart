import 'package:flutter/material.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';

class CompletionRing extends StatefulWidget {
  const CompletionRing({super.key});

  @override
  State<CompletionRing> createState() => _CompletionRingState();
}

class _CompletionRingState extends State<CompletionRing>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final AnimationController _pulseMidController;
  late final AnimationController _popController;
  late final Animation<double> _pulseAnimation;
  late final Animation<double> _pulseMidAnimation;
  late final Animation<double> _popAnimation;

  late final List<AnimationController> _dotControllers;
  late final List<Animation<double>> _dotAnimations;

  static const _dotCount = 5;
  static const _dotDelays = [0.0, 0.7, 1.2, 1.8, 0.4];
  static const _dotSizes = [8.0, 6.0, 7.0, 5.0, 5.0];

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Ring mid has a 0.4s staggered delay
    _pulseMidController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _pulseMidAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseMidController, curve: Curves.easeInOut),
    );
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _pulseMidController.repeat(reverse: true);
    });

    _popController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _popAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _popController,
        curve: const Cubic(0.34, 1.56, 0.64, 1),
      ),
    );

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _popController.forward();
    });

    // Floating dots
    _dotControllers = List.generate(_dotCount, (i) {
      final controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 4),
      );
      Future.delayed(
        Duration(milliseconds: (_dotDelays[i] * 1000).toInt()),
        () {
          if (mounted) controller.repeat(reverse: true);
        },
      );
      return controller;
    });

    _dotAnimations = _dotControllers.map((c) {
      return Tween<double>(begin: 0, end: -7).animate(
        CurvedAnimation(parent: c, curve: Curves.easeInOut),
      );
    }).toList();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _pulseMidController.dispose();
    _popController.dispose();
    for (final c in _dotControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 148,
      height: 148,
      child: Stack(
        children: [
          // Ring outer
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) => Transform.scale(
                scale: _pulseAnimation.value,
                child: child,
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.5,
                    color: const Color(0x2E0A6446), // rgba(10,100,70,0.18)
                  ),
                ),
              ),
            ),
          ),

          // Ring mid (0.4s staggered delay)
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: AnimatedBuilder(
                animation: _pulseMidAnimation,
                builder: (context, child) => Transform.scale(
                  scale: _pulseMidAnimation.value,
                  child: child,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0x1F0A6446), // rgba(10,100,70,0.12)
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Ring core
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(34),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x8CFFFFFF), // rgba(255,255,255,0.55)
                ),
                child: Center(
                  child: ScaleTransition(
                    scale: _popAnimation,
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: DsColors.completionAccent,
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        size: 22,
                        color: DsColors.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Floating dots
          ..._buildDots(),
        ],
      ),
    );
  }

  List<Widget> _buildDots() {
    // Dot positions: [top, left, bottom, right] — null means not set
    const positions = <Map<String, double>>[
      {'top': 5, 'left': 28},
      {'top': 18, 'right': 22},
      {'bottom': 14, 'left': 16},
      {'bottom': 26, 'right': 30},
      {'top': 70, 'left': 2}, // ~48% of 148
    ];

    return List.generate(_dotCount, (i) {
      final pos = positions[i];
      return Positioned(
        top: pos['top'],
        left: pos['left'],
        bottom: pos['bottom'],
        right: pos['right'],
        child: AnimatedBuilder(
          animation: _dotAnimations[i],
          builder: (context, child) => Transform.translate(
            offset: Offset(0, _dotAnimations[i].value),
            child: child,
          ),
          child: Container(
            width: _dotSizes[i],
            height: _dotSizes[i],
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0x470A7846), // rgba(10,120,70,0.28)
            ),
          ),
        ),
      );
    });
  }
}
