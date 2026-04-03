import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';

class WelcomeFooter extends StatelessWidget {
  const WelcomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;
    final textTheme = context.textTheme;
    final linkStyle = textTheme.labelSmall?.copyWith(
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: DsColors.primary.withValues(alpha: 0.60),
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // TODO: Navigate to privacy policy
              },
              child: Text(l10n.welcome_privacy, style: linkStyle),
            ),
            const SizedBox(width: 24),
            GestureDetector(
              onTap: () {
                // TODO: Navigate to terms
              },
              child: Text(l10n.welcome_terms, style: linkStyle),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          l10n.welcome_copyright,
          style: textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w300,
            letterSpacing: 0.5,
            color: DsColors.outline.withValues(alpha: 0.70),
          ),
        ),
      ],
    );
  }
}
