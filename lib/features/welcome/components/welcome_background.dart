import 'package:flutter/material.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';

class WelcomeBackground extends StatelessWidget {
  const WelcomeBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [
              DsColors.background, // #F0FDFA
              DsColors.surfaceDim, // #E0F2F1
              DsColors.background, // #F0FDFA
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: child,
      ),
    );
  }
}
