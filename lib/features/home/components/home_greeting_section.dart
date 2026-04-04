import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_spacing.dart';

class HomeGreetingSection extends StatelessWidget {
  const HomeGreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;
    final hour = DateTime.now().hour;

    final greeting = _getGreeting(l10n, hour);
    final subtitle = l10n.home_greetingSubtitle;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DsSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greeting,
            style: context.textTheme.headlineLarge?.copyWith(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: DsSpacing.sm),
          Text(
            subtitle,
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w300,
              color: DsColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  String _getGreeting(S l10n, int hour) {
    if (hour < 12) return l10n.home_greetingMorning('Canh');
    if (hour < 18) return l10n.home_greetingAfternoon('Canh');
    return l10n.home_greetingEvening('Canh');
  }
}
