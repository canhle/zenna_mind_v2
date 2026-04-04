import 'package:freezed_annotation/freezed_annotation.dart';

part 'browse_ui_state.freezed.dart';

// ── Events ───────────────────────────────────────────────────────────────

sealed class BrowseEvent {
  const BrowseEvent();
}

// ── UiState ──────────────────────────────────────────────────────────────

@freezed
class BrowseUiState with _$BrowseUiState {
  const factory BrowseUiState({
    @Default(0) int selectedTabIndex,
    @Default('') String searchQuery,
    BrowseEvent? event,
  }) = _BrowseUiState;
}
