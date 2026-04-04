import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_clean_template/features/browse/models/browse_ui_state.dart';

part 'browse_view_model.g.dart';

@riverpod
class BrowseViewModel extends _$BrowseViewModel {
  @override
  BrowseUiState build() {
    return const BrowseUiState();
  }

  void onTabChanged(int index) {
    state = state.copyWith(selectedTabIndex: index);
  }

  void onSearchChanged(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void consumeEvent() => state = state.copyWith(event: null);
}
