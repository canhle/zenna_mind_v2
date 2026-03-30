// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productListViewModelHash() =>
    r'352c4a4bece4fccda0aad34cd245787201cb0563';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ProductListViewModel
    extends BuildlessAutoDisposeNotifier<ProductListUiState> {
  late final ProductListArguments args;

  ProductListUiState build(ProductListArguments args);
}

/// See also [ProductListViewModel].
@ProviderFor(ProductListViewModel)
const productListViewModelProvider = ProductListViewModelFamily();

/// See also [ProductListViewModel].
class ProductListViewModelFamily extends Family<ProductListUiState> {
  /// See also [ProductListViewModel].
  const ProductListViewModelFamily();

  /// See also [ProductListViewModel].
  ProductListViewModelProvider call(ProductListArguments args) {
    return ProductListViewModelProvider(args);
  }

  @override
  ProductListViewModelProvider getProviderOverride(
    covariant ProductListViewModelProvider provider,
  ) {
    return call(provider.args);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productListViewModelProvider';
}

/// See also [ProductListViewModel].
class ProductListViewModelProvider
    extends
        AutoDisposeNotifierProviderImpl<
          ProductListViewModel,
          ProductListUiState
        > {
  /// See also [ProductListViewModel].
  ProductListViewModelProvider(ProductListArguments args)
    : this._internal(
        () => ProductListViewModel()..args = args,
        from: productListViewModelProvider,
        name: r'productListViewModelProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$productListViewModelHash,
        dependencies: ProductListViewModelFamily._dependencies,
        allTransitiveDependencies:
            ProductListViewModelFamily._allTransitiveDependencies,
        args: args,
      );

  ProductListViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.args,
  }) : super.internal();

  final ProductListArguments args;

  @override
  ProductListUiState runNotifierBuild(covariant ProductListViewModel notifier) {
    return notifier.build(args);
  }

  @override
  Override overrideWith(ProductListViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductListViewModelProvider._internal(
        () => create()..args = args,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        args: args,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ProductListViewModel, ProductListUiState>
  createElement() {
    return _ProductListViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductListViewModelProvider && other.args == args;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, args.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductListViewModelRef
    on AutoDisposeNotifierProviderRef<ProductListUiState> {
  /// The parameter `args` of this provider.
  ProductListArguments get args;
}

class _ProductListViewModelProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          ProductListViewModel,
          ProductListUiState
        >
    with ProductListViewModelRef {
  _ProductListViewModelProviderElement(super.provider);

  @override
  ProductListArguments get args =>
      (origin as ProductListViewModelProvider).args;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
