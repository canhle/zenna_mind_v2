import 'package:freezed_annotation/freezed_annotation.dart';

part 'meditation_complete_ui_state.freezed.dart';

// ── Events ────────────────────────────────────────────────────────────────

sealed class MeditationCompleteEvent {
  const MeditationCompleteEvent();
}

class MeditationCompleteNavigateToBrowse extends MeditationCompleteEvent {
  const MeditationCompleteNavigateToBrowse();
}

class MeditationCompleteNavigateToHome extends MeditationCompleteEvent {
  const MeditationCompleteNavigateToHome();
}

// ── UiState ───────────────────────────────────────────────────────────────

@freezed
class MeditationCompleteUiState with _$MeditationCompleteUiState {
  const factory MeditationCompleteUiState({
    @Default(0) int streakCount,
    @Default('') String quoteText,
    @Default('') String quoteAuthor,
    String? selectedMoodId,
    MeditationCompleteEvent? event,
  }) = _MeditationCompleteUiState;
}
