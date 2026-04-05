import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_clean_template/features/player/models/player_ui_state.dart';

part 'player_view_model.g.dart';

@riverpod
class PlayerViewModel extends _$PlayerViewModel {
  @override
  PlayerUiState build() {
    return const PlayerUiState();
  }

  void onPlayPauseTapped() {
    state = state.copyWith(isPlaying: !state.isPlaying);
  }

  void onSkipPrevious() {
    state = state.copyWith(currentPosition: Duration.zero);
  }

  void onSkipNext() {
    // TODO: Navigate to next track
  }

  void onSeek(double fraction) {
    final position = state.totalDuration * fraction;
    state = state.copyWith(currentPosition: position);
  }

  void onBackTapped() {
    state = state.copyWith(event: const PlayerNavigateBack());
  }

  void consumeEvent() => state = state.copyWith(event: null);
}
