import 'package:flutter_clean_template/core/error/failures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'welcome_ui_state.freezed.dart';

// ── Events ────────────────────────────────────────────────────────────────

sealed class WelcomeEvent {
  const WelcomeEvent();
}

class WelcomeNavigateToHome extends WelcomeEvent {
  const WelcomeNavigateToHome();
}

/// Carries the raw [Failure] so the screen can translate it to a localized
/// message via `S.of(context)`. Keeping l10n out of the ViewModel preserves
/// the layer separation: ViewModels never depend on Flutter widgets.
class WelcomeShowErrorSnackbar extends WelcomeEvent {
  const WelcomeShowErrorSnackbar(this.failure);
  final Failure failure;
}

// ── UiState ───────────────────────────────────────────────────────────────

@freezed
class WelcomeUiState with _$WelcomeUiState {
  const factory WelcomeUiState({
    @Default(AsyncValue<void>.data(null)) AsyncValue<void> signInStatus,
    WelcomeEvent? event,
  }) = _WelcomeUiState;
}
