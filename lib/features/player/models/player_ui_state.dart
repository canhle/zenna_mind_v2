import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_ui_state.freezed.dart';

// ── Events ───────────────────────────────────────────────────────────────

sealed class PlayerEvent {
  const PlayerEvent();
}

class PlayerNavigateBack extends PlayerEvent {
  const PlayerNavigateBack();
}

// ── UiState ──────────────────────────────────────────────────────────────

@freezed
class PlayerUiState with _$PlayerUiState {
  const factory PlayerUiState({
    @Default('10 phút xoa dịu căng thẳng') String sessionTitle,
    @Default('Lắng nghe hơi thở, giải phóng áp lực')
    String sessionDescription,
    @Default(Duration(minutes: 10)) Duration totalDuration,
    @Default(Duration(minutes: 3, seconds: 48)) Duration currentPosition,
    @Default(true) bool isPlaying,
    PlayerEvent? event,
  }) = _PlayerUiState;
}
