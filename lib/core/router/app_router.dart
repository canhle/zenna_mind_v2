import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_clean_template/features/product_list/models/product_list_arguments.dart';
import 'package:flutter_clean_template/features/product_list/product_list_screen.dart';
import 'package:flutter_clean_template/features/welcome/welcome_screen.dart';

part 'app_router.g.dart';

abstract class AppRoutes {
  static const String welcome = '/';
  static const String home = '/home';
  static const String productList = '/products';
  static const String productDetail = '/products/:id';
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
      GoRoute(
        path: AppRoutes.home,
        builder: (_, __) => const ProductListScreen(
          args: ProductListArguments(categoryId: ''),
        ),
      ),
      GoRoute(
        path: AppRoutes.productList,
        builder: (_, state) {
          final categoryId =
              state.uri.queryParameters['categoryId'] ?? '';
          return ProductListScreen(
            args: ProductListArguments(categoryId: categoryId),
          );
        },
      ),
      // TODO: Add more routes as features are created
      // GoRoute(
      //   path: AppRoutes.productDetail,
      //   builder: (_, state) => ProductDetailScreen(
      //     args: ProductDetailArguments(
      //       productId: state.pathParameters['id']!,
      //     ),
      //   ),
      // ),
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
