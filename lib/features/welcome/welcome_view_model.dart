import 'package:flutter_clean_template/core/error/failures.dart';
import 'package:flutter_clean_template/domain/providers/auth_domain_providers.dart';
import 'package:flutter_clean_template/features/welcome/models/welcome_ui_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'welcome_view_model.g.dart';

@riverpod
class WelcomeViewModel extends _$WelcomeViewModel {
  @override
  WelcomeUiState build() => const WelcomeUiState();

  Future<void> onStartTapped() async {
    // FR-008: ignore double-taps while a sign-in is already in flight.
    if (state.signInStatus.isLoading) return;

    state = state.copyWith(signInStatus: const AsyncValue<void>.loading());

    try {
      final useCase = ref.read(signInAnonymouslyUseCaseProvider);
      await useCase();
      state = state.copyWith(
        signInStatus: const AsyncValue<void>.data(null),
        event: const WelcomeNavigateToHome(),
      );
    } on Failure catch (f, st) {
      state = state.copyWith(
        signInStatus: AsyncValue<void>.error(f, st),
        event: WelcomeShowErrorSnackbar(f),
      );
    }
  }

  void consumeEvent() => state = state.copyWith(event: null);
}
