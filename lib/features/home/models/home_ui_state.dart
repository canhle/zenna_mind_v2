import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_ui_state.freezed.dart';

// ── Mood ─────────────────────────────────────────────────────────────────

enum MoodType { happy, anxious, tired, stressed, peaceful }

// ── Events ───────────────────────────────────────────────────────────────

sealed class HomeEvent {
  const HomeEvent();
}

class HomeNavigateToMeditation extends HomeEvent {
  const HomeNavigateToMeditation();
}

// ── UiState ──────────────────────────────────────────────────────────────

@freezed
class HomeUiState with _$HomeUiState {
  const factory HomeUiState({
    @Default(null) MoodType? selectedMood,
    HomeEvent? event,
  }) = _HomeUiState;
}
