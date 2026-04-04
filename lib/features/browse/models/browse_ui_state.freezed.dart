// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browse_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BrowseUiState {
  int get selectedTabIndex => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  BrowseEvent? get event => throw _privateConstructorUsedError;

  /// Create a copy of BrowseUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrowseUiStateCopyWith<BrowseUiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrowseUiStateCopyWith<$Res> {
  factory $BrowseUiStateCopyWith(
    BrowseUiState value,
    $Res Function(BrowseUiState) then,
  ) = _$BrowseUiStateCopyWithImpl<$Res, BrowseUiState>;
  @useResult
  $Res call({int selectedTabIndex, String searchQuery, BrowseEvent? event});
}

/// @nodoc
class _$BrowseUiStateCopyWithImpl<$Res, $Val extends BrowseUiState>
    implements $BrowseUiStateCopyWith<$Res> {
  _$BrowseUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrowseUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedTabIndex = null,
    Object? searchQuery = null,
    Object? event = freezed,
  }) {
    return _then(
      _value.copyWith(
            selectedTabIndex: null == selectedTabIndex
                ? _value.selectedTabIndex
                : selectedTabIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            searchQuery: null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            event: freezed == event
                ? _value.event
                : event // ignore: cast_nullable_to_non_nullable
                      as BrowseEvent?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BrowseUiStateImplCopyWith<$Res>
    implements $BrowseUiStateCopyWith<$Res> {
  factory _$$BrowseUiStateImplCopyWith(
    _$BrowseUiStateImpl value,
    $Res Function(_$BrowseUiStateImpl) then,
  ) = __$$BrowseUiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int selectedTabIndex, String searchQuery, BrowseEvent? event});
}

/// @nodoc
class __$$BrowseUiStateImplCopyWithImpl<$Res>
    extends _$BrowseUiStateCopyWithImpl<$Res, _$BrowseUiStateImpl>
    implements _$$BrowseUiStateImplCopyWith<$Res> {
  __$$BrowseUiStateImplCopyWithImpl(
    _$BrowseUiStateImpl _value,
    $Res Function(_$BrowseUiStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BrowseUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedTabIndex = null,
    Object? searchQuery = null,
    Object? event = freezed,
  }) {
    return _then(
      _$BrowseUiStateImpl(
        selectedTabIndex: null == selectedTabIndex
            ? _value.selectedTabIndex
            : selectedTabIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        event: freezed == event
            ? _value.event
            : event // ignore: cast_nullable_to_non_nullable
                  as BrowseEvent?,
      ),
    );
  }
}

/// @nodoc

class _$BrowseUiStateImpl implements _BrowseUiState {
  const _$BrowseUiStateImpl({
    this.selectedTabIndex = 0,
    this.searchQuery = '',
    this.event,
  });

  @override
  @JsonKey()
  final int selectedTabIndex;
  @override
  @JsonKey()
  final String searchQuery;
  @override
  final BrowseEvent? event;

  @override
  String toString() {
    return 'BrowseUiState(selectedTabIndex: $selectedTabIndex, searchQuery: $searchQuery, event: $event)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrowseUiStateImpl &&
            (identical(other.selectedTabIndex, selectedTabIndex) ||
                other.selectedTabIndex == selectedTabIndex) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.event, event) || other.event == event));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, selectedTabIndex, searchQuery, event);

  /// Create a copy of BrowseUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrowseUiStateImplCopyWith<_$BrowseUiStateImpl> get copyWith =>
      __$$BrowseUiStateImplCopyWithImpl<_$BrowseUiStateImpl>(this, _$identity);
}

abstract class _BrowseUiState implements BrowseUiState {
  const factory _BrowseUiState({
    final int selectedTabIndex,
    final String searchQuery,
    final BrowseEvent? event,
  }) = _$BrowseUiStateImpl;

  @override
  int get selectedTabIndex;
  @override
  String get searchQuery;
  @override
  BrowseEvent? get event;

  /// Create a copy of BrowseUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrowseUiStateImplCopyWith<_$BrowseUiStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
