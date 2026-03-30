import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_template/domain/entities/product.dart';

part 'product_list_ui_state.freezed.dart';

// ── Events ────────────────────────────────────────────────────────────────

sealed class ProductListEvent {
  const ProductListEvent();
}

class ProductListNavigateToDetail extends ProductListEvent {
  const ProductListNavigateToDetail(this.productId);
  final String productId;
}

class ProductListShowError extends ProductListEvent {
  const ProductListShowError(this.message);
  final String message;
}

// ── Data wrapper ──────────────────────────────────────────────────────────

@freezed
class ProductsData with _$ProductsData {
  const factory ProductsData({
    required List<Product> items,
    @Default(0) int currentPage,
    @Default(false) bool hasMore,
  }) = _ProductsData;
}

// ── UiState ───────────────────────────────────────────────────────────────

@freezed
class ProductListUiState with _$ProductListUiState {
  const factory ProductListUiState({
    @Default(AsyncValue.loading()) AsyncValue<ProductsData> products,
    @Default(false) bool isLoadingMore,
    ProductListEvent? event,
  }) = _ProductListUiState;
}
