import 'package:flutter/material.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';
import 'package:flutter_clean_template/features/browse/components/browse_trending_card.dart';
import 'package:flutter_clean_template/features/browse/models/browse_mock_data.dart';

class BrowseTrendingSection extends StatelessWidget {
  const BrowseTrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final cardWidth = screenWidth * 0.7;

    return SizedBox(
      height: cardWidth * (5 / 4),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        padding: const EdgeInsets.symmetric(horizontal: DsSpacing.lg),
        itemCount: mockTrendingItems.length,
        separatorBuilder: (_, __) => const SizedBox(width: DsSpacing.lg),
        itemBuilder: (_, index) {
          return SizedBox(
            width: cardWidth,
            child: BrowseTrendingCard(item: mockTrendingItems[index]),
          );
        },
      ),
    );
  }
}
