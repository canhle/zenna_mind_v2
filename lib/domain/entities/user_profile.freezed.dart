// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserSettings {
  bool get notificationEnabled => throw _privateConstructorUsedError;
  String get notificationTime => throw _privateConstructorUsedError;
  Duration get defaultDuration => throw _privateConstructorUsedError;
  String get backgroundSound => throw _privateConstructorUsedError;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSettingsCopyWith<UserSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSettingsCopyWith<$Res> {
  factory $UserSettingsCopyWith(
    UserSettings value,
    $Res Function(UserSettings) then,
  ) = _$UserSettingsCopyWithImpl<$Res, UserSettings>;
  @useResult
  $Res call({
    bool notificationEnabled,
    String notificationTime,
    Duration defaultDuration,
    String backgroundSound,
  });
}

/// @nodoc
class _$UserSettingsCopyWithImpl<$Res, $Val extends UserSettings>
    implements $UserSettingsCopyWith<$Res> {
  _$UserSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationEnabled = null,
    Object? notificationTime = null,
    Object? defaultDuration = null,
    Object? backgroundSound = null,
  }) {
    return _then(
      _value.copyWith(
            notificationEnabled: null == notificationEnabled
                ? _value.notificationEnabled
                : notificationEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            notificationTime: null == notificationTime
                ? _value.notificationTime
                : notificationTime // ignore: cast_nullable_to_non_nullable
                      as String,
            defaultDuration: null == defaultDuration
                ? _value.defaultDuration
                : defaultDuration // ignore: cast_nullable_to_non_nullable
                      as Duration,
            backgroundSound: null == backgroundSound
                ? _value.backgroundSound
                : backgroundSound // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserSettingsImplCopyWith<$Res>
    implements $UserSettingsCopyWith<$Res> {
  factory _$$UserSettingsImplCopyWith(
    _$UserSettingsImpl value,
    $Res Function(_$UserSettingsImpl) then,
  ) = __$$UserSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool notificationEnabled,
    String notificationTime,
    Duration defaultDuration,
    String backgroundSound,
  });
}

/// @nodoc
class __$$UserSettingsImplCopyWithImpl<$Res>
    extends _$UserSettingsCopyWithImpl<$Res, _$UserSettingsImpl>
    implements _$$UserSettingsImplCopyWith<$Res> {
  __$$UserSettingsImplCopyWithImpl(
    _$UserSettingsImpl _value,
    $Res Function(_$UserSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationEnabled = null,
    Object? notificationTime = null,
    Object? defaultDuration = null,
    Object? backgroundSound = null,
  }) {
    return _then(
      _$UserSettingsImpl(
        notificationEnabled: null == notificationEnabled
            ? _value.notificationEnabled
            : notificationEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        notificationTime: null == notificationTime
            ? _value.notificationTime
            : notificationTime // ignore: cast_nullable_to_non_nullable
                  as String,
        defaultDuration: null == defaultDuration
            ? _value.defaultDuration
            : defaultDuration // ignore: cast_nullable_to_non_nullable
                  as Duration,
        backgroundSound: null == backgroundSound
            ? _value.backgroundSound
            : backgroundSound // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UserSettingsImpl implements _UserSettings {
  const _$UserSettingsImpl({
    this.notificationEnabled = false,
    this.notificationTime = '07:00',
    this.defaultDuration = const Duration(minutes: 10),
    this.backgroundSound = 'rain',
  });

  @override
  @JsonKey()
  final bool notificationEnabled;
  @override
  @JsonKey()
  final String notificationTime;
  @override
  @JsonKey()
  final Duration defaultDuration;
  @override
  @JsonKey()
  final String backgroundSound;

  @override
  String toString() {
    return 'UserSettings(notificationEnabled: $notificationEnabled, notificationTime: $notificationTime, defaultDuration: $defaultDuration, backgroundSound: $backgroundSound)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSettingsImpl &&
            (identical(other.notificationEnabled, notificationEnabled) ||
                other.notificationEnabled == notificationEnabled) &&
            (identical(other.notificationTime, notificationTime) ||
                other.notificationTime == notificationTime) &&
            (identical(other.defaultDuration, defaultDuration) ||
                other.defaultDuration == defaultDuration) &&
            (identical(other.backgroundSound, backgroundSound) ||
                other.backgroundSound == backgroundSound));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    notificationEnabled,
    notificationTime,
    defaultDuration,
    backgroundSound,
  );

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      __$$UserSettingsImplCopyWithImpl<_$UserSettingsImpl>(this, _$identity);
}

abstract class _UserSettings implements UserSettings {
  const factory _UserSettings({
    final bool notificationEnabled,
    final String notificationTime,
    final Duration defaultDuration,
    final String backgroundSound,
  }) = _$UserSettingsImpl;

  @override
  bool get notificationEnabled;
  @override
  String get notificationTime;
  @override
  Duration get defaultDuration;
  @override
  String get backgroundSound;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserProfile {
  String get uid => throw _privateConstructorUsedError;
  bool get isAnonymous => throw _privateConstructorUsedError;
  AuthProvider get provider => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  int get longestStreak => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get lastActiveAt => throw _privateConstructorUsedError;
  UserSettings get settings => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
    UserProfile value,
    $Res Function(UserProfile) then,
  ) = _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call({
    String uid,
    bool isAnonymous,
    AuthProvider provider,
    String? email,
    String? displayName,
    String? avatarUrl,
    int longestStreak,
    DateTime createdAt,
    DateTime lastActiveAt,
    UserSettings settings,
  });

  $UserSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? isAnonymous = null,
    Object? provider = null,
    Object? email = freezed,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? longestStreak = null,
    Object? createdAt = null,
    Object? lastActiveAt = null,
    Object? settings = null,
  }) {
    return _then(
      _value.copyWith(
            uid: null == uid
                ? _value.uid
                : uid // ignore: cast_nullable_to_non_nullable
                      as String,
            isAnonymous: null == isAnonymous
                ? _value.isAnonymous
                : isAnonymous // ignore: cast_nullable_to_non_nullable
                      as bool,
            provider: null == provider
                ? _value.provider
                : provider // ignore: cast_nullable_to_non_nullable
                      as AuthProvider,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            displayName: freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            longestStreak: null == longestStreak
                ? _value.longestStreak
                : longestStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastActiveAt: null == lastActiveAt
                ? _value.lastActiveAt
                : lastActiveAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            settings: null == settings
                ? _value.settings
                : settings // ignore: cast_nullable_to_non_nullable
                      as UserSettings,
          )
          as $Val,
    );
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSettingsCopyWith<$Res> get settings {
    return $UserSettingsCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
    _$UserProfileImpl value,
    $Res Function(_$UserProfileImpl) then,
  ) = __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String uid,
    bool isAnonymous,
    AuthProvider provider,
    String? email,
    String? displayName,
    String? avatarUrl,
    int longestStreak,
    DateTime createdAt,
    DateTime lastActiveAt,
    UserSettings settings,
  });

  @override
  $UserSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
    _$UserProfileImpl _value,
    $Res Function(_$UserProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? isAnonymous = null,
    Object? provider = null,
    Object? email = freezed,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? longestStreak = null,
    Object? createdAt = null,
    Object? lastActiveAt = null,
    Object? settings = null,
  }) {
    return _then(
      _$UserProfileImpl(
        uid: null == uid
            ? _value.uid
            : uid // ignore: cast_nullable_to_non_nullable
                  as String,
        isAnonymous: null == isAnonymous
            ? _value.isAnonymous
            : isAnonymous // ignore: cast_nullable_to_non_nullable
                  as bool,
        provider: null == provider
            ? _value.provider
            : provider // ignore: cast_nullable_to_non_nullable
                  as AuthProvider,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        displayName: freezed == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        longestStreak: null == longestStreak
            ? _value.longestStreak
            : longestStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastActiveAt: null == lastActiveAt
            ? _value.lastActiveAt
            : lastActiveAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        settings: null == settings
            ? _value.settings
            : settings // ignore: cast_nullable_to_non_nullable
                  as UserSettings,
      ),
    );
  }
}

/// @nodoc

class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl({
    required this.uid,
    required this.isAnonymous,
    required this.provider,
    this.email,
    this.displayName,
    this.avatarUrl,
    this.longestStreak = 0,
    required this.createdAt,
    required this.lastActiveAt,
    required this.settings,
  });

  @override
  final String uid;
  @override
  final bool isAnonymous;
  @override
  final AuthProvider provider;
  @override
  final String? email;
  @override
  final String? displayName;
  @override
  final String? avatarUrl;
  @override
  @JsonKey()
  final int longestStreak;
  @override
  final DateTime createdAt;
  @override
  final DateTime lastActiveAt;
  @override
  final UserSettings settings;

  @override
  String toString() {
    return 'UserProfile(uid: $uid, isAnonymous: $isAnonymous, provider: $provider, email: $email, displayName: $displayName, avatarUrl: $avatarUrl, longestStreak: $longestStreak, createdAt: $createdAt, lastActiveAt: $lastActiveAt, settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.isAnonymous, isAnonymous) ||
                other.isAnonymous == isAnonymous) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastActiveAt, lastActiveAt) ||
                other.lastActiveAt == lastActiveAt) &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    uid,
    isAnonymous,
    provider,
    email,
    displayName,
    avatarUrl,
    longestStreak,
    createdAt,
    lastActiveAt,
    settings,
  );

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile({
    required final String uid,
    required final bool isAnonymous,
    required final AuthProvider provider,
    final String? email,
    final String? displayName,
    final String? avatarUrl,
    final int longestStreak,
    required final DateTime createdAt,
    required final DateTime lastActiveAt,
    required final UserSettings settings,
  }) = _$UserProfileImpl;

  @override
  String get uid;
  @override
  bool get isAnonymous;
  @override
  AuthProvider get provider;
  @override
  String? get email;
  @override
  String? get displayName;
  @override
  String? get avatarUrl;
  @override
  int get longestStreak;
  @override
  DateTime get createdAt;
  @override
  DateTime get lastActiveAt;
  @override
  UserSettings get settings;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
