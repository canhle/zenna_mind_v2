import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_clean_template/features/streak/models/streak_ui_state.dart';

part 'streak_view_model.g.dart';

@riverpod
class StreakViewModel extends _$StreakViewModel {
  @override
  StreakUiState build() {
    return const StreakUiState();
  }

  void onBackTapped() {
    state = state.copyWith(event: const StreakNavigateBack());
  }

  void onStartTapped() {
    state = state.copyWith(event: const StreakNavigateToPlayer());
  }

  void onDoAnotherTapped() {
    state = state.copyWith(event: const StreakNavigateToPlayer());
  }

  void onGoHomeTapped() {
    state = state.copyWith(event: const StreakNavigateToHome());
  }

  void consumeEvent() => state = state.copyWith(event: null);
}
