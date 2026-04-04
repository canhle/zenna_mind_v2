import 'package:flutter/material.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';
import 'package:flutter_clean_template/features/browse/components/browse_content_card.dart';
import 'package:flutter_clean_template/features/browse/models/browse_mock_data.dart';

class BrowseContentSection extends StatelessWidget {
  const BrowseContentSection({super.key, required this.items});

  final List<BrowseMeditationItem> items;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final cardWidth = screenWidth * 0.4;

    return SizedBox(
      height: cardWidth * (5 / 4),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        padding: const EdgeInsets.symmetric(horizontal: DsSpacing.lg),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: DsSpacing.md),
        itemBuilder: (_, index) {
          return SizedBox(
            width: cardWidth,
            child: BrowseContentCard(item: items[index]),
          );
        },
      ),
    );
  }
}
