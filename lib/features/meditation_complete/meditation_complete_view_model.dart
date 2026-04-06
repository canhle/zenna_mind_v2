import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_clean_template/features/meditation_complete/models/meditation_complete_arguments.dart';
import 'package:flutter_clean_template/features/meditation_complete/models/meditation_complete_mock_data.dart';
import 'package:flutter_clean_template/features/meditation_complete/models/meditation_complete_ui_state.dart';

part 'meditation_complete_view_model.g.dart';

@riverpod
class MeditationCompleteViewModel extends _$MeditationCompleteViewModel {
  @override
  MeditationCompleteUiState build(MeditationCompleteArguments args) {
    final quote = meditationQuotes[Random().nextInt(meditationQuotes.length)];
    return MeditationCompleteUiState(
      streakCount: args.streakCount,
      quoteText: quote.text,
      quoteAuthor: quote.author,
    );
  }

  void onMoodSelected(String moodId) {
    state = state.copyWith(selectedMoodId: moodId);
  }

  void onNextTapped() {
    state = state.copyWith(
      event: const MeditationCompleteNavigateToBrowse(),
    );
  }

  void onHomeTapped() {
    state = state.copyWith(
      event: const MeditationCompleteNavigateToHome(),
    );
  }

  void consumeEvent() => state = state.copyWith(event: null);
}
