import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_radius.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';
import 'package:flutter_clean_template/features/browse/models/browse_mock_data.dart';

class BrowseContentCard extends StatelessWidget {
  const BrowseContentCard({super.key, required this.item, this.onTap});

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
        borderRadius: BorderRadius.circular(DsRadius.xl),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Placeholder gradient bg
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    DsColors.primary.withValues(alpha: 0.80),
                    DsColors.primaryLight.withValues(alpha: 0.60),
                  ],
                ),
              ),
            ),

            // Dark gradient overlay
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xCC000000), Color(0x33000000), Colors.transparent],
                ),
              ),
            ),

            // Glass card at bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(DsRadius.xl),
                  topRight: Radius.circular(DsRadius.xl),
                ),
                child: BackdropFilter(
                  filter: _blurFilter,
                  child: Container(
                    padding: const EdgeInsets.all(20),
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
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                            color: DsColors.secondary,
                          ),
                        ),
                        const SizedBox(height: DsSpacing.xs),
                        Text(
                          item.title,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: DsSpacing.sm),
                        Row(
                          children: [
                            Text(
                              item.duration,
                              style: context.textTheme.labelSmall?.copyWith(
                                fontSize: 10,
                                color: _durationColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
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
                              style: context.textTheme.labelSmall?.copyWith(
                                fontSize: 10,
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
