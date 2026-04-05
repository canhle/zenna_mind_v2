import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak_ui_state.freezed.dart';

// ── Events ───────────────────────────────────────────────────────────────

sealed class StreakEvent {
  const StreakEvent();
}

class StreakNavigateBack extends StreakEvent {
  const StreakNavigateBack();
}

class StreakNavigateToPlayer extends StreakEvent {
  const StreakNavigateToPlayer();
}

class StreakNavigateToHome extends StreakEvent {
  const StreakNavigateToHome();
}

// ── UiState ──────────────────────────────────────────────────────────────

@freezed
class StreakUiState with _$StreakUiState {
  const factory StreakUiState({
    @Default(false) bool isTodayCompleted,
    @Default(7) int streakDays,
    @Default(84) int totalMinutes,
    @Default([true, true, true, true, true, true, false]) List<bool> weekDays,
    StreakEvent? event,
  }) = _StreakUiState;
}
