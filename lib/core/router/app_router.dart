import 'package:flutter/material.dart';
import 'package:flutter_clean_template/core/widgets/app_scaffold.dart';
import 'package:flutter_clean_template/domain/providers/auth_domain_providers.dart';
import 'package:flutter_clean_template/features/browse/browse_screen.dart';
import 'package:flutter_clean_template/features/favorites/favorites_screen.dart';
import 'package:flutter_clean_template/features/home/home_screen.dart';
import 'package:flutter_clean_template/features/meditation_complete/meditation_complete_screen.dart';
import 'package:flutter_clean_template/features/meditation_complete/models/meditation_complete_arguments.dart';
import 'package:flutter_clean_template/features/player/player_screen.dart';
import 'package:flutter_clean_template/features/settings/settings_screen.dart';
import 'package:flutter_clean_template/features/streak/streak_screen.dart';
import 'package:flutter_clean_template/features/welcome/welcome_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

abstract class AppRoutes {
  static const String welcome = '/';
  static const String home = '/home';
  static const String browse = '/browse';
  static const String favorites = '/favorites';
  static const String settings = '/settings';
  static const String player = '/player';
  static const String streak = '/streak';
  static const String meditationComplete = '/meditation-complete';
}

@riverpod
GoRouter appRouter(Ref ref) {
  final notifier = _AuthRefreshNotifier(ref);

  return GoRouter(
    initialLocation: AppRoutes.welcome,
    debugLogDiagnostics: true,
    refreshListenable: notifier,
    redirect: (context, state) {
      final user = ref.read(currentUserProvider);

      // Still bootstrapping auth state — stay where we are to avoid flicker
      // (FR-010: no race between Welcome and Home on cold start).
      if (user.isLoading) return null;

      final loggedIn = user.valueOrNull != null;
      final onWelcome = state.matchedLocation == AppRoutes.welcome;

      if (!loggedIn && !onWelcome) return AppRoutes.welcome;
      if (loggedIn && onWelcome) return AppRoutes.home;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.welcome,
        builder: (_, __) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.player,
        builder: (_, __) => const PlayerScreen(),
      ),
      GoRoute(
        path: AppRoutes.streak,
        builder: (_, __) => const StreakScreen(),
      ),
      GoRoute(
        path: AppRoutes.meditationComplete,
        builder: (_, state) {
          final args = state.extra as MeditationCompleteArguments? ??
              const MeditationCompleteArguments();
          return MeditationCompleteScreen(args: args);
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => AppScaffold(
          navigationShell: navigationShell,
        ),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (_, __) => const HomeScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.browse,
              builder: (_, __) => const BrowseScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.favorites,
              builder: (_, __) => const FavoritesScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.settings,
              builder: (_, __) => const SettingsScreen(),
            ),
          ]),
        ],
      ),
    ],
    errorBuilder: (_, __) => const _NotFoundScreen(),
  );
}

/// Bridges Riverpod's [currentUserProvider] to GoRouter's [Listenable] API
/// so the router re-evaluates [GoRouter.redirect] every time the user's
/// auth state flips (sign-in success, sign-out, profile load).
class _AuthRefreshNotifier extends ChangeNotifier {
  _AuthRefreshNotifier(Ref ref) {
    _sub = ref.listen<Object?>(
      currentUserProvider,
      (_, __) => notifyListeners(),
      fireImmediately: false,
    );
    ref.onDispose(_sub.close);
  }

  late final ProviderSubscription<Object?> _sub;
}

class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Not Found')),
      body: const Center(
        child: Text('Page not found'),
      ),
    );
  }
}
