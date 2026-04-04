import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  static final _bgColor = Colors.white.withValues(alpha: 0.80);
  static final _blurFilter = ImageFilter.blur(sigmaX: 10, sigmaY: 10);

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return ClipRect(
      child: BackdropFilter(
        filter: _blurFilter,
        child: ColoredBox(
          color: _bgColor,
          child: Padding(
            padding: EdgeInsets.only(
              left: DsSpacing.xl,
              right: DsSpacing.xl,
              top: context.viewPadding.top + DsSpacing.sm,
              bottom: DsSpacing.sm,
            ),
            child: Row(
              children: [
                const Icon(Icons.spa, color: DsColors.primary, size: 24),
                const SizedBox(width: DsSpacing.sm),
                Expanded(
                  child: Text(
                    l10n.home_appName,
                    style: context.textTheme.labelLarge?.copyWith(
                      letterSpacing: 3.0,
                      color: DsColors.primary,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  color: DsColors.outline,
                  onPressed: () {
                    // TODO: Navigate to notifications
                  },
                ),
                const SizedBox(width: DsSpacing.xs),
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: DsColors.surfaceContainerHigh,
                  child: Icon(Icons.person, size: 20, color: DsColors.outline),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
