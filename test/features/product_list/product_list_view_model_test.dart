import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_clean_template/core/error/failures.dart';
import 'package:flutter_clean_template/domain/entities/product.dart';
import 'package:flutter_clean_template/domain/providers/product_domain_providers.dart';
import 'package:flutter_clean_template/features/product_list/models/product_list_arguments.dart';
import 'package:flutter_clean_template/features/product_list/models/product_list_ui_state.dart';
import 'package:flutter_clean_template/features/product_list/product_list_view_model.dart';
import '../../helpers/test_helpers.dart';

void main() {
  late ProductListArguments args;
  late ProductListUiState expectedState;

  setUp(() {
    args = const ProductListArguments(categoryId: 'cat_001');
    expectedState = const ProductListUiState();
  });

  ProviderContainer buildContainer({List<Override> overrides = const []}) {
    final container = createContainer(overrides: overrides);
    addTearDown(container.dispose);
    return container;
  }

  /// Pumps microtasks until the condition is met or timeout.
  Future<void> pumpUntil(
    ProviderContainer container,
    ProviderListenable<ProductListUiState> provider,
    bool Function(ProductListUiState) condition,
  ) async {
    final completer = Completer<void>();
    final sub = container.listen(provider, (_, state) {
      if (condition(state) && !completer.isCompleted) {
        completer.complete();
      }
    });
    addTearDown(sub.close);

    // Check current state first
    final current = container.read(provider);
    if (condition(current)) return;

    await completer.future.timeout(const Duration(seconds: 2));
  }

  group('fetchProducts', () {
    test('should transition through loading then data on success', () async {
      // Arrange
      final dummy = _dummyProducts();
      final container = buildContainer(
        overrides: [
          productsProvider(categoryId: 'cat_001', page: 0).overrideWith(
            (ref) async => dummy,
          ),
        ],
      );
      final states = collectStates(
        container,
        productListViewModelProvider(args),
      );
      final sut =
          container.read(productListViewModelProvider(args).notifier);

      // Act
      sut.fetchProducts();
      await pumpUntil(
        container,
        productListViewModelProvider(args),
        (s) => s.products is AsyncData,
      );

      // Assert
      expect(states.length, 3);
      expect(states[0], expectedState);
      expect(
        states[1],
        expectedState.copyWith(products: const AsyncLoading()),
      );
      expect(
        states[2],
        expectedState.copyWith(
          products: AsyncData(ProductsData(
            items: dummy,
            hasMore: true,
          )),
        ),
      );
    });

    test('should emit ShowError event on NetworkFailure', () async {
      // Arrange
      final container = buildContainer(
        overrides: [
          productsProvider(categoryId: 'cat_001', page: 0).overrideWith(
            (ref) => Future.error(const NetworkFailure()),
          ),
        ],
      );
      final sut =
          container.read(productListViewModelProvider(args).notifier);

      // Act
      sut.fetchProducts();
      await pumpUntil(
        container,
        productListViewModelProvider(args),
        (s) => s.event != null,
      );

      // Assert
      final state = container.read(productListViewModelProvider(args));
      expect(state.event, isA<ProductListShowError>());
      expect(state.products, isA<AsyncError>());
    });

    test('should append items on subsequent page loads', () async {
      // Arrange
      final firstPage = _dummyProducts();
      final secondPage = [
        const Product(
          id: 'product_003',
          title: 'Product 3',
          description: 'Description 3',
        ),
      ];
      final container = buildContainer(
        overrides: [
          productsProvider(categoryId: 'cat_001', page: 0).overrideWith(
            (ref) async => firstPage,
          ),
          productsProvider(categoryId: 'cat_001', page: 1).overrideWith(
            (ref) async => secondPage,
          ),
        ],
      );
      final sut =
          container.read(productListViewModelProvider(args).notifier);

      // Act
      sut.fetchProducts();
      await pumpUntil(
        container,
        productListViewModelProvider(args),
        (s) => s.products is AsyncData,
      );
      await sut.loadNextPage();

      // Assert
      final state = container.read(productListViewModelProvider(args));
      final data = state.products.valueOrNull;
      expect(data?.items.length, 3);
      expect(data?.currentPage, 1);
    });
  });
}

// ── Dummy data ───────────────────────────────────────────────────────────────

List<Product> _dummyProducts() => const [
      Product(
        id: 'product_001',
        title: 'Product 1',
        description: 'Description 1',
        imageUrl: 'https://example.com/image1.png',
      ),
      Product(
        id: 'product_002',
        title: 'Product 2',
        description: 'Description 2',
      ),
    ];
