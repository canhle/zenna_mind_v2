import 'package:freezed_annotation/freezed_annotation.dart';

part 'welcome_ui_state.freezed.dart';

// ── Events ────────────────────────────────────────────────────────────────

sealed class WelcomeEvent {
  const WelcomeEvent();
}

class WelcomeNavigateToHome extends WelcomeEvent {
  const WelcomeNavigateToHome();
}

// ── UiState ───────────────────────────────────────────────────────────────

@freezed
class WelcomeUiState with _$WelcomeUiState {
  const factory WelcomeUiState({
    WelcomeEvent? event,
  }) = _WelcomeUiState;
}
