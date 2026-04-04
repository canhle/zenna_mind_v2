import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_clean_template/features/home/models/home_ui_state.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  HomeUiState build() {
    return const HomeUiState();
  }

  void onMoodSelected(MoodType mood) {
    state = state.copyWith(selectedMood: mood);
  }

  void onStartTapped() {
    state = state.copyWith(event: const HomeNavigateToMeditation());
  }

  void consumeEvent() => state = state.copyWith(event: null);
}
