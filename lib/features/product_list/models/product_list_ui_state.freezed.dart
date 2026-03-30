// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_list_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProductsData {
  List<Product> get items => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;

  /// Create a copy of ProductsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductsDataCopyWith<ProductsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductsDataCopyWith<$Res> {
  factory $ProductsDataCopyWith(
    ProductsData value,
    $Res Function(ProductsData) then,
  ) = _$ProductsDataCopyWithImpl<$Res, ProductsData>;
  @useResult
  $Res call({List<Product> items, int currentPage, bool hasMore});
}

/// @nodoc
class _$ProductsDataCopyWithImpl<$Res, $Val extends ProductsData>
    implements $ProductsDataCopyWith<$Res> {
  _$ProductsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? currentPage = null,
    Object? hasMore = null,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<Product>,
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductsDataImplCopyWith<$Res>
    implements $ProductsDataCopyWith<$Res> {
  factory _$$ProductsDataImplCopyWith(
    _$ProductsDataImpl value,
    $Res Function(_$ProductsDataImpl) then,
  ) = __$$ProductsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Product> items, int currentPage, bool hasMore});
}

/// @nodoc
class __$$ProductsDataImplCopyWithImpl<$Res>
    extends _$ProductsDataCopyWithImpl<$Res, _$ProductsDataImpl>
    implements _$$ProductsDataImplCopyWith<$Res> {
  __$$ProductsDataImplCopyWithImpl(
    _$ProductsDataImpl _value,
    $Res Function(_$ProductsDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? currentPage = null,
    Object? hasMore = null,
  }) {
    return _then(
      _$ProductsDataImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<Product>,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ProductsDataImpl implements _ProductsData {
  const _$ProductsDataImpl({
    required final List<Product> items,
    this.currentPage = 0,
    this.hasMore = false,
  }) : _items = items;

  final List<Product> _items;
  @override
  List<Product> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final bool hasMore;

  @override
  String toString() {
    return 'ProductsData(items: $items, currentPage: $currentPage, hasMore: $hasMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductsDataImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    currentPage,
    hasMore,
  );

  /// Create a copy of ProductsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductsDataImplCopyWith<_$ProductsDataImpl> get copyWith =>
      __$$ProductsDataImplCopyWithImpl<_$ProductsDataImpl>(this, _$identity);
}

abstract class _ProductsData implements ProductsData {
  const factory _ProductsData({
    required final List<Product> items,
    final int currentPage,
    final bool hasMore,
  }) = _$ProductsDataImpl;

  @override
  List<Product> get items;
  @override
  int get currentPage;
  @override
  bool get hasMore;

  /// Create a copy of ProductsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductsDataImplCopyWith<_$ProductsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ProductListUiState {
  AsyncValue<ProductsData> get products => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  ProductListEvent? get event => throw _privateConstructorUsedError;

  /// Create a copy of ProductListUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductListUiStateCopyWith<ProductListUiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductListUiStateCopyWith<$Res> {
  factory $ProductListUiStateCopyWith(
    ProductListUiState value,
    $Res Function(ProductListUiState) then,
  ) = _$ProductListUiStateCopyWithImpl<$Res, ProductListUiState>;
  @useResult
  $Res call({
    AsyncValue<ProductsData> products,
    bool isLoadingMore,
    ProductListEvent? event,
  });
}

/// @nodoc
class _$ProductListUiStateCopyWithImpl<$Res, $Val extends ProductListUiState>
    implements $ProductListUiStateCopyWith<$Res> {
  _$ProductListUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductListUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? isLoadingMore = null,
    Object? event = freezed,
  }) {
    return _then(
      _value.copyWith(
            products: null == products
                ? _value.products
                : products // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<ProductsData>,
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            event: freezed == event
                ? _value.event
                : event // ignore: cast_nullable_to_non_nullable
                      as ProductListEvent?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductListUiStateImplCopyWith<$Res>
    implements $ProductListUiStateCopyWith<$Res> {
  factory _$$ProductListUiStateImplCopyWith(
    _$ProductListUiStateImpl value,
    $Res Function(_$ProductListUiStateImpl) then,
  ) = __$$ProductListUiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AsyncValue<ProductsData> products,
    bool isLoadingMore,
    ProductListEvent? event,
  });
}

/// @nodoc
class __$$ProductListUiStateImplCopyWithImpl<$Res>
    extends _$ProductListUiStateCopyWithImpl<$Res, _$ProductListUiStateImpl>
    implements _$$ProductListUiStateImplCopyWith<$Res> {
  __$$ProductListUiStateImplCopyWithImpl(
    _$ProductListUiStateImpl _value,
    $Res Function(_$ProductListUiStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductListUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? isLoadingMore = null,
    Object? event = freezed,
  }) {
    return _then(
      _$ProductListUiStateImpl(
        products: null == products
            ? _value.products
            : products // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<ProductsData>,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        event: freezed == event
            ? _value.event
            : event // ignore: cast_nullable_to_non_nullable
                  as ProductListEvent?,
      ),
    );
  }
}

/// @nodoc

class _$ProductListUiStateImpl implements _ProductListUiState {
  const _$ProductListUiStateImpl({
    this.products = const AsyncValue.loading(),
    this.isLoadingMore = false,
    this.event,
  });

  @override
  @JsonKey()
  final AsyncValue<ProductsData> products;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  final ProductListEvent? event;

  @override
  String toString() {
    return 'ProductListUiState(products: $products, isLoadingMore: $isLoadingMore, event: $event)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductListUiStateImpl &&
            (identical(other.products, products) ||
                other.products == products) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.event, event) || other.event == event));
  }

  @override
  int get hashCode => Object.hash(runtimeType, products, isLoadingMore, event);

  /// Create a copy of ProductListUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductListUiStateImplCopyWith<_$ProductListUiStateImpl> get copyWith =>
      __$$ProductListUiStateImplCopyWithImpl<_$ProductListUiStateImpl>(
        this,
        _$identity,
      );
}

abstract class _ProductListUiState implements ProductListUiState {
  const factory _ProductListUiState({
    final AsyncValue<ProductsData> products,
    final bool isLoadingMore,
    final ProductListEvent? event,
  }) = _$ProductListUiStateImpl;

  @override
  AsyncValue<ProductsData> get products;
  @override
  bool get isLoadingMore;
  @override
  ProductListEvent? get event;

  /// Create a copy of ProductListUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductListUiStateImplCopyWith<_$ProductListUiStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
