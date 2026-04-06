// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meditation_complete_arguments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MeditationCompleteArguments {
  int get streakCount => throw _privateConstructorUsedError;

  /// Create a copy of MeditationCompleteArguments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeditationCompleteArgumentsCopyWith<MeditationCompleteArguments>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeditationCompleteArgumentsCopyWith<$Res> {
  factory $MeditationCompleteArgumentsCopyWith(
    MeditationCompleteArguments value,
    $Res Function(MeditationCompleteArguments) then,
  ) =
      _$MeditationCompleteArgumentsCopyWithImpl<
        $Res,
        MeditationCompleteArguments
      >;
  @useResult
  $Res call({int streakCount});
}

/// @nodoc
class _$MeditationCompleteArgumentsCopyWithImpl<
  $Res,
  $Val extends MeditationCompleteArguments
>
    implements $MeditationCompleteArgumentsCopyWith<$Res> {
  _$MeditationCompleteArgumentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MeditationCompleteArguments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? streakCount = null}) {
    return _then(
      _value.copyWith(
            streakCount: null == streakCount
                ? _value.streakCount
                : streakCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MeditationCompleteArgumentsImplCopyWith<$Res>
    implements $MeditationCompleteArgumentsCopyWith<$Res> {
  factory _$$MeditationCompleteArgumentsImplCopyWith(
    _$MeditationCompleteArgumentsImpl value,
    $Res Function(_$MeditationCompleteArgumentsImpl) then,
  ) = __$$MeditationCompleteArgumentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int streakCount});
}

/// @nodoc
class __$$MeditationCompleteArgumentsImplCopyWithImpl<$Res>
    extends
        _$MeditationCompleteArgumentsCopyWithImpl<
          $Res,
          _$MeditationCompleteArgumentsImpl
        >
    implements _$$MeditationCompleteArgumentsImplCopyWith<$Res> {
  __$$MeditationCompleteArgumentsImplCopyWithImpl(
    _$MeditationCompleteArgumentsImpl _value,
    $Res Function(_$MeditationCompleteArgumentsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MeditationCompleteArguments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? streakCount = null}) {
    return _then(
      _$MeditationCompleteArgumentsImpl(
        streakCount: null == streakCount
            ? _value.streakCount
            : streakCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$MeditationCompleteArgumentsImpl
    implements _MeditationCompleteArguments {
  const _$MeditationCompleteArgumentsImpl({this.streakCount = 0});

  @override
  @JsonKey()
  final int streakCount;

  @override
  String toString() {
    return 'MeditationCompleteArguments(streakCount: $streakCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeditationCompleteArgumentsImpl &&
            (identical(other.streakCount, streakCount) ||
                other.streakCount == streakCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, streakCount);

  /// Create a copy of MeditationCompleteArguments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeditationCompleteArgumentsImplCopyWith<_$MeditationCompleteArgumentsImpl>
  get copyWith =>
      __$$MeditationCompleteArgumentsImplCopyWithImpl<
        _$MeditationCompleteArgumentsImpl
      >(this, _$identity);
}

abstract class _MeditationCompleteArguments
    implements MeditationCompleteArguments {
  const factory _MeditationCompleteArguments({final int streakCount}) =
      _$MeditationCompleteArgumentsImpl;

  @override
  int get streakCount;

  /// Create a copy of MeditationCompleteArguments
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeditationCompleteArgumentsImplCopyWith<_$MeditationCompleteArgumentsImpl>
  get copyWith => throw _privateConstructorUsedError;
}
