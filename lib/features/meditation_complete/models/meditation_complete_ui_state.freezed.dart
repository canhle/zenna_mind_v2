// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meditation_complete_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MeditationCompleteUiState {
  int get streakCount => throw _privateConstructorUsedError;
  String get quoteText => throw _privateConstructorUsedError;
  String get quoteAuthor => throw _privateConstructorUsedError;
  String? get selectedMoodId => throw _privateConstructorUsedError;
  MeditationCompleteEvent? get event => throw _privateConstructorUsedError;

  /// Create a copy of MeditationCompleteUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeditationCompleteUiStateCopyWith<MeditationCompleteUiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeditationCompleteUiStateCopyWith<$Res> {
  factory $MeditationCompleteUiStateCopyWith(
    MeditationCompleteUiState value,
    $Res Function(MeditationCompleteUiState) then,
  ) = _$MeditationCompleteUiStateCopyWithImpl<$Res, MeditationCompleteUiState>;
  @useResult
  $Res call({
    int streakCount,
    String quoteText,
    String quoteAuthor,
    String? selectedMoodId,
    MeditationCompleteEvent? event,
  });
}

/// @nodoc
class _$MeditationCompleteUiStateCopyWithImpl<
  $Res,
  $Val extends MeditationCompleteUiState
>
    implements $MeditationCompleteUiStateCopyWith<$Res> {
  _$MeditationCompleteUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MeditationCompleteUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? streakCount = null,
    Object? quoteText = null,
    Object? quoteAuthor = null,
    Object? selectedMoodId = freezed,
    Object? event = freezed,
  }) {
    return _then(
      _value.copyWith(
            streakCount: null == streakCount
                ? _value.streakCount
                : streakCount // ignore: cast_nullable_to_non_nullable
                      as int,
            quoteText: null == quoteText
                ? _value.quoteText
                : quoteText // ignore: cast_nullable_to_non_nullable
                      as String,
            quoteAuthor: null == quoteAuthor
                ? _value.quoteAuthor
                : quoteAuthor // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedMoodId: freezed == selectedMoodId
                ? _value.selectedMoodId
                : selectedMoodId // ignore: cast_nullable_to_non_nullable
                      as String?,
            event: freezed == event
                ? _value.event
                : event // ignore: cast_nullable_to_non_nullable
                      as MeditationCompleteEvent?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MeditationCompleteUiStateImplCopyWith<$Res>
    implements $MeditationCompleteUiStateCopyWith<$Res> {
  factory _$$MeditationCompleteUiStateImplCopyWith(
    _$MeditationCompleteUiStateImpl value,
    $Res Function(_$MeditationCompleteUiStateImpl) then,
  ) = __$$MeditationCompleteUiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int streakCount,
    String quoteText,
    String quoteAuthor,
    String? selectedMoodId,
    MeditationCompleteEvent? event,
  });
}

/// @nodoc
class __$$MeditationCompleteUiStateImplCopyWithImpl<$Res>
    extends
        _$MeditationCompleteUiStateCopyWithImpl<
          $Res,
          _$MeditationCompleteUiStateImpl
        >
    implements _$$MeditationCompleteUiStateImplCopyWith<$Res> {
  __$$MeditationCompleteUiStateImplCopyWithImpl(
    _$MeditationCompleteUiStateImpl _value,
    $Res Function(_$MeditationCompleteUiStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MeditationCompleteUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? streakCount = null,
    Object? quoteText = null,
    Object? quoteAuthor = null,
    Object? selectedMoodId = freezed,
    Object? event = freezed,
  }) {
    return _then(
      _$MeditationCompleteUiStateImpl(
        streakCount: null == streakCount
            ? _value.streakCount
            : streakCount // ignore: cast_nullable_to_non_nullable
                  as int,
        quoteText: null == quoteText
            ? _value.quoteText
            : quoteText // ignore: cast_nullable_to_non_nullable
                  as String,
        quoteAuthor: null == quoteAuthor
            ? _value.quoteAuthor
            : quoteAuthor // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedMoodId: freezed == selectedMoodId
            ? _value.selectedMoodId
            : selectedMoodId // ignore: cast_nullable_to_non_nullable
                  as String?,
        event: freezed == event
            ? _value.event
            : event // ignore: cast_nullable_to_non_nullable
                  as MeditationCompleteEvent?,
      ),
    );
  }
}

/// @nodoc

class _$MeditationCompleteUiStateImpl implements _MeditationCompleteUiState {
  const _$MeditationCompleteUiStateImpl({
    this.streakCount = 0,
    this.quoteText = '',
    this.quoteAuthor = '',
    this.selectedMoodId,
    this.event,
  });

  @override
  @JsonKey()
  final int streakCount;
  @override
  @JsonKey()
  final String quoteText;
  @override
  @JsonKey()
  final String quoteAuthor;
  @override
  final String? selectedMoodId;
  @override
  final MeditationCompleteEvent? event;

  @override
  String toString() {
    return 'MeditationCompleteUiState(streakCount: $streakCount, quoteText: $quoteText, quoteAuthor: $quoteAuthor, selectedMoodId: $selectedMoodId, event: $event)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeditationCompleteUiStateImpl &&
            (identical(other.streakCount, streakCount) ||
                other.streakCount == streakCount) &&
            (identical(other.quoteText, quoteText) ||
                other.quoteText == quoteText) &&
            (identical(other.quoteAuthor, quoteAuthor) ||
                other.quoteAuthor == quoteAuthor) &&
            (identical(other.selectedMoodId, selectedMoodId) ||
                other.selectedMoodId == selectedMoodId) &&
            (identical(other.event, event) || other.event == event));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    streakCount,
    quoteText,
    quoteAuthor,
    selectedMoodId,
    event,
  );

  /// Create a copy of MeditationCompleteUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeditationCompleteUiStateImplCopyWith<_$MeditationCompleteUiStateImpl>
  get copyWith =>
      __$$MeditationCompleteUiStateImplCopyWithImpl<
        _$MeditationCompleteUiStateImpl
      >(this, _$identity);
}

abstract class _MeditationCompleteUiState implements MeditationCompleteUiState {
  const factory _MeditationCompleteUiState({
    final int streakCount,
    final String quoteText,
    final String quoteAuthor,
    final String? selectedMoodId,
    final MeditationCompleteEvent? event,
  }) = _$MeditationCompleteUiStateImpl;

  @override
  int get streakCount;
  @override
  String get quoteText;
  @override
  String get quoteAuthor;
  @override
  String? get selectedMoodId;
  @override
  MeditationCompleteEvent? get event;

  /// Create a copy of MeditationCompleteUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeditationCompleteUiStateImplCopyWith<_$MeditationCompleteUiStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
