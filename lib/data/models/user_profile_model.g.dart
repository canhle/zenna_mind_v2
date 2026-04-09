// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSettingsModel _$UserSettingsModelFromJson(Map<String, dynamic> json) =>
    UserSettingsModel(
      notificationEnabled: json['notificationEnabled'] as bool? ?? false,
      notificationTime: json['notificationTime'] as String? ?? '07:00',
      defaultDuration: (json['defaultDuration'] as num?)?.toInt() ?? 600,
      backgroundSound: json['backgroundSound'] as String? ?? 'rain',
    );

Map<String, dynamic> _$UserSettingsModelToJson(UserSettingsModel instance) =>
    <String, dynamic>{
      'notificationEnabled': instance.notificationEnabled,
      'notificationTime': instance.notificationTime,
      'defaultDuration': instance.defaultDuration,
      'backgroundSound': instance.backgroundSound,
    };

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      uid: json['uid'] as String,
      isAnonymous: json['isAnonymous'] as bool? ?? true,
      provider: json['provider'] as String? ?? 'anonymous',
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
      createdAt: const TimestampConverter().fromJson(
        json['createdAt'] as Timestamp?,
      ),
      lastActiveAt: const TimestampConverter().fromJson(
        json['lastActiveAt'] as Timestamp?,
      ),
      settings: json['settings'] == null
          ? const UserSettingsModel()
          : UserSettingsModel.fromJson(
              json['settings'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'isAnonymous': instance.isAnonymous,
      'provider': instance.provider,
      'email': instance.email,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'longestStreak': instance.longestStreak,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'lastActiveAt': const TimestampConverter().toJson(instance.lastActiveAt),
      'settings': instance.settings.toJson(),
    };
