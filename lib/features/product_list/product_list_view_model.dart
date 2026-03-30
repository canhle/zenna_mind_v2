import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_clean_template/core/error/failures.dart';
import 'package:flutter_clean_template/core/mixins/listen_with_auto_close.dart';
import 'package:flutter_clean_template/domain/entities/product.dart';
import 'package:flutter_clean_template/domain/providers/product_domain_providers.dart';
import 'package:flutter_clean_template/features/product_list/models/product_list_arguments.dart';
import 'package:flutter_clean_template/features/product_list/models/product_list_ui_state.dart';

part 'product_list_view_model.g.dart';

@riverpod
class ProductListViewModel extends _$ProductListViewModel
    with ListenWithAutoClose {
  @override
  ProductListUiState build(ProductListArguments args) {
    return const ProductListUiState();
  }

  // ── Data loading ────────────────────────────────────────────────────────

  void fetchProducts() {
    state = state.copyWith(products: const AsyncLoading());

    listenWithAutoClose<AsyncValue<List<Product>>>(
      provider: productsProvider(categoryId: args.categoryId, page: 0),
      ref: ref,
      onValue: (value) => value.when(
        data: (products) => state = state.copyWith(
          products: AsyncData(ProductsData(
            items: products,
            hasMore: products.isNotEmpty,
          )),
        ),
        loading: () {},
        error: (e, _) => _handleError(e),
      ),
    );
  }

  Future<void> loadNextPage() async {
    final currentPage = state.products.valueOrNull?.currentPage ?? 0;
    final hasMore = state.products.valueOrNull?.hasMore ?? false;
    if (!hasMore || state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);
    final nextPage = currentPage + 1;

    try {
      final items = await ref.read(
        productsProvider(categoryId: args.categoryId, page: nextPage).future,
      );

      final currentItems = state.products.valueOrNull?.items ?? [];
      state = state.copyWith(
        products: AsyncData(ProductsData(
          items: [...currentItems, ...items],
          currentPage: nextPage,
          hasMore: items.isNotEmpty,
        )),
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false);
      _handleError(e);
    }
  }

  // ── User actions ────────────────────────────────────────────────────────

  void onProductTapped(String productId) {
    state = state.copyWith(
      event: ProductListNavigateToDetail(productId),
    );
  }

  // ── Events ──────────────────────────────────────────────────────────────

  void consumeEvent() => state = state.copyWith(event: null);

  // ── Error handling ──────────────────────────────────────────────────────

  void _handleError(Object error) {
    final message = switch (error) {
      UnauthorizedFailure() => 'Session expired. Please log in again.',
      NetworkFailure() => 'Network error. Please check your connection.',
      ServerFailure() => 'Server error. Please try again later.',
      _ => 'An unexpected error occurred.',
    };

    if (state.products.valueOrNull == null) {
      state = state.copyWith(
        products: AsyncError(error, StackTrace.current),
        event: ProductListShowError(message),
      );
    } else {
      state = state.copyWith(
        event: ProductListShowError(message),
      );
    }
  }
}
