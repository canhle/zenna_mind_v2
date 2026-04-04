import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';
import 'package:flutter_clean_template/features/browse/browse_view_model.dart';

class BrowseTabBar extends ConsumerWidget {
  const BrowseTabBar({super.key});

  static final _borderColor = DsColors.outlineVariant.withValues(alpha: 0.15);
  static final _inactiveColor =
      DsColors.onSurfaceVariant.withValues(alpha: 0.60);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context)!;
    final selectedIndex = ref.watch(
      browseViewModelProvider.select((s) => s.selectedTabIndex),
    );

    final tabs = [l10n.browser_tabTopics, l10n.browser_tabMoods];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DsSpacing.lg),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: _borderColor)),
        ),
        child: Row(
          children: List.generate(tabs.length, (i) {
            final isActive = i == selectedIndex;
            return Expanded(
              child: GestureDetector(
                onTap: () => ref
                    .read(browseViewModelProvider.notifier)
                    .onTabChanged(i),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: DsSpacing.md),
                      child: Text(
                        tabs[i],
                        textAlign: TextAlign.center,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight:
                              isActive ? FontWeight.w600 : FontWeight.w500,
                          color: isActive ? DsColors.primary : _inactiveColor,
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 2,
                      decoration: BoxDecoration(
                        color: isActive ? DsColors.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
