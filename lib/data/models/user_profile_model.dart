import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_clean_template/core/firebase/timestamp_converter.dart';
import 'package:flutter_clean_template/domain/entities/user_profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

/// Data-layer mirror of the `/users/{uid}.settings` sub-map.
///
/// Field names match the Firestore document exactly. The Dart-friendly
/// `Duration` representation lives in [UserSettings] (the entity); this
/// model only deals with the wire format (`int` seconds).
@JsonSerializable()
class UserSettingsModel {
  const UserSettingsModel({
    this.notificationEnabled = false,
    this.notificationTime = '07:00',
    this.defaultDuration = 600,
    this.backgroundSound = 'rain',
  });

  final bool notificationEnabled;
  final String notificationTime;

  /// Stored in seconds (`600` = 10 min) per the Firestore schema.
  final int defaultDuration;

  final String backgroundSound;

  factory UserSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserSettingsModelToJson(this);

  UserSettings toEntity() => UserSettings(
        notificationEnabled: notificationEnabled,
        notificationTime: notificationTime,
        defaultDuration: Duration(seconds: defaultDuration),
        backgroundSound: backgroundSound,
      );
}

/// Data-layer mirror of `/users/{uid}` per
/// [docs/db/zenna_mind_database_design.md §5](../../../docs/db/zenna_mind_database_design.md).
///
/// Field names match the Firestore document exactly so `@JsonSerializable`
/// can auto-generate `fromJson`/`toJson`. Custom converters handle:
/// - [Timestamp] ↔ [DateTime] via [TimestampConverter]
/// - Nested settings via [UserSettingsModel]
///
/// `uid` is stored both as the document ID AND as a `uid` field per the
/// database design. When reading, [fromFirestore] merges `doc.id` into the
/// data map before delegating to the generated `fromJson`.
@JsonSerializable(explicitToJson: true)
class UserProfileModel {
  const UserProfileModel({
    required this.uid,
    this.isAnonymous = true,
    this.provider = 'anonymous',
    this.email,
    this.displayName,
    this.avatarUrl,
    this.longestStreak = 0,
    this.createdAt,
    this.lastActiveAt,
    this.settings = const UserSettingsModel(),
  });

  final String uid;
  final bool isAnonymous;
  final String provider;
  final String? email;
  final String? displayName;
  final String? avatarUrl;
  final int longestStreak;

  @TimestampConverter()
  final DateTime? createdAt;

  @TimestampConverter()
  final DateTime? lastActiveAt;

  final UserSettingsModel settings;

  // ── (de)serialization ──────────────────────────────────────────────────

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);

  /// Reads a Firestore snapshot. Merges `doc.id` into the data map before
  /// delegating to the generated `fromJson` so the `uid` field is always
  /// populated even if the document body omits it.
  factory UserProfileModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = <String, dynamic>{
      ...?doc.data(),
      'uid': doc.id,
    };
    return UserProfileModel.fromJson(data);
  }

  /// Map for the *create* path. Server timestamps override the (null)
  /// `createdAt`/`lastActiveAt` so the device clock is irrelevant.
  Map<String, Object?> toFirestoreForCreate() => {
        ...toJson(),
        'createdAt': FieldValue.serverTimestamp(),
        'lastActiveAt': FieldValue.serverTimestamp(),
      };

  /// Constructs a fresh anonymous user profile, used by
  /// `createUserIfAbsent` to seed `/users/{uid}` on first launch.
  factory UserProfileModel.newAnonymous(String uid) =>
      UserProfileModel(uid: uid);

  // ── entity mapping ─────────────────────────────────────────────────────

  UserProfile toEntity() {
    final now = DateTime.now();
    return UserProfile(
      uid: uid,
      isAnonymous: isAnonymous,
      provider: _parseAuthProvider(provider),
      email: email,
      displayName: displayName,
      avatarUrl: avatarUrl,
      longestStreak: longestStreak,
      createdAt: createdAt ?? now,
      lastActiveAt: lastActiveAt ?? now,
      settings: settings.toEntity(),
    );
  }

  static AuthProvider _parseAuthProvider(String value) {
    switch (value) {
      case 'google':
        return AuthProvider.google;
      case 'apple':
        return AuthProvider.apple;
      case 'email':
        return AuthProvider.email;
      case 'anonymous':
      default:
        return AuthProvider.anonymous;
    }
  }
}
