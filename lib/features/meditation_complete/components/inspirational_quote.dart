import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';
import 'package:google_fonts/google_fonts.dart';

class InspirationalQuote extends StatelessWidget {
  const InspirationalQuote({
    super.key,
    required this.text,
    required this.author,
  });

  final String text;
  final String author;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 260),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '"$text"',
            textAlign: TextAlign.center,
            style: GoogleFonts.lora(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
              color: DsColors.completionText.withValues(alpha: 0.58),
              height: 1.7,
            ),
          ),
          const SizedBox(height: DsSpacing.sm),
          Text(
            '— $author',
            style: context.textTheme.labelSmall?.copyWith(
              fontSize: 12,
              color: DsColors.completionText.withValues(alpha: 0.40),
              letterSpacing: 0.04,
            ),
          ),
        ],
      ),
    );
  }
}
