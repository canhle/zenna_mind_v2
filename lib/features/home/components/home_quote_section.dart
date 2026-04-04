import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';

class HomeQuoteSection extends StatelessWidget {
  const HomeQuoteSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DsSpacing.xxl),
      child: Opacity(
        opacity: 0.60,
        child: Text(
          '"Bình yên không phải là khi sóng yên biển lặng, mà là khi ta vẫn an nhiên giữa bão giông."',
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium?.copyWith(
            fontStyle: FontStyle.italic,
            color: DsColors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
