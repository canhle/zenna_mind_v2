import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_clean_template/core/widgets/app_scaffold.dart';
import 'package:flutter_clean_template/features/browse/browse_screen.dart';
import 'package:flutter_clean_template/features/favorites/favorites_screen.dart';
import 'package:flutter_clean_template/features/home/home_screen.dart';
import 'package:flutter_clean_template/features/settings/settings_screen.dart';
import 'package:flutter_clean_template/features/welcome/welcome_screen.dart';

part 'app_router.g.dart';

abstract class AppRoutes {
  static const String welcome = '/';
  static const String home = '/home';
  static const String browse = '/browse';
  static const String favorites = '/favorites';
  static const String settings = '/settings';
}

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.welcome,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.welcome,
        builder: (_, __) => const WelcomeScreen(),
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
