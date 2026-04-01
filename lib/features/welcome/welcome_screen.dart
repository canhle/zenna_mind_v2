import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_template/core/l10n/generated/l10n.dart';
import 'package:flutter_clean_template/core/router/app_router.dart';
import 'package:flutter_clean_template/design_system/tokens/ds_colors.dart';
import 'package:flutter_clean_template/features/welcome/components/welcome_background.dart';
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

    // ── Event listener ──────────────────────────────────────────────────
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
        child: SafeArea(
          child: Column(
            children: [
              // ── Hero: circular image + glassmorphism + floating badge ──
              const WelcomeHeroSection(),

              // ── Content: overlaps hero slightly ────────────────────────
              Transform.translate(
                offset: const Offset(0, -48),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      // Title
                      Text.rich(
                        TextSpan(
                          text: '${l10n.welcome_greeting}\n',
                          style: const TextStyle(
                            fontFamily: 'PlusJakartaSans',
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

                      // Description
                      Text(
                        l10n.welcome_subtitle,
                        style: const TextStyle(
                          fontFamily: 'Manrope',
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
              ),

              const Spacer(),

              // ── Action section ─────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64),
                child: Column(
                  children: [
                    // CTA Button: gradient from primary-dim to primary
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [DsColors.primaryDim, DsColors.primary],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: DsColors.primary.withValues(alpha: 0.30),
                            blurRadius: 35,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => ref
                              .read(welcomeViewModelProvider.notifier)
                              .onStartTapped(),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 40,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              l10n.welcome_cta,
                              style: const TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: DsColors.onPrimary,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Stats text
                    Text(
                      l10n.welcome_stats,
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: DsColors.outline,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ── Footer ─────────────────────────────────────────────────
              const WelcomeFooter(),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
