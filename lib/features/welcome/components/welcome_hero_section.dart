import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/design_system/generated/assets.gen.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';

class WelcomeHeroSection extends StatelessWidget {
  const WelcomeHeroSection({super.key});

  static final _overlayGradientTop = DsColors.primary.withValues(alpha: 0.10);
  static final _orbLargeColor = DsColors.primary.withValues(alpha: 0.12);
  static final _orbSmallColor = DsColors.secondary.withValues(alpha: 0.10);
  static final _glassColor = Colors.white.withValues(alpha: 0.40);
  static final _glassBorderColor = Colors.white.withValues(alpha: 0.50);
  static final _glassShadowColor = DsColors.primary.withValues(alpha: 0.15);
  static final _badgeBgColor = Colors.white.withValues(alpha: 0.70);
  static final _badgeBorderColor = Colors.white.withValues(alpha: 0.60);
  static final _badgeShadowColor = DsColors.primary.withValues(alpha: 0.10);
  static final _blurFilter = ImageFilter.blur(sigmaX: 20, sigmaY: 20);
  static final _badgeRadius = BorderRadius.circular(16);

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return Container(
      height: 380 + context.viewPadding.top,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_overlayGradientTop, Colors.transparent],
        ),
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Large teal orb (top-left)
            Positioned(
              top: 20,
              left: -40,
              child: SizedBox(
                width: 200,
                height: 200,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _orbLargeColor,
                  ),
                ),
              ),
            ),
        
            // Small teal orb (bottom-right)
            Positioned(
              bottom: 40,
              right: -20,
              child: SizedBox(
                width: 150,
                height: 150,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _orbSmallColor,
                  ),
                ),
              ),
            ),
        
            // Circular image with glassmorphism
            Center(
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _glassColor,
                  border: Border.all(color: _glassBorderColor),
                  boxShadow: [
                    BoxShadow(
                      color: _glassShadowColor,
                      blurRadius: 60,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8),
                child: ClipOval(
                  child: Assets.images.imgZenStones.image(fit: BoxFit.cover),
                ),
              ),
            ),
        
            // Floating badge
            Positioned(
              top: 100,
              right: 40,
              child: ClipRRect(
                borderRadius: _badgeRadius,
                child: BackdropFilter(
                  filter: _blurFilter,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: _badgeBgColor,
                      borderRadius: _badgeRadius,
                      border: Border.all(color: _badgeBorderColor),
                      boxShadow: [
                        BoxShadow(
                          color: _badgeShadowColor,
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
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
                            style: context.textTheme.labelSmall?.copyWith(
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
            ),
          ],
        ),
      ),
    );
  }
}
