import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';
import 'package:flutter_clean_template/features/browse/models/browse_mock_data.dart';

class BrowseTrendingCard extends StatelessWidget {
  const BrowseTrendingCard({super.key, required this.item, this.onTap});

  final BrowseMeditationItem item;
  final VoidCallback? onTap;

  static final _glassBg = Colors.white.withValues(alpha: 0.40);
  static final _glassBorder = Colors.white.withValues(alpha: 0.20);
  static final _blurFilter = ImageFilter.blur(sigmaX: 12, sigmaY: 12);
  static final _durationColor = Colors.white.withValues(alpha: 0.90);
  static final _dotColor = Colors.white.withValues(alpha: 0.60);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
          fit: StackFit.expand,
          children: [
            // Placeholder background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [DsColors.primary, DsColors.primaryLight],
                ),
              ),
            ),

            // Dark gradient overlay
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xE6000000), Colors.transparent],
                ),
              ),
            ),

            // Glass card at bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                child: BackdropFilter(
                  filter: _blurFilter,
                  child: Container(
                    padding: const EdgeInsets.all(DsSpacing.xl),
                    decoration: BoxDecoration(
                      color: _glassBg,
                      border: Border(
                        top: BorderSide(color: _glassBorder),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          item.badge,
                          style: context.textTheme.labelSmall?.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 3.0,
                            color: DsColors.secondary,
                          ),
                        ),
                        const SizedBox(height: DsSpacing.sm),
                        Text(
                          item.title,
                          style: context.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: DsSpacing.md),
                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 14,
                              color: _durationColor,
                            ),
                            const SizedBox(width: DsSpacing.xs),
                            Text(
                              item.duration,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: _durationColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _dotColor,
                                ),
                              ),
                            ),
                            Text(
                              item.author,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: _durationColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
