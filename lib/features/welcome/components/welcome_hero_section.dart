import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/design_system/generated/assets.gen.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';

class WelcomeHeroSection extends StatelessWidget {
  const WelcomeHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return SizedBox(
      height: 380,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Atmospheric gradient overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    DsColors.primary.withValues(alpha: 0.10),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Large blurred teal orb (top-left)
          Positioned(
            top: 20,
            left: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: DsColors.primary.withValues(alpha: 0.12),
              ),
            ),
          ),

          // Small blurred teal orb (bottom-right)
          Positioned(
            bottom: 40,
            right: -20,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: DsColors.secondary.withValues(alpha: 0.10),
              ),
            ),
          ),

          // Main circular image with glassmorphism
          Center(
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.40),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: DsColors.primary.withValues(alpha: 0.15),
                    blurRadius: 60,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: ClipOval(
                child: Assets.images.imgZenStones.image(
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Floating badge (top-right of image)
          Positioned(
            top: 60,
            right: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.70),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.60),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: DsColors.primary.withValues(alpha: 0.10),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.spa,
                        size: 20,
                        color: DsColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.welcome_badge.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2.0,
                          color: DsColors.primaryDim,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
