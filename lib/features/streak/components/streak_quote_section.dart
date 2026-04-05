import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/features/streak/models/streak_mock_data.dart';

class StreakQuoteSection extends StatelessWidget {
  const StreakQuoteSection({super.key});

  static final _quoteColor = DsColors.onSurfaceVariant.withValues(alpha: 0.58);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Text(
            mockQuoteText,
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w300,
              color: _quoteColor,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            mockQuoteAttribution,
            textAlign: TextAlign.center,
            style: context.textTheme.labelSmall?.copyWith(
              color: DsColors.outline,
            ),
          ),
        ],
      ),
    );
  }
}
