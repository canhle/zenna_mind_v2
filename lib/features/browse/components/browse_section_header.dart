import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';

class BrowseSectionHeader extends StatelessWidget {
  const BrowseSectionHeader({
    super.key,
    required this.title,
    this.onViewAll,
    this.isLarge = true,
  });

  final String title;
  final VoidCallback? onViewAll;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DsSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: isLarge
                ? context.textTheme.headlineSmall?.copyWith(
                    letterSpacing: 0.8,
                  )
                : context.textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                    letterSpacing: 0.8,
                  ),
          ),
          if (onViewAll != null)
            GestureDetector(
              onTap: onViewAll,
              child: Text(
                l10n.browser_viewAll,
                style: context.textTheme.labelLarge?.copyWith(
                  color: DsColors.primary,
                  letterSpacing: 1.5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
