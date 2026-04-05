// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streak_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$StreakUiState {
  bool get isTodayCompleted => throw _privateConstructorUsedError;
  int get streakDays => throw _privateConstructorUsedError;
  int get totalMinutes => throw _privateConstructorUsedError;
  List<bool> get weekDays => throw _privateConstructorUsedError;
  StreakEvent? get event => throw _privateConstructorUsedError;

  /// Create a copy of StreakUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StreakUiStateCopyWith<StreakUiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreakUiStateCopyWith<$Res> {
  factory $StreakUiStateCopyWith(
    StreakUiState value,
    $Res Function(StreakUiState) then,
  ) = _$StreakUiStateCopyWithImpl<$Res, StreakUiState>;
  @useResult
  $Res call({
    bool isTodayCompleted,
    int streakDays,
    int totalMinutes,
    List<bool> weekDays,
    StreakEvent? event,
  });
}

/// @nodoc
class _$StreakUiStateCopyWithImpl<$Res, $Val extends StreakUiState>
    implements $StreakUiStateCopyWith<$Res> {
  _$StreakUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreakUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isTodayCompleted = null,
    Object? streakDays = null,
    Object? totalMinutes = null,
    Object? weekDays = null,
    Object? event = freezed,
  }) {
    return _then(
      _value.copyWith(
            isTodayCompleted: null == isTodayCompleted
                ? _value.isTodayCompleted
                : isTodayCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            streakDays: null == streakDays
                ? _value.streakDays
                : streakDays // ignore: cast_nullable_to_non_nullable
                      as int,
            totalMinutes: null == totalMinutes
                ? _value.totalMinutes
                : totalMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            weekDays: null == weekDays
                ? _value.weekDays
                : weekDays // ignore: cast_nullable_to_non_nullable
                      as List<bool>,
            event: freezed == event
                ? _value.event
                : event // ignore: cast_nullable_to_non_nullable
                      as StreakEvent?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StreakUiStateImplCopyWith<$Res>
    implements $StreakUiStateCopyWith<$Res> {
  factory _$$StreakUiStateImplCopyWith(
    _$StreakUiStateImpl value,
    $Res Function(_$StreakUiStateImpl) then,
  ) = __$$StreakUiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isTodayCompleted,
    int streakDays,
    int totalMinutes,
    List<bool> weekDays,
    StreakEvent? event,
  });
}

/// @nodoc
class __$$StreakUiStateImplCopyWithImpl<$Res>
    extends _$StreakUiStateCopyWithImpl<$Res, _$StreakUiStateImpl>
    implements _$$StreakUiStateImplCopyWith<$Res> {
  __$$StreakUiStateImplCopyWithImpl(
    _$StreakUiStateImpl _value,
    $Res Function(_$StreakUiStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StreakUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isTodayCompleted = null,
    Object? streakDays = null,
    Object? totalMinutes = null,
    Object? weekDays = null,
    Object? event = freezed,
  }) {
    return _then(
      _$StreakUiStateImpl(
        isTodayCompleted: null == isTodayCompleted
            ? _value.isTodayCompleted
            : isTodayCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        streakDays: null == streakDays
            ? _value.streakDays
            : streakDays // ignore: cast_nullable_to_non_nullable
                  as int,
        totalMinutes: null == totalMinutes
            ? _value.totalMinutes
            : totalMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        weekDays: null == weekDays
            ? _value._weekDays
            : weekDays // ignore: cast_nullable_to_non_nullable
                  as List<bool>,
        event: freezed == event
            ? _value.event
            : event // ignore: cast_nullable_to_non_nullable
                  as StreakEvent?,
      ),
    );
  }
}

/// @nodoc

class _$StreakUiStateImpl implements _StreakUiState {
  const _$StreakUiStateImpl({
    this.isTodayCompleted = false,
    this.streakDays = 7,
    this.totalMinutes = 84,
    final List<bool> weekDays = const [
      true,
      true,
      true,
      true,
      true,
      true,
      false,
    ],
    this.event,
  }) : _weekDays = weekDays;

  @override
  @JsonKey()
  final bool isTodayCompleted;
  @override
  @JsonKey()
  final int streakDays;
  @override
  @JsonKey()
  final int totalMinutes;
  final List<bool> _weekDays;
  @override
  @JsonKey()
  List<bool> get weekDays {
    if (_weekDays is EqualUnmodifiableListView) return _weekDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weekDays);
  }

  @override
  final StreakEvent? event;

  @override
  String toString() {
    return 'StreakUiState(isTodayCompleted: $isTodayCompleted, streakDays: $streakDays, totalMinutes: $totalMinutes, weekDays: $weekDays, event: $event)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreakUiStateImpl &&
            (identical(other.isTodayCompleted, isTodayCompleted) ||
                other.isTodayCompleted == isTodayCompleted) &&
            (identical(other.streakDays, streakDays) ||
                other.streakDays == streakDays) &&
            (identical(other.totalMinutes, totalMinutes) ||
                other.totalMinutes == totalMinutes) &&
            const DeepCollectionEquality().equals(other._weekDays, _weekDays) &&
            (identical(other.event, event) || other.event == event));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isTodayCompleted,
    streakDays,
    totalMinutes,
    const DeepCollectionEquality().hash(_weekDays),
    event,
  );

  /// Create a copy of StreakUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreakUiStateImplCopyWith<_$StreakUiStateImpl> get copyWith =>
      __$$StreakUiStateImplCopyWithImpl<_$StreakUiStateImpl>(this, _$identity);
}

abstract class _StreakUiState implements StreakUiState {
  const factory _StreakUiState({
    final bool isTodayCompleted,
    final int streakDays,
    final int totalMinutes,
    final List<bool> weekDays,
    final StreakEvent? event,
  }) = _$StreakUiStateImpl;

  @override
  bool get isTodayCompleted;
  @override
  int get streakDays;
  @override
  int get totalMinutes;
  @override
  List<bool> get weekDays;
  @override
  StreakEvent? get event;

  /// Create a copy of StreakUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreakUiStateImplCopyWith<_$StreakUiStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
