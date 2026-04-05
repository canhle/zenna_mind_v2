// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PlayerUiState {
  String get sessionTitle => throw _privateConstructorUsedError;
  String get sessionDescription => throw _privateConstructorUsedError;
  Duration get totalDuration => throw _privateConstructorUsedError;
  Duration get currentPosition => throw _privateConstructorUsedError;
  bool get isPlaying => throw _privateConstructorUsedError;
  PlayerEvent? get event => throw _privateConstructorUsedError;

  /// Create a copy of PlayerUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerUiStateCopyWith<PlayerUiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerUiStateCopyWith<$Res> {
  factory $PlayerUiStateCopyWith(
    PlayerUiState value,
    $Res Function(PlayerUiState) then,
  ) = _$PlayerUiStateCopyWithImpl<$Res, PlayerUiState>;
  @useResult
  $Res call({
    String sessionTitle,
    String sessionDescription,
    Duration totalDuration,
    Duration currentPosition,
    bool isPlaying,
    PlayerEvent? event,
  });
}

/// @nodoc
class _$PlayerUiStateCopyWithImpl<$Res, $Val extends PlayerUiState>
    implements $PlayerUiStateCopyWith<$Res> {
  _$PlayerUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionTitle = null,
    Object? sessionDescription = null,
    Object? totalDuration = null,
    Object? currentPosition = null,
    Object? isPlaying = null,
    Object? event = freezed,
  }) {
    return _then(
      _value.copyWith(
            sessionTitle: null == sessionTitle
                ? _value.sessionTitle
                : sessionTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            sessionDescription: null == sessionDescription
                ? _value.sessionDescription
                : sessionDescription // ignore: cast_nullable_to_non_nullable
                      as String,
            totalDuration: null == totalDuration
                ? _value.totalDuration
                : totalDuration // ignore: cast_nullable_to_non_nullable
                      as Duration,
            currentPosition: null == currentPosition
                ? _value.currentPosition
                : currentPosition // ignore: cast_nullable_to_non_nullable
                      as Duration,
            isPlaying: null == isPlaying
                ? _value.isPlaying
                : isPlaying // ignore: cast_nullable_to_non_nullable
                      as bool,
            event: freezed == event
                ? _value.event
                : event // ignore: cast_nullable_to_non_nullable
                      as PlayerEvent?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlayerUiStateImplCopyWith<$Res>
    implements $PlayerUiStateCopyWith<$Res> {
  factory _$$PlayerUiStateImplCopyWith(
    _$PlayerUiStateImpl value,
    $Res Function(_$PlayerUiStateImpl) then,
  ) = __$$PlayerUiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String sessionTitle,
    String sessionDescription,
    Duration totalDuration,
    Duration currentPosition,
    bool isPlaying,
    PlayerEvent? event,
  });
}

/// @nodoc
class __$$PlayerUiStateImplCopyWithImpl<$Res>
    extends _$PlayerUiStateCopyWithImpl<$Res, _$PlayerUiStateImpl>
    implements _$$PlayerUiStateImplCopyWith<$Res> {
  __$$PlayerUiStateImplCopyWithImpl(
    _$PlayerUiStateImpl _value,
    $Res Function(_$PlayerUiStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlayerUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionTitle = null,
    Object? sessionDescription = null,
    Object? totalDuration = null,
    Object? currentPosition = null,
    Object? isPlaying = null,
    Object? event = freezed,
  }) {
    return _then(
      _$PlayerUiStateImpl(
        sessionTitle: null == sessionTitle
            ? _value.sessionTitle
            : sessionTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        sessionDescription: null == sessionDescription
            ? _value.sessionDescription
            : sessionDescription // ignore: cast_nullable_to_non_nullable
                  as String,
        totalDuration: null == totalDuration
            ? _value.totalDuration
            : totalDuration // ignore: cast_nullable_to_non_nullable
                  as Duration,
        currentPosition: null == currentPosition
            ? _value.currentPosition
            : currentPosition // ignore: cast_nullable_to_non_nullable
                  as Duration,
        isPlaying: null == isPlaying
            ? _value.isPlaying
            : isPlaying // ignore: cast_nullable_to_non_nullable
                  as bool,
        event: freezed == event
            ? _value.event
            : event // ignore: cast_nullable_to_non_nullable
                  as PlayerEvent?,
      ),
    );
  }
}

/// @nodoc

class _$PlayerUiStateImpl implements _PlayerUiState {
  const _$PlayerUiStateImpl({
    this.sessionTitle = '10 phút xoa dịu căng thẳng',
    this.sessionDescription = 'Lắng nghe hơi thở, giải phóng áp lực',
    this.totalDuration = const Duration(minutes: 10),
    this.currentPosition = const Duration(minutes: 3, seconds: 48),
    this.isPlaying = true,
    this.event,
  });

  @override
  @JsonKey()
  final String sessionTitle;
  @override
  @JsonKey()
  final String sessionDescription;
  @override
  @JsonKey()
  final Duration totalDuration;
  @override
  @JsonKey()
  final Duration currentPosition;
  @override
  @JsonKey()
  final bool isPlaying;
  @override
  final PlayerEvent? event;

  @override
  String toString() {
    return 'PlayerUiState(sessionTitle: $sessionTitle, sessionDescription: $sessionDescription, totalDuration: $totalDuration, currentPosition: $currentPosition, isPlaying: $isPlaying, event: $event)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerUiStateImpl &&
            (identical(other.sessionTitle, sessionTitle) ||
                other.sessionTitle == sessionTitle) &&
            (identical(other.sessionDescription, sessionDescription) ||
                other.sessionDescription == sessionDescription) &&
            (identical(other.totalDuration, totalDuration) ||
                other.totalDuration == totalDuration) &&
            (identical(other.currentPosition, currentPosition) ||
                other.currentPosition == currentPosition) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.event, event) || other.event == event));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    sessionTitle,
    sessionDescription,
    totalDuration,
    currentPosition,
    isPlaying,
    event,
  );

  /// Create a copy of PlayerUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerUiStateImplCopyWith<_$PlayerUiStateImpl> get copyWith =>
      __$$PlayerUiStateImplCopyWithImpl<_$PlayerUiStateImpl>(this, _$identity);
}

abstract class _PlayerUiState implements PlayerUiState {
  const factory _PlayerUiState({
    final String sessionTitle,
    final String sessionDescription,
    final Duration totalDuration,
    final Duration currentPosition,
    final bool isPlaying,
    final PlayerEvent? event,
  }) = _$PlayerUiStateImpl;

  @override
  String get sessionTitle;
  @override
  String get sessionDescription;
  @override
  Duration get totalDuration;
  @override
  Duration get currentPosition;
  @override
  bool get isPlaying;
  @override
  PlayerEvent? get event;

  /// Create a copy of PlayerUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerUiStateImplCopyWith<_$PlayerUiStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
