import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';

class WelcomeContentSection extends StatelessWidget {
  const WelcomeContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;
    final textTheme = context.textTheme;

    return Transform.translate(
      offset: const Offset(0, -48),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            Text.rich(
              TextSpan(
                text: '${l10n.welcome_greeting}\n',
                style: textTheme.headlineMedium?.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: DsColors.onSurface,
                  height: 1.2,
                  letterSpacing: 0.5,
                ),
                children: [
                  TextSpan(
                    text: l10n.welcome_appName,
                    style: const TextStyle(
                      color: DsColors.primary,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text(
              l10n.welcome_subtitle,
              style: textTheme.bodyLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: DsColors.onSurfaceVariant,
                height: 1.625,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
