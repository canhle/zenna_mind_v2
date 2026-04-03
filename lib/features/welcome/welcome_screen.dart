import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/core/router/app_router.dart';
import 'package:flutter_clean_template/core/extensions/context_extensions.dart';
import 'package:flutter_clean_template/design_system/components/ds_button.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/features/welcome/components/welcome_background.dart';
import 'package:flutter_clean_template/features/welcome/components/welcome_content_section.dart';
import 'package:flutter_clean_template/features/welcome/components/welcome_footer.dart';
import 'package:flutter_clean_template/features/welcome/components/welcome_hero_section.dart';
import 'package:flutter_clean_template/features/welcome/models/welcome_ui_state.dart';
import 'package:flutter_clean_template/features/welcome/welcome_view_model.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    ref.listen(welcomeViewModelProvider, (_, state) {
      final event = state.event;
      if (event == null) return;

      switch (event) {
        case WelcomeNavigateToHome():
          context.go(AppRoutes.home);
      }

      ref.read(welcomeViewModelProvider.notifier).consumeEvent();
    });

    return Scaffold(
      body: WelcomeBackground(
        child: Column(
          children: [
            const WelcomeHeroSection(),
            const WelcomeContentSection(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64),
              child: Column(
                children: [
                  DsButton(
                    label: l10n.welcome_cta,
                    onPressed: () => ref
                        .read(welcomeViewModelProvider.notifier)
                        .onStartTapped(),
                    size: DsButtonSize.large,
                    isExpanded: true,
                  ),
        
                  const SizedBox(height: 24),
        
                  Text(
                    l10n.welcome_stats,
                    style: context.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      color: DsColors.outline,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const WelcomeFooter(),
            SizedBox(height: 32 + context.viewPadding.bottom),
          ],
        ),
      ),
    );
  }
}
