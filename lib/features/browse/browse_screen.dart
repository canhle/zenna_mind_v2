import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';
import 'package:flutter_clean_template/features/browse/browse_view_model.dart';
import 'package:flutter_clean_template/features/browse/components/browse_content_section.dart';
import 'package:flutter_clean_template/features/browse/components/browse_search_bar.dart';
import 'package:flutter_clean_template/features/browse/components/browse_section_header.dart';
import 'package:flutter_clean_template/features/browse/components/browse_tab_bar.dart';
import 'package:flutter_clean_template/features/browse/components/browse_trending_section.dart';
import 'package:flutter_clean_template/features/browse/models/browse_mock_data.dart';

class BrowseScreen extends ConsumerStatefulWidget {
  const BrowseScreen({super.key});

  @override
  ConsumerState<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends ConsumerState<BrowseScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;
    final selectedTab = ref.watch(
      browseViewModelProvider.select((s) => s.selectedTabIndex),
    );

    final sections =
        selectedTab == 0 ? mockTopicSections : mockMoodSections;

    return Scaffold(
      backgroundColor: DsColors.surface,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.viewPadding.top + DsSpacing.xl),

            BrowseSearchBar(
              onChanged: (query) => ref
                  .read(browseViewModelProvider.notifier)
                  .onSearchChanged(query),
            ),
            const SizedBox(height: DsSpacing.xxl),

            BrowseSectionHeader(
              title: l10n.browser_trending,
              onViewAll: () {
                // TODO: Navigate to trending list
              },
            ),
            const SizedBox(height: DsSpacing.lg),
            const BrowseTrendingSection(),
            const SizedBox(height: DsSpacing.xxl),

            const BrowseTabBar(),
            const SizedBox(height: DsSpacing.xxl),

            for (final section in sections) ...[
              BrowseSectionHeader(
                title: section.title,
                isLarge: false,
                onViewAll: () {
                  // TODO: Navigate to section list
                },
              ),
              const SizedBox(height: DsSpacing.lg),
              BrowseContentSection(items: section.items),
              const SizedBox(height: DsSpacing.xxl),
            ],
          ],
        ),
      ),
    );
  }
}
