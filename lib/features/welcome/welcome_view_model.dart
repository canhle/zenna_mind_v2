import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_clean_template/features/welcome/models/welcome_ui_state.dart';

part 'welcome_view_model.g.dart';

@riverpod
class WelcomeViewModel extends _$WelcomeViewModel {
  @override
  WelcomeUiState build() {
    // TODO: Replace mock data with real API call
    return const WelcomeUiState();
  }

  void onStartTapped() {
    state = state.copyWith(event: const WelcomeNavigateToHome());
  }

  void consumeEvent() => state = state.copyWith(event: null);
}
