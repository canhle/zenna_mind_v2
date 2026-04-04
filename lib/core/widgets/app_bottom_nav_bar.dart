import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static final _shadowColor = DsColors.primary.withValues(alpha: 0.06);
  static final _activeBgColor =
      DsColors.primaryContainer.withValues(alpha: 0.40);

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    final tabs = [
      _TabData(Icons.home_outlined, l10n.home_navHome),
      _TabData(Icons.explore_outlined, l10n.home_navBrowse),
      _TabData(Icons.favorite_outline, l10n.home_navFavorites),
      _TabData(Icons.settings_outlined, l10n.home_navSettings),
    ];

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.80),
            border: Border(
              top: BorderSide(
                color: DsColors.outlineVariant.withValues(alpha: 0.20),
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: _shadowColor,
                blurRadius: 30,
                offset: const Offset(0, -10),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 16,
              bottom: context.viewPadding.bottom + 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(tabs.length, (i) {
                final isActive = i == currentIndex;
                return _NavItem(
                  icon: tabs[i].icon,
                  label: tabs[i].label,
                  isActive: isActive,
                  onTap: () => onTap(i),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabData {
  const _TabData(this.icon, this.label);
  final IconData icon;
  final String label;
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? DsColors.primary : DsColors.outline;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppBottomNavBar._activeBgColor : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w300,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
