# Code Patterns Reference

Exact templates for each generated file type. Replace `{Feature}`, `{feature}`,
`{Entity}`, `{entity}` with the actual names. Use `PascalCase` for class names,
`snake_case` for file names and variables.

---

## 1. Entity

**File:** `domain/entities/{entity}.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '{entity}.freezed.dart';

@freezed
class {Entity} with _${Entity} {
  const factory {Entity}({
    required String id,
    // Add fields based on user requirements
    // Use proper Dart types: DateTime not String, enums not codes
  }) = _{Entity};
}
```

**Rules:**
- Pure Dart — no Flutter, no Dio, no json_serializable imports.
- Use `DateTime` for dates, enums for status codes, `@freezed` always.
- Add a `const factory {Entity}.empty()` constructor if a default instance is needed.

---

## 2. Repository Interface

**File:** `domain/repositories/{entity}_repository.dart`

```dart
import 'package:your_app/domain/entities/{entity}.dart';

abstract interface class {Entity}Repository {
  Future<List<{Entity}>> get{Entity}s({
    // parameters matching the UseCase / provider signature
  });

  Future<{Entity}> get{Entity}Detail({required String id});

  // Add other operations: create, update, delete as needed
}
```

**Rules:**
- Abstract interface only — no implementation.
- Method signatures match what the UseCase (or domain provider) will call.
- Return domain Entities, never Models.

---

## 3. UseCase (include only when business logic exists)

**File:** `domain/usecases/{entity}/get_{entity}s_usecase.dart`

```dart
import 'package:your_app/domain/entities/{entity}.dart';
import 'package:your_app/domain/repositories/{entity}_repository.dart';

class Get{Entity}sUseCase {
  const Get{Entity}sUseCase(this._repository);

  final {Entity}Repository _repository;

  Future<List<{Entity}>> call({
    required String categoryId,
    required int page,
  }) async {
    if (page < 0) throw ArgumentError('Page must be non-negative');

    final items = await _repository.get{Entity}s(
      categoryId: categoryId,
      page: page,
    );

    // Business rule example — adapt to actual requirements
    return items.where((item) => item.isAvailable).toList();
  }
}
```

**Rules:**
- Single public method: `call(...)` with `Future<T>` return.
- Input validation throws `ArgumentError` (programming contract), not `Failure`.
- Business filtering/transformation lives here, not in Repository or ViewModel.
- If there is no real business logic, skip this file entirely.

---

## 4. Domain Providers

**File:** `domain/providers/{entity}_domain_providers.dart`

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:your_app/data/providers/{entity}_data_providers.dart';
import 'package:your_app/domain/entities/{entity}.dart';
import 'package:your_app/domain/usecases/{entity}/get_{entity}s_usecase.dart';

part '{entity}_domain_providers.g.dart';

// UseCase provider — always created for consistency
@riverpod
Get{Entity}sUseCase get{Entity}sUseCase(Ref ref) =>
    Get{Entity}sUseCase(ref.read({entity}RepositoryProvider));

// Functional provider — this is what ViewModel listens to
@riverpod
Future<List<{Entity}>> {entity}s(
  Ref ref, {
  required String categoryId,
  required int page,
}) =>
    ref.read(get{Entity}sUseCaseProvider)(
      categoryId: categoryId,
      page: page,
    );
```

---

## 5. Model

**File:** `data/models/{entity}_model.dart`

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:your_app/domain/entities/{entity}.dart';

part '{entity}_model.g.dart';

@JsonSerializable()
class {Entity}Model {
  const {Entity}Model({
    required this.{entity}Id,       // raw API field names
    required this.{entity}Name,
    // add all fields returned by the API, including ones not in Entity
  });

  @JsonKey(name: '{entity}_id')
  final String {entity}Id;

  @JsonKey(name: '{entity}_name')
  final String {entity}Name;

  // Fields filtered before reaching domain (e.g. isDeleted) go here too

  factory {Entity}Model.fromJson(Map<String, dynamic> json) =>
      _${Entity}ModelFromJson(json);

  Map<String, dynamic> toJson() => _${Entity}ModelToJson(this);

  {Entity} toEntity() => {Entity}(
    id: {entity}Id,
    name: {entity}Name,
    // map all fields — parse types here (DateTime.parse, enum.fromString)
    // filter: omit fields the domain doesn't need (e.g. isDeleted)
  );
}
```

**Rules:**
- Field names mirror the API response — use `@JsonKey(name: ...)` for snake_case.
- `toEntity()` is the only place where type parsing and filtering happen.
- Never import Flutter or Riverpod here.

---

## 6. DataSource

**File:** `data/datasources/{entity}_remote_datasource.dart`

```dart
import 'package:dio/dio.dart';
import 'package:your_app/core/network/endpoints.dart';
import 'package:your_app/data/models/{entity}_model.dart';

abstract interface class {Entity}RemoteDataSource {
  Future<List<{Entity}Model>> get{Entity}s({
    required String categoryId,
    required int page,
  });

  Future<{Entity}Model> get{Entity}Detail({required String id});
}

class {Entity}RemoteDataSourceImpl implements {Entity}RemoteDataSource {
  const {Entity}RemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<{Entity}Model>> get{Entity}s({
    required String categoryId,
    required int page,
  }) async {
    final response = await _dio.get(
      Endpoints.{entity}s,
      queryParameters: {
        'category_id': categoryId,
        'page': page,
      },
    );
    return (response.data['items'] as List)
        .map((e) => {Entity}Model.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<{Entity}Model> get{Entity}Detail({required String id}) async {
    final response = await _dio.get(Endpoints.{entity}Detail(id));
    return {Entity}Model.fromJson(response.data as Map<String, dynamic>);
  }
}
```

**Rules:**
- No `try/catch` — `ErrorInterceptor` handles all `DioException`.
- No caching, no state, no business logic.
- Always use `Endpoints.*` constants — never hardcode URL strings.

---

## 7. RepositoryImpl

**File:** `data/repositories/{entity}_repository_impl.dart`

```dart
import 'package:your_app/data/datasources/{entity}_remote_datasource.dart';
import 'package:your_app/domain/entities/{entity}.dart';
import 'package:your_app/domain/repositories/{entity}_repository.dart';

class {Entity}RepositoryImpl implements {Entity}Repository {
  const {Entity}RepositoryImpl(this._dataSource);

  final {Entity}RemoteDataSource _dataSource;

  @override
  Future<List<{Entity}>> get{Entity}s({
    required String categoryId,
    required int page,
  }) async {
    final models = await _dataSource.get{Entity}s(
      categoryId: categoryId,
      page: page,
    );
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<{Entity}> get{Entity}Detail({required String id}) async {
    final model = await _dataSource.get{Entity}Detail(id: id);
    return model.toEntity();
  }
}
```

**Rules:**
- No `try/catch` — Failures propagate from DataSource automatically.
- Only responsibility: call DataSource, map Models → Entities.
- No business logic — that belongs in UseCase.

---

## 8. Data Providers

**File:** `data/providers/{entity}_data_providers.dart`

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:your_app/core/network/dio_client.dart';
import 'package:your_app/data/datasources/{entity}_remote_datasource.dart';
import 'package:your_app/data/repositories/{entity}_repository_impl.dart';
import 'package:your_app/domain/repositories/{entity}_repository.dart';

part '{entity}_data_providers.g.dart';

@riverpod
{Entity}RemoteDataSource {entity}RemoteDataSource(Ref ref) =>
    {Entity}RemoteDataSourceImpl(ref.read(dioClientProvider));

// Returns abstract interface — domain layer never sees the Impl
@riverpod
{Entity}Repository {entity}Repository(Ref ref) =>
    {Entity}RepositoryImpl(ref.read({entity}RemoteDataSourceProvider));
```

---

## 9. UiState + Event

**File:** `features/{feature}/models/{feature}_ui_state.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:your_app/domain/entities/{entity}.dart';

part '{feature}_ui_state.freezed.dart';

// ── Events ────────────────────────────────────────────────────────────────

sealed class {Feature}Event { const {Feature}Event(); }

class {Feature}NavigateToDetail extends {Feature}Event {
  const {Feature}NavigateToDetail(this.{entity}Id);
  final String {entity}Id;
}

class {Feature}ShowError extends {Feature}Event {
  const {Feature}ShowError(this.message);
  final String message;
}

// ── Data wrapper ──────────────────────────────────────────────────────────

// Required because AsyncValue<List<T>> breaks equality in tests
@freezed
class {Entity}sData with _${Entity}sData {
  const factory {Entity}sData({
    required List<{Entity}> items,
  }) = _{Entity}sData;
}

// ── UiState ───────────────────────────────────────────────────────────────

@freezed
class {Feature}UiState with _${Feature}UiState {
  const factory {Feature}UiState({
    @Default(AsyncValue.loading()) AsyncValue<{Entity}sData> {entity}s,
    @Default(false) bool isSubmitting,
    {Feature}Event? event,
  }) = _{Feature}UiState;
}
```

---

## 10. Arguments

**File:** `features/{feature}/models/{feature}_arguments.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '{feature}_arguments.freezed.dart';

@freezed
class {Feature}Arguments with _${Feature}Arguments {
  const factory {Feature}Arguments({
    // Include only what is needed to load the screen
    // Prefer IDs over full entities
    required String categoryId,
  }) = _{Feature}Arguments;
}
```

---

## 11. ViewModel

**File:** `features/{feature}/{feature}_view_model.dart`

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:your_app/core/error/failures.dart';
import 'package:your_app/domain/entities/{entity}.dart';
import 'package:your_app/domain/providers/{entity}_domain_providers.dart';
import 'package:your_app/features/{feature}/models/{feature}_arguments.dart';
import 'package:your_app/features/{feature}/models/{feature}_ui_state.dart';

part '{feature}_view_model.g.dart';

@riverpod
class {Feature}ViewModel extends _${Feature}ViewModel {
  @override
  {Feature}UiState build({Feature}Arguments args) {
    return const {Feature}UiState();
  }

  // ── Data loading ────────────────────────────────────────────────────────

  Future<void> fetch{Entity}s({int page = 0}) async {
    state = state.copyWith({entity}s: const AsyncLoading());

    listenWithAutoClose<List<{Entity}>>(
      provider: {entity}sProvider(
        categoryId: args.categoryId,
        page: page,
      ),
      ref: ref,
      onValue: (value) => value.when(
        data: ({entity}s) => state = state.copyWith(
          {entity}s: AsyncData({Entity}sData(items: {entity}s)),
        ),
        loading: () {},
        error: (e, _) => _handleError(e),
      ),
    );
  }

  // ── User actions ────────────────────────────────────────────────────────

  void on{Entity}Tapped(String {entity}Id) {
    state = state.copyWith(
      event: {Feature}NavigateToDetail({entity}Id),
    );
  }

  // ── Events ──────────────────────────────────────────────────────────────

  void consumeEvent() => state = state.copyWith(event: null);

  // ── Error handling ──────────────────────────────────────────────────────

  void _handleError(Object error) {
    switch (error) {
      case UnauthorizedFailure():
        state = state.copyWith(
          {entity}s: const AsyncError('', StackTrace.empty),
          event: const {Feature}ShowError('Session expired. Please log in again.'),
        );
      case NetworkFailure():
        state = state.copyWith(
          {entity}s: const AsyncError('', StackTrace.empty),
          event: {Feature}ShowError(S.current.error_network),
        );
      case ServerFailure():
        state = state.copyWith(
          {entity}s: const AsyncError('', StackTrace.empty),
          event: {Feature}ShowError(S.current.error_server),
        );
      default:
        state = state.copyWith(
          {entity}s: const AsyncError('', StackTrace.empty),
          event: {Feature}ShowError(S.current.error_unknown),
        );
    }
  }
}
```

---

## 12. Screen

**File:** `features/{feature}/{feature}_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:your_app/core/widgets/error_view.dart';
import 'package:your_app/core/widgets/loading_view.dart';
import 'package:your_app/features/{feature}/models/{feature}_arguments.dart';
import 'package:your_app/features/{feature}/models/{feature}_ui_state.dart';
import 'package:your_app/features/{feature}/{feature}_view_model.dart';

class {Feature}Screen extends ConsumerStatefulWidget {
  const {Feature}Screen({super.key, required this.args});

  final {Feature}Arguments args;

  @override
  ConsumerState<{Feature}Screen> createState() => _{Feature}ScreenState();
}

class _{Feature}ScreenState extends ConsumerState<{Feature}Screen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read({feature}ViewModelProvider(widget.args).notifier)
          .fetch{Entity}s(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ── Event listener ──────────────────────────────────────────────────
    ref.listen({feature}ViewModelProvider(widget.args), (_, state) {
      final event = state.event;
      if (event == null) return;

      switch (event) {
        case {Feature}NavigateToDetail(:final {entity}Id):
          // context.push('/{entity}s/${{entity}Id}');
          break;
        case {Feature}ShowError(:final message):
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
      }

      ref
          .read({feature}ViewModelProvider(widget.args).notifier)
          .consumeEvent();
    });

    // ── UI ───────────────────────────────────────────────────────────────
    final {entity}sAsync = ref.watch(
      {feature}ViewModelProvider(widget.args).select((s) => s.{entity}s),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('{Feature}')),
      body: {entity}sAsync.when(
        data: (data) => _{Feature}ListView(
          items: data.items,
          args: widget.args,
        ),
        loading: () => const LoadingView(),
        error: (_, __) => ErrorView(
          onRetry: () => ref
              .read({feature}ViewModelProvider(widget.args).notifier)
              .fetch{Entity}s(),
        ),
      ),
    );
  }
}

// ── Sub-widgets ─────────────────────────────────────────────────────────────

class _{Feature}ListView extends ConsumerWidget {
  const _{Feature}ListView({
    required this.items,
    required this.args,
  });

  final List<dynamic> items;   // replace dynamic with Entity type
  final {Feature}Arguments args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (items.isEmpty) {
      return const Center(child: Text('No items found.'));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          // key: ValueKey(item.id),   // uncomment when item has id
          title: Text(item.toString()),
          onTap: () => ref
              .read({feature}ViewModelProvider(args).notifier)
              .on{Entity}Tapped(item.id),
        );
      },
    );
  }
}
```

---

## 13. Test Stub

**File:** `test/features/{feature}/{feature}_view_model_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:your_app/domain/entities/{entity}.dart';
import 'package:your_app/domain/providers/{entity}_domain_providers.dart';
import 'package:your_app/features/{feature}/models/{feature}_arguments.dart';
import 'package:your_app/features/{feature}/models/{feature}_ui_state.dart';
import 'package:your_app/features/{feature}/{feature}_view_model.dart';

void main() {
  late {Feature}Arguments args;
  late {Feature}UiState expectedState;

  setUp(() {
    args = const {Feature}Arguments(categoryId: 'cat_001');
    expectedState = const {Feature}UiState();
  });

  ProviderContainer createContainer({List<Override> overrides = const []}) {
    final container = ProviderContainer(overrides: overrides);
    addTearDown(container.dispose);
    return container;
  }

  group('fetch{Entity}s', () {
    test('should transition through loading then data on success', () async {
      // Arrange
      final dummy = _dummy{Entity}s();
      final container = createContainer(
        overrides: [
          {entity}sProvider.overrideWith((ref, {required categoryId, required page}) async => dummy),
        ],
      );
      final states = <{Feature}UiState>[];
      container.listen(
        {feature}ViewModelProvider(args),
        (_, s) => states.add(s),
        fireImmediately: true,
      );
      final sut = container.read({feature}ViewModelProvider(args).notifier);

      // Act
      await sut.fetch{Entity}s();

      // Assert
      expect(states.length, 3);
      expect(states[0], expectedState);
      expect(states[1], expectedState.copyWith({entity}s: const AsyncLoading()));
      expect(states[2], expectedState.copyWith(
        {entity}s: AsyncData({Entity}sData(items: dummy)),
      ));
    });

    test('should emit ShowError event on NetworkFailure', () async {
      // Arrange
      final container = createContainer(
        overrides: [
          {entity}sProvider.overrideWith(
            (ref, {required categoryId, required page}) =>
                Future.error(const NetworkFailure()),
          ),
        ],
      );
      final sut = container.read({feature}ViewModelProvider(args).notifier);

      // Act
      await sut.fetch{Entity}s();

      // Assert
      final state = container.read({feature}ViewModelProvider(args));
      expect(state.event, isA<{Feature}ShowError>());
      expect(state.{entity}s, isA<AsyncError>());
    });

    // Add more test cases per Failure type
  });
}

// ── Dummy data ───────────────────────────────────────────────────────────────

List<{Entity}> _dummy{Entity}s() => [
  const {Entity}(
    id: '{entity}_001',
    // fill required fields
  ),
];
```

---

## Required pubspec.yaml dependencies

```yaml
dependencies:
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5
  freezed_annotation: ^2.4.1
  json_annotation: ^4.9.0
  dio: ^5.4.3
  cached_network_image: ^3.3.1

dev_dependencies:
  build_runner: ^2.4.9
  riverpod_generator: ^2.4.3
  freezed: ^2.5.2
  json_serializable: ^6.8.0
```

After adding files, run:

```bash
dart run build_runner build --delete-conflicting-outputs
```
