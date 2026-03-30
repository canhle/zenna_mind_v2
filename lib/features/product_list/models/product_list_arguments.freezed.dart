// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_list_arguments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProductListArguments {
  String get categoryId => throw _privateConstructorUsedError;

  /// Create a copy of ProductListArguments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductListArgumentsCopyWith<ProductListArguments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductListArgumentsCopyWith<$Res> {
  factory $ProductListArgumentsCopyWith(
    ProductListArguments value,
    $Res Function(ProductListArguments) then,
  ) = _$ProductListArgumentsCopyWithImpl<$Res, ProductListArguments>;
  @useResult
  $Res call({String categoryId});
}

/// @nodoc
class _$ProductListArgumentsCopyWithImpl<
  $Res,
  $Val extends ProductListArguments
>
    implements $ProductListArgumentsCopyWith<$Res> {
  _$ProductListArgumentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductListArguments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? categoryId = null}) {
    return _then(
      _value.copyWith(
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductListArgumentsImplCopyWith<$Res>
    implements $ProductListArgumentsCopyWith<$Res> {
  factory _$$ProductListArgumentsImplCopyWith(
    _$ProductListArgumentsImpl value,
    $Res Function(_$ProductListArgumentsImpl) then,
  ) = __$$ProductListArgumentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String categoryId});
}

/// @nodoc
class __$$ProductListArgumentsImplCopyWithImpl<$Res>
    extends _$ProductListArgumentsCopyWithImpl<$Res, _$ProductListArgumentsImpl>
    implements _$$ProductListArgumentsImplCopyWith<$Res> {
  __$$ProductListArgumentsImplCopyWithImpl(
    _$ProductListArgumentsImpl _value,
    $Res Function(_$ProductListArgumentsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductListArguments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? categoryId = null}) {
    return _then(
      _$ProductListArgumentsImpl(
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ProductListArgumentsImpl implements _ProductListArguments {
  const _$ProductListArgumentsImpl({required this.categoryId});

  @override
  final String categoryId;

  @override
  String toString() {
    return 'ProductListArguments(categoryId: $categoryId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductListArgumentsImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, categoryId);

  /// Create a copy of ProductListArguments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductListArgumentsImplCopyWith<_$ProductListArgumentsImpl>
  get copyWith =>
      __$$ProductListArgumentsImplCopyWithImpl<_$ProductListArgumentsImpl>(
        this,
        _$identity,
      );
}

abstract class _ProductListArguments implements ProductListArguments {
  const factory _ProductListArguments({required final String categoryId}) =
      _$ProductListArgumentsImpl;

  @override
  String get categoryId;

  /// Create a copy of ProductListArguments
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductListArgumentsImplCopyWith<_$ProductListArgumentsImpl>
  get copyWith => throw _privateConstructorUsedError;
}
