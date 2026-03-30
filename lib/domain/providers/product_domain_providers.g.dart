// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_domain_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getProductsUseCaseHash() =>
    r'09d0b9ea19abd152029630cca95ad2c4c67700aa';

/// See also [getProductsUseCase].
@ProviderFor(getProductsUseCase)
final getProductsUseCaseProvider =
    AutoDisposeProvider<GetProductsUseCase>.internal(
      getProductsUseCase,
      name: r'getProductsUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getProductsUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetProductsUseCaseRef = AutoDisposeProviderRef<GetProductsUseCase>;
String _$productsHash() => r'eed8b3ac08c5aaa936852d15c51cd2391a1903e3';

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

/// See also [products].
@ProviderFor(products)
const productsProvider = ProductsFamily();

/// See also [products].
class ProductsFamily extends Family<AsyncValue<List<Product>>> {
  /// See also [products].
  const ProductsFamily();

  /// See also [products].
  ProductsProvider call({required String categoryId, required int page}) {
    return ProductsProvider(categoryId: categoryId, page: page);
  }

  @override
  ProductsProvider getProviderOverride(covariant ProductsProvider provider) {
    return call(categoryId: provider.categoryId, page: provider.page);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productsProvider';
}

/// See also [products].
class ProductsProvider extends AutoDisposeFutureProvider<List<Product>> {
  /// See also [products].
  ProductsProvider({required String categoryId, required int page})
    : this._internal(
        (ref) =>
            products(ref as ProductsRef, categoryId: categoryId, page: page),
        from: productsProvider,
        name: r'productsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$productsHash,
        dependencies: ProductsFamily._dependencies,
        allTransitiveDependencies: ProductsFamily._allTransitiveDependencies,
        categoryId: categoryId,
        page: page,
      );

  ProductsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
    required this.page,
  }) : super.internal();

  final String categoryId;
  final int page;

  @override
  Override overrideWith(
    FutureOr<List<Product>> Function(ProductsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductsProvider._internal(
        (ref) => create(ref as ProductsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
        page: page,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Product>> createElement() {
    return _ProductsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductsProvider &&
        other.categoryId == categoryId &&
        other.page == page;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductsRef on AutoDisposeFutureProviderRef<List<Product>> {
  /// The parameter `categoryId` of this provider.
  String get categoryId;

  /// The parameter `page` of this provider.
  int get page;
}

class _ProductsProviderElement
    extends AutoDisposeFutureProviderElement<List<Product>>
    with ProductsRef {
  _ProductsProviderElement(super.provider);

  @override
  String get categoryId => (origin as ProductsProvider).categoryId;
  @override
  int get page => (origin as ProductsProvider).page;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
