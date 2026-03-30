import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_template/core/widgets/error_view.dart';
import 'package:flutter_clean_template/core/widgets/loading_view.dart';
import 'package:flutter_clean_template/domain/entities/product.dart';
import 'package:flutter_clean_template/features/product_list/models/product_list_arguments.dart';
import 'package:flutter_clean_template/features/product_list/models/product_list_ui_state.dart';
import 'package:flutter_clean_template/features/product_list/product_list_view_model.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key, required this.args});

  final ProductListArguments args;

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(productListViewModelProvider(widget.args).notifier)
          .fetchProducts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ── Event listener ──────────────────────────────────────────────────
    ref.listen(productListViewModelProvider(widget.args), (_, state) {
      final event = state.event;
      if (event == null) return;

      switch (event) {
        case ProductListNavigateToDetail(:final productId):
          context.push('/products/$productId');
        case ProductListShowError(:final message):
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
      }

      ref
          .read(productListViewModelProvider(widget.args).notifier)
          .consumeEvent();
    });

    // ── UI ───────────────────────────────────────────────────────────────
    final productsAsync = ref.watch(
      productListViewModelProvider(widget.args).select((s) => s.products),
    );
    final isLoadingMore = ref.watch(
      productListViewModelProvider(widget.args).select((s) => s.isLoadingMore),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: productsAsync.when(
        data: (data) => _ProductListView(
          items: data.items,
          isLoadingMore: isLoadingMore,
          args: widget.args,
        ),
        loading: () => const LoadingView(),
        error: (_, __) => ErrorView(
          onRetry: () => ref
              .read(productListViewModelProvider(widget.args).notifier)
              .fetchProducts(),
        ),
      ),
    );
  }
}

// ── Sub-widgets ─────────────────────────────────────────────────────────────

class _ProductListView extends ConsumerWidget {
  const _ProductListView({
    required this.items,
    required this.isLoadingMore,
    required this.args,
  });

  final List<Product> items;
  final bool isLoadingMore;
  final ProductListArguments args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (items.isEmpty) {
      return const Center(child: Text('No products found.'));
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.extentAfter < 200) {
          ref
              .read(productListViewModelProvider(args).notifier)
              .loadNextPage();
        }
        return false;
      },
      child: ListView.builder(
        itemCount: items.length + (isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == items.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final product = items[index];
          return ListTile(
            key: ValueKey(product.id),
            title: Text(product.title),
            subtitle: Text(
              product.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () => ref
                .read(productListViewModelProvider(args).notifier)
                .onProductTapped(product.id),
          );
        },
      ),
    );
  }
}
