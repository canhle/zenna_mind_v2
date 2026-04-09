# Coding Conventions

This document defines the coding conventions for the Flutter app.

---

## Top 5 Rules to Follow First

The minimum rules to follow when building new screens or migrating existing ones:

1. Define UiState with `@freezed`
2. Represent loading/error states with `AsyncValue`
3. UI must obtain data only through UiState
4. Use `listenWithAutoClose` for initial data loading
5. Tests follow the AAA pattern + `sut` naming

---

## 1. Riverpod / State Management

### 1.1 Separation of Responsibilities Between ViewModel and Provider

- **UI must obtain data only through the ViewModel's UiState.** Avoid calling Providers directly from the UI.
- **ViewModels access domain Providers via `listenWithAutoClose` or `ref.read`.** Never call Repositories directly from ViewModels.
- ViewModels manage screen-specific composite state (UiState), while domain Providers handle single-responsibility data fetching via UseCases.

```dart
// ✓ Correct: ViewModel listens to domain provider and reflects result in UiState
@riverpod
class ProductListViewModel extends _$ProductListViewModel {
  @override
  ProductListUiState build(ProductListArguments args) {
    return const ProductListUiState();
  }

  Future<void> fetchProducts() async {
    state = state.copyWith(products: const AsyncLoading());

    listenWithAutoClose<List<Product>>(
      provider: productsProvider(categoryId: args.categoryId),
      ref: ref,
      onValue: (value) => value.when(
        data: (products) => state = state.copyWith(
          products: AsyncData(ProductsData(items: products)),
        ),
        loading: () {},
        error: (e, s) => _handleError(e),
      ),
    );
  }
}

// ✗ Avoid: Calling Provider directly from UI
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(productsProvider(categoryId: id)); // NG
  }
}
```

### 1.2 Using `ref.read` / `ref.listen` / `ref.watch`

Follow standard Riverpod rules, with the following strict requirements:

- **Use `ref.listen` (via `listenWithAutoClose`) for initial screen data loading.** This allows cancellation of async operations when navigating back, preventing race conditions.
- Limit `ref.read` to one-time value retrieval (e.g., triggering user actions).
- Do not use `ref.watch` in ViewModels as a general rule.

```dart
// ✓ Correct: Initial load with listenWithAutoClose
Future<void> fetchProducts() async {
  listenWithAutoClose<List<Product>>(
    provider: productsProvider(categoryId: args.categoryId),
    ref: ref,
    onValue: (value) => value.when(/* ... */),
  );
}
```

### 1.3 Provider AutoDispose

- Use `@riverpod` (auto-dispose) for screen-specific state.
- Use `@Riverpod(keepAlive: true)` only for state that needs to persist across the entire app (auth, user profile, feature flags).

### 1.4 Using `overrideWith`

Use `overrideWith` to replace Providers in tests. Using `overrideWithValue` is prohibited.

```dart
// ✓ Correct
someProvider.overrideWith((ref) async => result)

// ✗ Avoid
someProvider.overrideWithValue(AsyncData(result))
```

---

## 2. UiState Design

### 2.1 UiState Class

- UiState must always be defined as a `@freezed` class.
- ViewModel state must always be a **synchronous Freezed class**. Do not use `AsyncNotifier` (where state itself is AsyncValue).

Fixing UiState as a synchronous Freezed class preserves state visibility and extensibility — multiple async fields, UI flags, and events can coexist in a single snapshot.

```dart
@freezed
class ProductListUiState with _$ProductListUiState {
  const factory ProductListUiState({
    @Default(AsyncValue.loading()) AsyncValue<ProductsData> products,
    @Default(false) bool isSubmitting,
    ProductListEvent? event,
  }) = _ProductListUiState;
}
```

### 2.2 Representing Loading and Error States

- **Use `AsyncValue` for fields that have three states: loading, success, and error.**
- Managing loading state with `bool isLoading` is generally prohibited. Use `bool` only when `AsyncValue` cannot express the case.
- **Important: Do not hold a `List` directly inside `AsyncValue`.** Types like `AsyncValue<List<T>>` cause equality checks to fail in tests. Wrap the List in a dedicated Freezed class instead.

```dart
// ✓ Correct: Wrap the List in a Freezed class
@freezed
class ProductsData with _$ProductsData {
  const factory ProductsData({
    required List<Product> items,
  }) = _ProductsData;
}

@freezed
class ProductListUiState with _$ProductListUiState {
  const factory ProductListUiState({
    @Default(AsyncValue.loading()) AsyncValue<ProductsData> products,
  }) = _ProductListUiState;
}

// ✗ Avoid: Holding a List directly in AsyncValue
@freezed
class ProductListUiState with _$ProductListUiState {
  const factory ProductListUiState({
    required AsyncValue<List<Product>> products, // NG: equality checks fail in tests
  }) = _ProductListUiState;
}

// ✗ Avoid: Managing loading with bool isLoading
@freezed
class ProductListUiState with _$ProductListUiState {
  const factory ProductListUiState({
    required bool isLoading,
    List<Product>? products,
    String? errorMessage,
  }) = _ProductListUiState;
}
```

**Reason**: `AsyncValue` is not a Freezed class, so whether the internal `List<T>` is wrapped in `EqualUnmodifiableListView<T>` is inconsistent. This causes `expect(actual, expected)` to fail in tests.

### 2.3 UiState Arguments

- Define screen arguments as a dedicated `@freezed` class (`XxxArguments`).
- Receive them as parameters to the ViewModel's `build` method.
- **Pass only IDs between screens, not entire entities.** The destination screen should fetch its own fresh data.

```dart
// ✓ Correct — pass only the ID
@freezed
class ProductDetailArguments with _$ProductDetailArguments {
  const factory ProductDetailArguments({
    required String productId,
  }) = _ProductDetailArguments;
}

@riverpod
class ProductDetailViewModel extends _$ProductDetailViewModel {
  @override
  ProductDetailUiState build(ProductDetailArguments args) {
    return const ProductDetailUiState();
  }
}

// ✗ Avoid — passing the entire entity
@freezed
class ProductDetailArguments with _$ProductDetailArguments {
  const factory ProductDetailArguments({
    required Product product, // NG: may be stale
  }) = _ProductDetailArguments;
}
```

### 2.4 Event Pattern

Use the Event pattern only when one-way notifications to the UI are needed. Follow these guidelines:

| Use Case | Recommended Approach |
|----------|---------------------|
| API loading / error display | Hold in UiState via `AsyncValue` |
| Screen navigation | Generally use `Event`. UiState is also acceptable when navigation can be naturally expressed as state (e.g., navigate to home when logged in) |
| One-shot side effects (analytics, toast) | Use `sealed class XxxEvent` |

When using Events, always consume them with `consumeEvent()`.

```dart
// Define events with sealed class
sealed class ProductListEvent {
  const ProductListEvent();
}

class NavigateToDetail extends ProductListEvent {
  const NavigateToDetail(this.productId);
  final String productId;
}

class ShowError extends ProductListEvent {
  const ShowError(this.message);
  final String message;
}

// Hold in UiState
@freezed
class ProductListUiState with _$ProductListUiState {
  const factory ProductListUiState({
    ProductListEvent? event,
  }) = _ProductListUiState;
}

// ViewModel provides a consume method
void consumeEvent() {
  state = state.copyWith(event: null);
}

// Screen listens and consumes
ref.listen(productListViewModelProvider(args), (_, state) {
  final event = state.event;
  if (event == null) return;

  switch (event) {
    case NavigateToDetail(:final productId):
      context.push('/products/$productId');
    case ShowError(:final message):
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
  }

  ref.read(productListViewModelProvider(args).notifier).consumeEvent();
});
```

### 2.5 Backend Error Code Handling

Error codes returned from backend APIs must be handled in a type-safe manner using a dedicated `enum`.

#### Enum Structure

```dart
enum OrderErrorCode {
  insufficientStock,
  paymentFailed,
  sessionExpired,
  unknown; // Required: fallback for unrecognized codes

  factory OrderErrorCode.fromString(String? code) {
    return switch (code) {
      'INSUFFICIENT_STOCK'  => OrderErrorCode.insufficientStock,
      'PAYMENT_FAILED'      => OrderErrorCode.paymentFailed,
      'SESSION_EXPIRED'     => OrderErrorCode.sessionExpired,
      _                     => OrderErrorCode.unknown,
    };
  }

  String get message {
    return switch (this) {
      OrderErrorCode.insufficientStock => S.current.error_insufficient_stock,
      OrderErrorCode.paymentFailed     => S.current.error_payment_failed,
      OrderErrorCode.sessionExpired    => S.current.error_session_expired,
      OrderErrorCode.unknown           => S.current.unknown_error,
    };
  }

  static String getMessageFromFailure(ServerFailure failure) {
    return OrderErrorCode.fromString(failure.errorCode).message;
  }
}
```

#### Rules

1. **Use explicit `switch` on backend strings.** Automatic conversions like `snakeToCamel` are prohibited.
2. **Always define an `unknown` fallback value.** Use an enum value, not `null` or nullable types.
3. **Return localized strings via a `message` getter.**
4. **Provide a `getMessageFromFailure(ServerFailure)` static method** for one-liner calls from ViewModels.

#### Usage in ViewModels

```dart
void _handleError(Object error) {
  switch (error) {
    case UnauthorizedFailure():
      state = state.copyWith(
        event: ProductListEvent.showError(S.current.error_unauthorized),
      );
    case ServerFailure() when error.errorCode != null:
      state = state.copyWith(
        event: ProductListEvent.showError(
          OrderErrorCode.getMessageFromFailure(error as ServerFailure),
        ),
      );
    default:
      state = state.copyWith(
        event: ProductListEvent.showError(S.current.unknown_error),
      );
  }
}
```

- **Never show `e.toString()` to users.**
- **Separate typed `Failure` cases from the default catch-all.**

---

## 3. Architecture / File Structure

### 3.1 Layer Structure

```
UI (Widget)
  ↓ reads through UiState only
ViewModel (@riverpod class — Notifier<UiState>)
  ↓ via listenWithAutoClose / ref.read
Domain Provider (@riverpod function — wraps UseCase)
  ↓
UseCase (business logic)
  ↓
Repository (abstract interface)
  ↓
Data Provider (@riverpod — wires RepositoryImpl)
  ↓
RepositoryImpl + FirestoreDataSource
  ↓
Cloud Firestore (cloud_firestore)
```

> Dio remains available in `core/network/` as a reserved transport for future REST features, but no current feature uses it. New DataSources default to Firestore.

**Dependency rule**: upper layers depend on lower layers. The reverse is never allowed.
**Import rule**: ViewModel imports only from `domain/providers/`. It must never import from `data/`.

### 3.2 File Layout

```
lib/
├── app.dart                                # MaterialApp.router + DsTheme + l10n
├── main_common.dart                        # ProviderScope + env setup
├── main_{dev,staging,production}.dart      # Flavor entry points
│
├── design_system/                          # UI kit — maps to Figma
│   ├── tokens/                             # Design tokens
│   │   ├── ds_colors.dart
│   │   ├── ds_typography.dart
│   │   ├── ds_spacing.dart
│   │   ├── ds_radius.dart
│   │   ├── ds_shadows.dart
│   │   └── ds_durations.dart
│   ├── components/                         # Reusable UI components
│   │   ├── ds_button.dart
│   │   ├── ds_text_field.dart
│   │   ├── ds_badge.dart
│   │   ├── ds_card.dart
│   │   ├── ds_bottom_sheet.dart
│   │   ├── ds_dialog.dart
│   │   ├── ds_app_bar.dart
│   │   └── ds_toast.dart
│   ├── icons/
│   │   └── ds_icons.dart
│   ├── theme/
│   │   └── ds_theme.dart                   # Maps tokens → ThemeData
│   └── design_system.dart                  # Barrel export
│
├── core/                                   # Shared infrastructure
│   ├── constants/
│   │   └── app_constants.dart
│   ├── env/
│   │   ├── env.dart
│   │   ├── env_dev.dart
│   │   ├── env_staging.dart
│   │   └── env_production.dart
│   ├── error/
│   │   └── failures.dart
│   ├── extensions/                         # Extensions for SDK types ONLY
│   │   ├── context_extensions.dart
│   │   ├── string_extensions.dart
│   │   └── date_extensions.dart
│   ├── l10n/
│   │   ├── arb/
│   │   │   ├── app_en.arb
│   │   │   └── app_vi.arb
│   │   └── generated/                      # Auto-generated — do not edit
│   ├── mixins/
│   │   └── listen_with_auto_close.dart
│   ├── firebase/
│   │   └── firestore_provider.dart         # FirebaseFirestore instance (@riverpod)
│   ├── network/                            # Reserved for future REST use — unused today
│   │   ├── dio_client.dart
│   │   ├── endpoints.dart
│   │   ├── error_interceptor.dart
│   │   └── auth_interceptor.dart
│   ├── router/
│   │   └── app_router.dart
│   ├── services/
│   │   └── storage_service.dart
│   ├── utils/
│   │   ├── debouncer.dart
│   │   ├── app_logger.dart
│   │   └── validators.dart
│   └── widgets/                            # App-specific widgets (use DS components)
│       ├── loading_view.dart
│       └── error_view.dart
│
├── domain/                                 # Business logic — layer-first
│   ├── entities/
│   │   ├── product.dart
│   │   └── product_extensions.dart         # Extensions for domain entities
│   ├── repositories/                       # Abstract interfaces only
│   │   └── product_repository.dart
│   ├── usecases/
│   │   └── product/
│   │       └── get_products_usecase.dart
│   └── providers/                          # UseCase + functional providers
│       └── product_domain_providers.dart
│
├── data/                                   # Infrastructure — layer-first
│   ├── models/
│   │   └── product_model.dart               # Firestore doc model (fromFirestore/toFirestore)
│   ├── datasources/
│   │   └── product_firestore_datasource.dart
│   ├── repositories/
│   │   └── product_repository_impl.dart
│   └── providers/                          # DataSource + Repository providers
│       └── product_data_providers.dart
│
└── features/                               # Presentation — feature-first
    └── product_list/
        ├── product_list_screen.dart
        ├── product_list_view_model.dart
        ├── models/
        │   ├── product_list_ui_state.dart  # UiState + Event definitions
        │   └── product_list_arguments.dart
        └── components/
            └── product_card.dart
```

**Why hybrid (layer-first for domain/data, feature-first for presentation)?**
Entities are shared across multiple features — `Product` is used in product list, cart, and checkout screens. Placing entities in a single `domain/entities/` folder avoids cross-feature imports and duplication. Presentation remains feature-first because developers navigate there most frequently.

### 3.3 Extension Placement Rules

Extensions must be placed based on the **type they extend**, not grouped arbitrarily.

| Extended type | Location | Example |
|---|---|---|
| Dart/Flutter SDK types (`BuildContext`, `String`, `DateTime`, `List`, `num`) | `core/extensions/` | `context_extensions.dart` |
| Domain entity (`Product`, `Order`) | Next to the entity file in `domain/entities/` | `product_extensions.dart` |
| 3rd-party lib type (`DocumentSnapshot`, `Query`, `Dio`) | Next to the wrapper file | `core/firebase/query_extensions.dart` |
| Feature-specific (used by one screen only) | Inside the feature folder | `features/cart/extensions/` |

**Rules:**

1. **Always prefer extensions over direct calls.** Before calling `Theme.of(context)`, `MediaQuery.of(context)`, `Navigator.of(context)`, or similar, check if a context extension already exists in `core/extensions/`. Use the extension. Only call the framework method directly if no extension covers your use case.
2. **`core/extensions/` is reserved for SDK types only.** One file per type, named `{type}_extensions.dart`.
3. **Domain entity extensions go next to the entity** — placing them in `core/extensions/` would make `core/` depend on `domain/`, violating the dependency rule.
4. **Feature-specific extensions stay in the feature.** If a second feature needs the same extension, promote it to the appropriate layer (`core/` or `domain/`).
5. **Never create a catch-all `extensions.dart` file.** Each file extends exactly one type.

```dart
// ✓ Use context extensions — shorter, consistent, discoverable
final textTheme = context.textTheme;
final colors = context.colorScheme;
final width = context.screenWidth;

// ✗ Avoid — direct framework calls when extension exists
final textTheme = Theme.of(context).textTheme;
final colors = Theme.of(context).colorScheme;
final width = MediaQuery.sizeOf(context).width;
```

```dart
// ✓ core/extensions/string_extensions.dart — SDK type, used everywhere
extension StringExtensions on String {
  String get capitalized => '${this[0].toUpperCase()}${substring(1)}';
}

// ✓ domain/entities/product_extensions.dart — business logic on entity
extension ProductExtensions on Product {
  bool get isOutOfStock => stock == 0;
  String get formattedPrice => '${price.amount} ${price.currency}';
}

// ✗ Avoid: domain entity extension in core/extensions/
// core/extensions/product_extensions.dart — breaks dependency rule
```

### 3.4 Provider Ownership Per Layer


```dart
// data/providers/product_data_providers.dart
// Owns: DataSource and Repository providers only

@riverpod
ProductFirestoreDataSource productFirestoreDataSource(Ref ref) {
  return ProductFirestoreDataSourceImpl(ref.read(firestoreProvider));
}

@riverpod
ProductRepository productRepository(Ref ref) {
  return ProductRepositoryImpl(ref.read(productFirestoreDataSourceProvider));
}
```

```dart
// domain/providers/product_domain_providers.dart
// Owns: UseCase providers and functional data providers

@riverpod
GetProductsUseCase getProductsUseCase(Ref ref) {
  return GetProductsUseCase(ref.read(productRepositoryProvider));
}

@riverpod
Future<List<Product>> products(
  Ref ref, {
  required String categoryId,
  required int page,
}) {
  return ref.read(getProductsUseCaseProvider)(
    categoryId: categoryId,
    page: page,
  );
}
```

### 3.5 Entity vs Model

| | Entity | Model |
|---|---|---|
| Location | `domain/entities/` | `data/models/` |
| Purpose | Business object — what the app works with | API mapping — what the network sends |
| Dependencies | Pure Dart, no framework | `json_serializable`, framework types |
| Contains | Validated, clean fields | Raw fields mirroring JSON structure |
| Used by | ViewModel, UiState, UseCase | DataSource, RepositoryImpl only |

```dart
// domain/entities/product.dart — pure Dart
@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required Price price,
    required DateTime createdAt,
  }) = _Product;
}

// data/models/product_model.dart — Firestore mapping
//
// Standard pattern for ALL Firestore models:
// 1. @JsonSerializable() — auto-generates fromJson/toJson
// 2. Field names match the Firestore document EXACTLY (no @JsonKey rename)
// 3. @TimestampConverter() on DateTime fields → Timestamp ↔ DateTime
// 4. Nested sub-maps become their own @JsonSerializable model
// 5. fromFirestore() merges doc.id into the data map then delegates to fromJson
// 6. toFirestoreForCreate() spreads toJson() and overrides write-time fields
//    (FieldValue.serverTimestamp(), FieldValue.increment(), etc.)
// 7. toEntity() converts wire types (int seconds, String enum) to Dart types
//    (Duration, enum) — keeps the entity Dart-idiomatic.

@JsonSerializable()
class ProductModel {
  const ProductModel({
    required this.id,
    this.name = '',
    this.price = 0,
    this.isActive = true,
    this.createdAt,
  });

  final String id;
  final String name;
  final int price;
  final bool isActive;

  @TimestampConverter()
  final DateTime? createdAt;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  /// Reads a Firestore snapshot. Merges doc.id into the data map so the
  /// generated `fromJson` always has a populated `id` field even if the
  /// document body omits it.
  factory ProductModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = <String, dynamic>{
      ...?doc.data(),
      'id': doc.id,
    };
    return ProductModel.fromJson(data);
  }

  /// Map for the *create* path. Server timestamps override null DateTime
  /// fields so the device clock is irrelevant.
  Map<String, Object?> toFirestoreForCreate() => {
        ...toJson(),
        'createdAt': FieldValue.serverTimestamp(),
      };

  Product toEntity() => Product(
        id: id,
        name: name,
        price: price,
        createdAt: createdAt ?? DateTime.now(),
      );
}
```

#### Reusable Firestore JsonConverters

Custom converters live in `lib/core/firebase/` and apply to any model field via annotation.

```dart
// lib/core/firebase/timestamp_converter.dart
class TimestampConverter implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Timestamp? json) => json?.toDate();

  @override
  Timestamp? toJson(DateTime? object) =>
      object == null ? null : Timestamp.fromDate(object);
}

// Non-nullable variant for fields guaranteed populated.
class RequiredTimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const RequiredTimestampConverter();

  @override
  DateTime fromJson(Timestamp json) => json.toDate();

  @override
  Timestamp toJson(DateTime object) => Timestamp.fromDate(object);
}
```

**Why this pattern is mandatory for Firestore models:**
- Eliminates ~70% of boilerplate vs hand-written `fromFirestore`/`toFirestore`
- `Timestamp` ↔ `DateTime` conversion is centralized — no copy-paste bugs
- Nullable defaults via constructor parameters replace repetitive `?? defaultValue` ladders
- The generated code is readable and stable across Firestore SDK upgrades
- `FieldValue.serverTimestamp()` for writes still works via the `toFirestoreForCreate()` override pattern

**When NOT to use `@JsonSerializable`:**
- Models that need imperative parsing logic (e.g., dynamic field type detection) — fall back to manual `fromMap`. This is the rare exception, not the rule.

### 3.6 UseCase Guidelines

UseCases live in `domain/usecases/` and contain business logic that belongs neither in the Repository (data concern) nor the ViewModel (UI concern).

**Always create a UseCase** for every feature — even when it only delegates to a single Repository. This keeps the codebase consistent and provides a ready place to add business logic later.

Common UseCase responsibilities:
- Input validation
- Business rules that filter or transform data
- Coordination across multiple repositories

```dart
// UseCase with business logic
class GetProductsUseCase {
  const GetProductsUseCase(this._repository);
  final ProductRepository _repository;

  Future<List<Product>> call({
    required String categoryId,
    required int page,
  }) async {
    if (page < 0) throw ArgumentError('Page must be non-negative');

    final products = await _repository.getProducts(
      categoryId: categoryId,
      page: page,
    );

    return products.where((p) => p.isAvailable).toList();
  }
}

// UseCase without extra logic — still created for consistency
class GetProductsUseCase {
  const GetProductsUseCase(this._repository);
  final ProductRepository _repository;

  Future<List<Product>> call() => _repository.getProducts();
}
```

### 3.7 Error Handling Strategy

Each layer translates errors into its own language. No layer leaks the error type of the layer below it. `Failure` is the single error language used from DataSource upwards.

```
DataSource (Firestore) → FirebaseException thrown by cloud_firestore
                           ↓ DataSource try/catch maps to Failure
Repository             → Failure propagates up
                           ↓ bubble up (no try/catch needed)
Provider               → AsyncError wraps Failure
                           ↓
ViewModel              → switch on Failure type → update UiState + Event
                           ↓
UI                     → render ErrorView / show SnackBar / navigate
```

> If a REST DataSource is added later using Dio, it would instead rely on `ErrorInterceptor` to translate `DioException` → `Failure` before it reaches the DataSource caller. Both paths converge on `Failure`.

#### Failure types

```dart
// core/error/failures.dart
sealed class Failure implements Exception {
  const Failure(this.message);
  final String message;
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network error']);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = 'Connection timed out']);
}

class CancelledFailure extends Failure {
  const CancelledFailure([super.message = 'Request cancelled']);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure() : super('Unauthorized');
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure() : super('Forbidden');
}

class NotFoundFailure extends Failure {
  const NotFoundFailure() : super('Not found');
}

class BadRequestFailure extends Failure {
  const BadRequestFailure({
    String message = 'Bad request',
    this.errors,
  }) : super(message);
  final Map<String, List<String>>? errors; // validation errors from API
}

class ServerFailure extends Failure {
  const ServerFailure({String message = 'Server error', this.errorCode})
      : super(message);
  final String? errorCode; // for backend error code mapping
}
```

#### Firestore error translation — single helper

Each FirestoreDataSource wraps queries in a single `try/catch` and delegates to a shared helper that maps `FirebaseException.code` → `Failure`. No business logic in the catch block. Repository does NOT need `try/catch` — Failure propagates naturally.

```dart
// core/firebase/firestore_error_mapper.dart
Failure mapFirestoreError(FirebaseException e) => switch (e.code) {
      'unavailable' || 'cancelled' => const NetworkFailure(),
      'deadline-exceeded' => const TimeoutFailure(),
      'permission-denied' => const ForbiddenFailure(),
      'unauthenticated' => const UnauthorizedFailure(),
      'not-found' => const NotFoundFailure(),
      'resource-exhausted' => const ServerFailure(message: 'Quota exceeded'),
      _ => ServerFailure(errorCode: e.code, message: e.message ?? 'Server error'),
    };

// data/datasources/product_firestore_datasource.dart
class ProductFirestoreDataSourceImpl implements ProductFirestoreDataSource {
  const ProductFirestoreDataSourceImpl(this._firestore);
  final FirebaseFirestore _firestore;

  @override
  Future<List<ProductModel>> getProducts({required String categoryId}) async {
    try {
      final snapshot = await _firestore
          .collection('products')
          .where('categoryId', isEqualTo: categoryId)
          .get();
      return snapshot.docs.map(ProductModel.fromFirestore).toList();
    } on FirebaseException catch (e) {
      throw mapFirestoreError(e);
    }
  }
}
```

#### ErrorInterceptor — for future REST use only

`ErrorInterceptor` still lives in `core/network/` as a complete `DioException` → `Failure` translator. It is kept ready for when/if a REST endpoint is added. It is currently NOT used by any feature.

```dart
// core/network/error_interceptor.dart
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final failure = _mapToFailure(err);
    handler.reject(
      DioException(requestOptions: err.requestOptions, error: failure),
    );
  }

  Failure _mapToFailure(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const TimeoutFailure();

      case DioExceptionType.cancel:
        return const CancelledFailure();

      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        if (err.error is SocketException) {
          return const NetworkFailure('No internet connection');
        }
        return NetworkFailure(err.message ?? 'Network error');

      case DioExceptionType.badCertificate:
        return const NetworkFailure('Certificate error');

      case DioExceptionType.badResponse:
        return _mapStatusCode(err);
    }
  }

  Failure _mapStatusCode(DioException err) {
    final statusCode = err.response?.statusCode;
    final data = err.response?.data;

    return switch (statusCode) {
      HttpStatus.badRequest || HttpStatus.unprocessableEntity =>
        BadRequestFailure(
          message: _extractMessage(data) ?? 'Bad request',
          errors: _extractValidationErrors(data),
        ),
      HttpStatus.unauthorized => const UnauthorizedFailure(),
      HttpStatus.forbidden => const ForbiddenFailure(),
      HttpStatus.notFound => const NotFoundFailure(),
      final code? when code >= HttpStatus.internalServerError =>
        ServerFailure(
          message: _extractMessage(data) ?? 'Server error',
          errorCode: _extractErrorCode(data),
        ),
      _ => NetworkFailure(err.message ?? 'Unexpected error'),
    };
  }
}
```

#### ViewModel error handling

```dart
void _handleError(Object error) {
  final message = switch (error) {
    UnauthorizedFailure() => S.current.error_unauthorized,
    NetworkFailure() => S.current.error_network,
    TimeoutFailure() => S.current.error_network,
    ServerFailure() => S.current.error_server,
    BadRequestFailure() => S.current.error_unknown,
    _ => S.current.error_unknown,
  };

  if (state.products.valueOrNull == null) {
    state = state.copyWith(
      products: AsyncError(error, StackTrace.current),
      event: ProductListShowError(message),
    );
  } else {
    state = state.copyWith(event: ProductListShowError(message));
  }
}
```

### 3.8 Data Backend Layer

Use **Cloud Firestore via `cloud_firestore`** as the primary data backend. The schema is defined in `docs/db/zenna_mind_database_design.md`. Dio is reserved in `core/network/` for potential future REST features.

```dart
// core/firebase/firestore_provider.dart
@riverpod
FirebaseFirestore firestore(Ref ref) => FirebaseFirestore.instance;
```

**Read modes — choose deliberately per query:**

| Mode | When to use |
|---|---|
| `collection(...).get()` | One-shot fetch for static or cacheable data (e.g., category list, session catalog) |
| `doc(...).snapshots()` or `collection(...).snapshots()` | Realtime updates visible to the user (e.g., streak counter, live progress) |

**DataSource rules:**

- Stateless — no caching, no retry, no business logic
- Each public method wraps its query in a single `try/catch` on `FirebaseException`
- The catch block only calls the shared `mapFirestoreError` helper
- Use collection references with generic converters (`.withConverter`) or rely on `Model.fromFirestore(snapshot)` helpers on the model class
- Scope user-specific queries by `currentUser.uid` — never trust client-side filters alone. Firestore Security Rules are the enforcement layer.

```dart
// data/datasources/product_firestore_datasource.dart
abstract interface class ProductFirestoreDataSource {
  Future<List<ProductModel>> getProducts({required String categoryId});
  Stream<ProductModel?> watchProduct(String id);
}

class ProductFirestoreDataSourceImpl implements ProductFirestoreDataSource {
  const ProductFirestoreDataSourceImpl(this._firestore);
  final FirebaseFirestore _firestore;

  @override
  Future<List<ProductModel>> getProducts({required String categoryId}) async {
    try {
      // Firestore path per docs/db/zenna_mind_database_design.md
      final snapshot = await _firestore
          .collection('products')
          .where('categoryId', isEqualTo: categoryId)
          .get();
      return snapshot.docs.map(ProductModel.fromFirestore).toList();
    } on FirebaseException catch (e) {
      throw mapFirestoreError(e);
    }
  }

  @override
  Stream<ProductModel?> watchProduct(String id) {
    return _firestore
        .collection('products')
        .doc(id)
        .snapshots()
        .map((snap) => snap.exists ? ProductModel.fromFirestore(snap) : null);
  }
}
```

> Dio is kept in `core/network/` with full `ErrorInterceptor`/`AuthInterceptor` setup. It is NOT currently wired to any feature. When a REST endpoint is eventually needed, create a `*_remote_datasource.dart` using Dio alongside the Firestore datasources.

### 3.9 Stateless DataSources

DataSources must be **stateless**. They only wrap Firestore queries and expose `Future` / `Stream` return types. They hold no cached data and perform no business logic — that is the Repository's responsibility.

```dart
// ✓ Correct — stateless, only wraps Firestore query
class ProductFirestoreDataSourceImpl implements ProductFirestoreDataSource {
  const ProductFirestoreDataSourceImpl(this._firestore);
  final FirebaseFirestore _firestore;

  @override
  Future<List<ProductModel>> getProducts({required String categoryId}) async {
    try {
      final snapshot = await _firestore
          .collection('products')
          .where('categoryId', isEqualTo: categoryId)
          .get();
      return snapshot.docs.map(ProductModel.fromFirestore).toList();
    } on FirebaseException catch (e) {
      throw mapFirestoreError(e);
    }
  }
  // No caching, no retry logic, no state
}

// ✗ Avoid — DataSource holding state
class ProductFirestoreDataSourceImpl implements ProductFirestoreDataSource {
  List<ProductModel>? _cache; // state belongs in Repository

  Future<List<ProductModel>> getProducts({...}) async {
    if (_cache != null) return _cache!;
    // ...
  }
}
```

### 3.10 Service Access Rules

Services in `core/services/` (e.g. `StorageService`) are infrastructure — similar to `FirebaseFirestore`. Access rules depend on **who** is calling:

| Caller | Access | Example |
|--------|--------|---------|
| **ViewModel / Feature** | Through Repository — never directly | ViewModel → UseCase → SettingsRepository → StorageService |
| **Core infrastructure** (interceptors, Firestore setup) | Directly — no Repository needed | `AuthInterceptor` reads token from `StorageService` |

**Why?** ViewModel must not depend on infrastructure details. If storage backend changes (e.g. SharedPreferences → Hive), only RepositoryImpl changes — ViewModel and UseCase are untouched.

```dart
// ✓ Correct — ViewModel accesses storage through Repository
class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._storage);
  final StorageService _storage;

  @override
  Future<String?> getLocale() => _storage.getString(StorageKeys.locale);

  @override
  Future<void> setLocale(String locale) =>
      _storage.setString(StorageKeys.locale, locale);
}

// ✓ Correct — Core infrastructure accesses StorageService directly
class AuthInterceptor extends Interceptor {
  const AuthInterceptor(this._storage);
  final StorageService _storage;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _storage.getSecure(StorageKeys.accessToken);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

// ✗ Avoid — ViewModel accessing StorageService directly
class SettingsViewModel extends _$SettingsViewModel {
  Future<void> changeLocale(String locale) async {
    ref.read(storageServiceProvider).setString('locale', locale); // NG
  }
}
```

---

## 4. Testing Conventions

### 4.1 Directory Structure

Test files mirror the structure of implementation files.

```
test/
├── features/
│   └── product_list/
│       └── product_list_view_model_test.dart
└── domain/
    └── usecases/
        └── get_products_usecase_test.dart
```

### 4.2 Basic Test Structure

- **Always use the AAA pattern (Arrange / Act / Assert).**
- Standardize the test subject variable name to **`sut`** (System Under Test).
- Use `createContainer(overrides: [...])` to replace providers.

```dart
test('should update state with products on success', () async {
  // Arrange
  final container = createContainer(
    overrides: [
      productsProvider.overrideWith((ref) async => dummyProducts),
    ],
  );
  final sut = container.read(
    productListViewModelProvider(args).notifier,
  );

  // Act
  await sut.fetchProducts();

  // Assert
  final state = container.read(productListViewModelProvider(args));
  expect(
    state,
    expectedState.copyWith(
      products: AsyncData(ProductsData(items: dummyProducts)),
    ),
  );
});
```

### 4.3 State Verification

- **Compare the entire UiState** to detect unintended field changes.
- Initialize `expectedState` in `setUp`, build expected values with `copyWith` in each test.
- When verifying state transitions (recommended), use `collectStates` to capture the full sequence.

```dart
setUp(() {
  expectedState = const ProductListUiState();
});

test('should transition through loading then data', () async {
  // Arrange
  final states = collectStates(container, productListViewModelProvider(args));

  // Act
  await sut.fetchProducts();

  // Assert
  expect(states.length, 3); // initial → loading → data
  expect(states[0], expectedState);
  expect(states[1], expectedState.copyWith(products: const AsyncLoading()));
  expect(states[2], expectedState.copyWith(
    products: AsyncData(ProductsData(items: dummyProducts)),
  ));
});
```

### 4.4 Grouping

Use `group()` at the first level organized by method name.

```dart
group('fetchProducts', () {
  test('should update state with products on success', () { /* ... */ });
  test('should emit ShowError event on NetworkFailure', () { /* ... */ });
  test('should emit navigateToLogin event on UnauthorizedFailure', () { /* ... */ });
});
```

### 4.5 Minimum Required Test Set

For each ViewModel method, test at minimum:

- **1 success case**
- **1 failure case per distinct Failure type** the method can encounter

### 4.6 Waiting for Async Completion (Completer Pattern)

Use `collectStates` as the default approach. Use `Completer` only when `collectStates` cannot handle the timing (e.g., fire-and-forget streams).

```dart
final completer = Completer<void>();
final subscription = container.listen(
  productListViewModelProvider(args),
  (_, state) {
    if (state.products is AsyncData && !completer.isCompleted) {
      completer.complete();
    }
  },
);
addTearDown(subscription.close);

await sut.fetchProducts();
await completer.future.timeout(const Duration(seconds: 1));
```

### 4.7 Dummy Data

Define test data with `_dummy*()` helper functions. Place them at the bottom of the test file or in a shared file for reuse.

```dart
List<Product> _dummyProducts() => [
  Product(
    id: 'p_001',
    name: 'Sample Product',
    price: const Price(amount: 100000, currency: 'VND'),
    createdAt: DateTime(2024, 1, 1),
  ),
];
```

### 4.8 Widget Tests

ViewModel unit tests verify business logic; widget tests verify UI correctness and user interactions. Follow the test pyramid: many unit tests, moderate widget tests, few integration tests.

```dart
testWidgets('should display products when data is loaded', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        productListViewModelProvider(args).overrideWith(
          () => FakeProductListViewModel(),
        ),
      ],
      child: const MaterialApp(home: ProductListScreen(args: args)),
    ),
  );

  expect(find.text('Sample Product'), findsOneWidget);
  expect(find.byType(LoadingErrorView), findsNothing);
});

testWidgets('should show error view on failure', (tester) async {
  await tester.pumpWidget(/* override with error state */);

  expect(find.byType(LoadingErrorView), findsOneWidget);
});
```

---

## 5. Widget & Resource Management

### 5.1 Resource Disposal

Every `ScrollController`, `TextEditingController`, `FocusNode`, `Timer`, and `AnimationController` created in a `State` class **must** be disposed in `dispose()`.

```dart
@override
void dispose() {
  _scrollController.removeListener(_onScroll);
  _scrollController.dispose();
  _searchController.dispose();
  _debounceTimer?.cancel();
  super.dispose();
}
```

### 5.2 Shared Debounce Utility

Use the shared `Debouncer` class. Do not reimplement `Timer`-based debouncing inline. Default durations: **500ms** for search/text input, **300ms** for UI interactions.

```dart
class Debouncer {
  Debouncer({this.duration = const Duration(milliseconds: 500)});
  final Duration duration;
  Timer? _timer;

  void call(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  void dispose() => _timer?.cancel();
}

// Usage
final _debouncer = Debouncer();

void _onSearchChanged(String value) {
  _debouncer.call(
    () => ref.read(productListViewModelProvider(args).notifier).search(value),
  );
}

@override
void dispose() {
  _debouncer.dispose();
  super.dispose();
}
```

### 5.3 Image Loading

Always use `CachedNetworkImage` for remote images. `Image.network` is prohibited — it has no disk cache and re-downloads on every widget rebuild.

```dart
// ✗ Avoid
Image.network(imageUrl)

// ✓ Correct
CachedNetworkImage(
  imageUrl: imageUrl,
  memCacheWidth: 200,
  placeholder: (_, __) => const ShimmerPlaceholder(),
  errorWidget: (_, __, ___) => const Icon(Icons.error),
)
```

### 5.4 Use `textTheme` for Typography

Always use `context.textTheme` (from `context_extensions.dart`) as the base for text styling. Never hardcode `fontFamily` directly in feature code — font families are defined once in `DsTypography` and applied through the theme.

```dart
// ✗ Avoid — hardcoded fontFamily
Text(
  'Hello',
  style: const TextStyle(
    fontFamily: 'PlusJakartaSans',
    fontSize: 30,
    fontWeight: FontWeight.w800,
    color: DsColors.onSurface,
  ),
)

// ✗ Avoid — direct Theme.of() when extension exists (see §3.3 rule 1)
Text(
  'Hello',
  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
    fontSize: 30,
    fontWeight: FontWeight.w800,
    color: DsColors.onSurface,
  ),
)

// ✓ Correct — use context extension
Text(
  'Hello',
  style: context.textTheme.headlineMedium?.copyWith(
    fontSize: 30,
    fontWeight: FontWeight.w800,
    color: DsColors.onSurface,
  ),
)
```

**Mapping guide:**
- Headings / titles → `headlineLarge`, `headlineMedium`, `headlineSmall`, `titleLarge` (PlusJakartaSans)
- Body text / descriptions → `bodyLarge`, `bodyMedium`, `bodySmall` (Manrope)
- Labels / captions / badges → `labelLarge`, `labelMedium`, `labelSmall` (Manrope)

Only override `fontSize` or `fontWeight` via `copyWith` when the design requires values different from the theme defaults.

### 5.5 `const` Constructor Usage

Use `const` constructors wherever possible — especially for `SizedBox`, `Padding`, `EdgeInsets`, `BorderRadius`, and `TextStyle` literals.

```dart
// ✗ Avoid
SizedBox(height: 16)
Padding(padding: EdgeInsets.all(20))

// ✓ Correct
const SizedBox(height: 16)
const Padding(padding: EdgeInsets.all(20))
```

### 5.6 Widget Keys on Lists

When list items have a unique identifier, pass `key: ValueKey(item.id)` to the item widget in `ListView.builder`.

```dart
// ✓ Correct
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ProductCard(
    key: ValueKey(items[index].id),
    item: items[index],
  ),
)
```

### 5.7 Prefer `StatelessWidget` Over Helper Functions

Extract reusable UI into separate widget classes rather than private `_buildXxx()` methods. Flutter can skip rebuilding a `const` widget subtree but cannot skip a helper function.

```dart
// ✗ Less optimal
class ProductListScreen extends ConsumerWidget {
  Widget _buildHeader() => const Padding(/* ... */);
}

// ✓ Better — extract as a widget class
class _ProductListHeader extends StatelessWidget {
  const _ProductListHeader();

  @override
  Widget build(BuildContext context) => const Padding(/* ... */);
}
```

For new screens, extract sub-widgets into a `components/` subfolder. Use `_buildXxx()` only for trivial, non-reusable sections.

### 5.8 Localize State Rebuilds with `.select()`

Sub-widgets should use `.select()` to subscribe only to the UiState fields they need.

```dart
// ✓ Correct — only rebuilds when price changes
class _PriceDisplay extends ConsumerWidget {
  const _PriceDisplay({required this.args});
  final ProductDetailArguments args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final price = ref.watch(
      productDetailViewModelProvider(args).select((s) => s.price),
    );
    return Text(price.formatted);
  }
}
```

### 5.9 AnimatedBuilder Child Pattern

Pass expensive child widgets via the `child` parameter — not inside `builder`. The `child` is built once and reused across frames.

```dart
// ✓ Correct
AnimatedBuilder(
  animation: animation,
  child: const ExpensiveWidget(),
  builder: (context, child) {
    return Transform.translate(
      offset: Offset(animation.value, 0),
      child: child,
    );
  },
)
```

### 5.10 Do Not Override `operator==` on Widgets

Never override `operator==` on widget classes. Flutter's reconciliation relies on identity (`identical()`). Overriding `operator==` causes O(N²) performance degradation. Use `const` constructors instead.

---

## 6. Code Quality

### 6.1 No Mutable Instance Fields in ViewModels

All state **must** live in the `@freezed` UiState class. Mutable instance fields on the ViewModel are prohibited.

```dart
// ✗ Avoid
class ProductListViewModel extends _$ProductListViewModel {
  String _searchQuery = '';   // hidden, untestable
}

// ✓ Correct
@freezed
class ProductListUiState with _$ProductListUiState {
  const factory ProductListUiState({
    @Default('') String searchQuery,
  }) = _ProductListUiState;
}
```

**Exception:** `late final` fields initialized once in `build()` for caching a `ref.read()` result are acceptable.

### 6.2 `ref.invalidate()` Must Go Through the ViewModel (When Coordinated)

UI widgets must never call `ref.invalidate()` directly when invalidation involves side effects or multiple providers.

```dart
// ✗ Avoid
onRefresh: () {
  ref.invalidate(productsProvider(categoryId: id));
  ref.invalidate(bannersProvider);
}

// ✓ Correct
// In ViewModel:
Future<void> refresh() async {
  state = state.copyWith(products: const AsyncLoading());
  ref.invalidate(productsProvider(categoryId: args.categoryId));
}

// In Widget:
RefreshIndicator(
  onRefresh: () => ref
      .read(productListViewModelProvider(args).notifier)
      .refresh(),
)
```

### 6.3 `keepAlive` Usage Guidelines

- **`@Riverpod(keepAlive: true)`**: only for app-global state (auth, user profile, feature flags) or persistent tab ViewModels.
- **Screen-specific ViewModels**: must use `@riverpod` (auto-dispose).
- **`ref.keepAlive()` in `build()`**: acceptable only as a conditional caching strategy after a successful fetch. Never use it unconditionally to preserve mutable instance fields.

```dart
// ✓ Conditional caching
@riverpod
Future<List<Product>> products(Ref ref, {required String categoryId}) async {
  final result = await ref.read(getProductsUseCaseProvider)(
    categoryId: categoryId,
    page: 0,
  );
  ref.keepAlive(); // cache only on success
  return result;
}
```

### 6.4 Centralize Magic Constants

Domain-specific constants must be centralized. Prefer model properties over raw value checks.

```dart
// ✗ Avoid
if (product.stock == 0) { /* out of stock */ }

// ✓ Correct
if (product.isOutOfStock) { /* out of stock */ }

// ✓ Correct — single source of truth
// core/constants/app_constants.dart
const int freeShippingThreshold = 500000;
```

---

## 7. Security

### 7.1 External HTML Content

When rendering HTML from external sources (backend API, user-generated content), **always** use `SafeHtml` (`lib/components/atoms/safe_html.dart`) instead of the raw `Html` widget from `flutter_html`.

`SafeHtml` provides:
- **Tag allowlist** — only safe tags are rendered (`p`, `ul`, `li`, `a`, `b`, `strong`, etc.). All other tags are stripped via `HtmlSanitizer` (`lib/utils/html_sanitizer.dart`).
- **Link validation** — only `https`, `http`, and `mailto` URL schemes are allowed. `javascript:`, `tel:`, `intent:`, and other schemes are blocked.

```dart
// ✗ Avoid — no sanitization, vulnerable to injection
Html(
  data: apiResponse.htmlContent,
)

// ✓ Correct — sanitized and link-validated
SafeHtml(
  data: apiResponse.htmlContent,
  style: {
    "body": Style(fontSize: FontSize(12)),
  },
)
```

Hardcoded HTML that never changes (e.g., local-only content) may use `Html` directly, but prefer `SafeHtml` for consistency.

### 7.2 URL Handling

When opening URLs from external data (API responses, deep links), validate the scheme before launching:

```dart
// ✗ Avoid — opens any URL scheme
openURL(externalUrl);

// ✓ Correct — validate scheme first
final uri = Uri.tryParse(externalUrl);
if (uri != null && {'https', 'http', 'mailto'}.contains(uri.scheme)) {
  openURL(externalUrl);
}
```

### 7.3 Sensitive Data

- **Never** hardcode API keys, tokens, or credentials in source code. Use environment variables or secure storage.
- **Never** log sensitive data (PII, tokens, passwords) — use redacted placeholders.
- **Never** show raw error messages (`e.toString()`) to users — use localized error messages via error code enums (see §2.5).
- Use `SharedPreferences` only for non-sensitive data. For sensitive data, use `flutter_secure_storage` or platform keychain.

### 7.4 API Response Validation

- Always deserialize API responses into typed Freezed models (see CLAUDE.md "API Response Models"). Never trust raw `Map<String, dynamic>` or `dynamic` types.
- Validate required fields — handle `null` or unexpected values gracefully via Freezed defaults or nullable types.
- Separate `on ApiError catch (e)` from generic `catch (_)` — never expose internal error details to users.