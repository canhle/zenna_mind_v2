// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'welcome_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WelcomeUiState {
  AsyncValue<void> get signInStatus => throw _privateConstructorUsedError;
  WelcomeEvent? get event => throw _privateConstructorUsedError;

  /// Create a copy of WelcomeUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WelcomeUiStateCopyWith<WelcomeUiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WelcomeUiStateCopyWith<$Res> {
  factory $WelcomeUiStateCopyWith(
    WelcomeUiState value,
    $Res Function(WelcomeUiState) then,
  ) = _$WelcomeUiStateCopyWithImpl<$Res, WelcomeUiState>;
  @useResult
  $Res call({AsyncValue<void> signInStatus, WelcomeEvent? event});
}

/// @nodoc
class _$WelcomeUiStateCopyWithImpl<$Res, $Val extends WelcomeUiState>
    implements $WelcomeUiStateCopyWith<$Res> {
  _$WelcomeUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WelcomeUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? signInStatus = null, Object? event = freezed}) {
    return _then(
      _value.copyWith(
            signInStatus: null == signInStatus
                ? _value.signInStatus
                : signInStatus // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<void>,
            event: freezed == event
                ? _value.event
                : event // ignore: cast_nullable_to_non_nullable
                      as WelcomeEvent?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WelcomeUiStateImplCopyWith<$Res>
    implements $WelcomeUiStateCopyWith<$Res> {
  factory _$$WelcomeUiStateImplCopyWith(
    _$WelcomeUiStateImpl value,
    $Res Function(_$WelcomeUiStateImpl) then,
  ) = __$$WelcomeUiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AsyncValue<void> signInStatus, WelcomeEvent? event});
}

/// @nodoc
class __$$WelcomeUiStateImplCopyWithImpl<$Res>
    extends _$WelcomeUiStateCopyWithImpl<$Res, _$WelcomeUiStateImpl>
    implements _$$WelcomeUiStateImplCopyWith<$Res> {
  __$$WelcomeUiStateImplCopyWithImpl(
    _$WelcomeUiStateImpl _value,
    $Res Function(_$WelcomeUiStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WelcomeUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? signInStatus = null, Object? event = freezed}) {
    return _then(
      _$WelcomeUiStateImpl(
        signInStatus: null == signInStatus
            ? _value.signInStatus
            : signInStatus // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<void>,
        event: freezed == event
            ? _value.event
            : event // ignore: cast_nullable_to_non_nullable
                  as WelcomeEvent?,
      ),
    );
  }
}

/// @nodoc

class _$WelcomeUiStateImpl implements _WelcomeUiState {
  const _$WelcomeUiStateImpl({
    this.signInStatus = const AsyncValue<void>.data(null),
    this.event,
  });

  @override
  @JsonKey()
  final AsyncValue<void> signInStatus;
  @override
  final WelcomeEvent? event;

  @override
  String toString() {
    return 'WelcomeUiState(signInStatus: $signInStatus, event: $event)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WelcomeUiStateImpl &&
            (identical(other.signInStatus, signInStatus) ||
                other.signInStatus == signInStatus) &&
            (identical(other.event, event) || other.event == event));
  }

  @override
  int get hashCode => Object.hash(runtimeType, signInStatus, event);

  /// Create a copy of WelcomeUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WelcomeUiStateImplCopyWith<_$WelcomeUiStateImpl> get copyWith =>
      __$$WelcomeUiStateImplCopyWithImpl<_$WelcomeUiStateImpl>(
        this,
        _$identity,
      );
}

abstract class _WelcomeUiState implements WelcomeUiState {
  const factory _WelcomeUiState({
    final AsyncValue<void> signInStatus,
    final WelcomeEvent? event,
  }) = _$WelcomeUiStateImpl;

  @override
  AsyncValue<void> get signInStatus;
  @override
  WelcomeEvent? get event;

  /// Create a copy of WelcomeUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WelcomeUiStateImplCopyWith<_$WelcomeUiStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
