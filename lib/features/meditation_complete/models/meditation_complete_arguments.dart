import 'package:freezed_annotation/freezed_annotation.dart';

part 'meditation_complete_arguments.freezed.dart';

@freezed
class MeditationCompleteArguments with _$MeditationCompleteArguments {
  const factory MeditationCompleteArguments({
    @Default(0) int streakCount,
  }) = _MeditationCompleteArguments;
}
