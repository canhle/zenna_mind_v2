import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

enum AuthProvider { anonymous, google, apple, email }

@freezed
class UserSettings with _$UserSettings {
  const factory UserSettings({
    @Default(false) bool notificationEnabled,
    @Default('07:00') String notificationTime,
    @Default(Duration(minutes: 10)) Duration defaultDuration,
    @Default('rain') String backgroundSound,
  }) = _UserSettings;
}

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String uid,
    required bool isAnonymous,
    required AuthProvider provider,
    String? email,
    String? displayName,
    String? avatarUrl,
    @Default(0) int longestStreak,
    required DateTime createdAt,
    required DateTime lastActiveAt,
    required UserSettings settings,
  }) = _UserProfile;
}
