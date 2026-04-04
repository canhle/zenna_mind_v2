// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HomeUiState {
  MoodType? get selectedMood => throw _privateConstructorUsedError;
  HomeEvent? get event => throw _privateConstructorUsedError;

  /// Create a copy of HomeUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeUiStateCopyWith<HomeUiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeUiStateCopyWith<$Res> {
  factory $HomeUiStateCopyWith(
    HomeUiState value,
    $Res Function(HomeUiState) then,
  ) = _$HomeUiStateCopyWithImpl<$Res, HomeUiState>;
  @useResult
  $Res call({MoodType? selectedMood, HomeEvent? event});
}

/// @nodoc
class _$HomeUiStateCopyWithImpl<$Res, $Val extends HomeUiState>
    implements $HomeUiStateCopyWith<$Res> {
  _$HomeUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? selectedMood = freezed, Object? event = freezed}) {
    return _then(
      _value.copyWith(
            selectedMood: freezed == selectedMood
                ? _value.selectedMood
                : selectedMood // ignore: cast_nullable_to_non_nullable
                      as MoodType?,
            event: freezed == event
                ? _value.event
                : event // ignore: cast_nullable_to_non_nullable
                      as HomeEvent?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HomeUiStateImplCopyWith<$Res>
    implements $HomeUiStateCopyWith<$Res> {
  factory _$$HomeUiStateImplCopyWith(
    _$HomeUiStateImpl value,
    $Res Function(_$HomeUiStateImpl) then,
  ) = __$$HomeUiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MoodType? selectedMood, HomeEvent? event});
}

/// @nodoc
class __$$HomeUiStateImplCopyWithImpl<$Res>
    extends _$HomeUiStateCopyWithImpl<$Res, _$HomeUiStateImpl>
    implements _$$HomeUiStateImplCopyWith<$Res> {
  __$$HomeUiStateImplCopyWithImpl(
    _$HomeUiStateImpl _value,
    $Res Function(_$HomeUiStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? selectedMood = freezed, Object? event = freezed}) {
    return _then(
      _$HomeUiStateImpl(
        selectedMood: freezed == selectedMood
            ? _value.selectedMood
            : selectedMood // ignore: cast_nullable_to_non_nullable
                  as MoodType?,
        event: freezed == event
            ? _value.event
            : event // ignore: cast_nullable_to_non_nullable
                  as HomeEvent?,
      ),
    );
  }
}

/// @nodoc

class _$HomeUiStateImpl implements _HomeUiState {
  const _$HomeUiStateImpl({this.selectedMood = null, this.event});

  @override
  @JsonKey()
  final MoodType? selectedMood;
  @override
  final HomeEvent? event;

  @override
  String toString() {
    return 'HomeUiState(selectedMood: $selectedMood, event: $event)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeUiStateImpl &&
            (identical(other.selectedMood, selectedMood) ||
                other.selectedMood == selectedMood) &&
            (identical(other.event, event) || other.event == event));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedMood, event);

  /// Create a copy of HomeUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeUiStateImplCopyWith<_$HomeUiStateImpl> get copyWith =>
      __$$HomeUiStateImplCopyWithImpl<_$HomeUiStateImpl>(this, _$identity);
}

abstract class _HomeUiState implements HomeUiState {
  const factory _HomeUiState({
    final MoodType? selectedMood,
    final HomeEvent? event,
  }) = _$HomeUiStateImpl;

  @override
  MoodType? get selectedMood;
  @override
  HomeEvent? get event;

  /// Create a copy of HomeUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeUiStateImplCopyWith<_$HomeUiStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
