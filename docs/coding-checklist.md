# Coding Conventions Checklist

This checklist is derived from `coding-conventions.md`. Use it to review code before creating PRs or when building new features.

---

# 1. Top Priority Rules (Must Pass)

- [ ] UiState is defined using `@freezed`
- [ ] Loading/error states handled using `AsyncValue`
- [ ] UI reads data ONLY from UiState
- [ ] Initial data loading uses `listenWithAutoClose`
- [ ] Tests follow AAA pattern and use `sut` naming

---

# 2. Riverpod / State Management

## 2.1 ViewModel & Provider Separation

- [ ] UI does NOT call providers directly (`ref.watch(provider)` in widget)
- [ ] ViewModel accesses domain providers via `listenWithAutoClose` or `ref.read`
- [ ] ViewModel does NOT call repositories directly
- [ ] Providers handle single-responsibility data fetching via UseCases
- [ ] ViewModel manages screen-specific composite state (UiState)

## 2.2 ref Usage

- [ ] `ref.listen` (via `listenWithAutoClose`) used for initial data loading
- [ ] `ref.read` used only for one-time value retrieval (user-triggered actions)
- [ ] `ref.watch` NOT used inside ViewModel

## 2.3 Provider Lifecycle

- [ ] Uses `@riverpod` (autoDispose) for screen-specific state
- [ ] Uses `@Riverpod(keepAlive: true)` ONLY for app-global state (auth, user profile, feature flags)
- [ ] `ref.keepAlive()` used only conditionally after a successful fetch — never unconditionally
- [ ] No unnecessary keepAlive usage

## 2.4 overrideWith in Tests

- [ ] Uses `overrideWith` to replace providers in tests
- [ ] Does NOT use `overrideWithValue`

---

# 3. UiState Design

## 3.1 UiState Structure

- [ ] Defined with `@freezed`
- [ ] ViewModel state is synchronous Freezed class — NOT `AsyncNotifier`
- [ ] All UI data comes from UiState
- [ ] Uses `copyWith` for state updates — no direct mutation

## 3.2 AsyncValue Usage

- [ ] All loading/data/error fields use `AsyncValue`
- [ ] No `bool isLoading` for async state management
- [ ] No nullable state unless strictly necessary

## 3.3 List Handling

- [ ] NO `AsyncValue<List<T>>` — equality checks fail in tests
- [ ] Lists wrapped in a dedicated Freezed class (e.g. `ProductsData`)

## 3.4 Arguments

- [ ] Screen arguments defined as a dedicated `@freezed` class (`XxxArguments`)
- [ ] Arguments passed into ViewModel's `build()` method
- [ ] Only IDs passed between screens — never entire entities

## 3.5 Event Pattern

- [ ] Events used ONLY for one-shot side effects (navigation, toast, analytics)
- [ ] Events defined with `sealed class XxxEvent`
- [ ] Events always consumed via `consumeEvent()` after handling
- [ ] API loading/error display handled via `AsyncValue` in UiState — not events

---

# 4. Backend Error Code Handling

- [ ] Backend error codes handled via a dedicated `enum`
- [ ] Uses explicit `switch` on backend strings — no automatic conversions (e.g. `snakeToCamel`)
- [ ] Always defines an `unknown` fallback value in the enum
- [ ] Provides a `message` getter returning localized strings
- [ ] Provides a `getMessageFromFailure(ServerFailure)` static method
- [ ] Never shows `e.toString()` to users

---

# 5. Architecture & File Structure

## 5.1 Layer Structure

- [ ] Follows: UI → ViewModel → Provider → UseCase → Repository → DataSource → Dio
- [ ] No layer skipping — upper layers depend on lower layers only
- [ ] ViewModel imports ONLY from `domain/providers/` — never from `data/`

## 5.2 File Layout

- [ ] `domain/` and `data/` are layer-first
- [ ] `features/` is feature-first
- [ ] Feature folder contains: screen, view_model, models/ (ui_state, arguments), components/

## 5.3 Extension Placement & Usage

- [ ] Uses context extensions (`context.textTheme`, `context.colorScheme`, `context.screenWidth`) instead of direct `Theme.of(context)` / `MediaQuery.of(context)` calls
- [ ] Before calling a framework method directly, checked that no existing extension in `core/extensions/` covers the use case
- [ ] SDK type extensions (`String`, `BuildContext`, etc.) → `core/extensions/`
- [ ] Domain entity extensions → next to entity file in `domain/entities/`
- [ ] 3rd-party lib extensions → next to the wrapper file
- [ ] Feature-specific extensions → inside the feature folder
- [ ] No catch-all `extensions.dart` — each file extends exactly one type
- [ ] `core/extensions/` reserved for SDK types only — no domain entity extensions there

## 5.4 Provider Ownership

- [ ] `data/providers/` owns DataSource + Repository providers only
- [ ] `domain/providers/` owns UseCase providers + functional data providers

---

# 6. Entity vs Model

- [ ] Entity in `domain/entities/` — pure Dart, no framework dependencies
- [ ] Model in `data/models/` — uses `json_serializable`, mirrors JSON structure
- [ ] Model provides `toEntity()` method for conversion
- [ ] Entity used by ViewModel, UiState, UseCase
- [ ] Model used ONLY by DataSource, RepositoryImpl

---

# 7. UseCase

- [ ] Every feature always creates a UseCase — even when it only delegates to a single Repository
- [ ] UseCases live in `domain/usecases/`
- [ ] UseCase handles business logic: input validation, filtering, transformation, cross-repo coordination

---

# 8. Error Handling

## 8.1 Error Flow

- [ ] Uses `sealed class Failure` as base error type
- [ ] All `DioException` → `Failure` translation happens in `ErrorInterceptor` only
- [ ] DataSource and Repository do NOT need `try/catch`
- [ ] ViewModel uses `switch` on Failure type to update UiState + Event

## 8.2 Error State Strategy

- [ ] No existing data → set `AsyncError` on the field + emit Event
- [ ] Existing data already loaded → keep data, emit Event only (show SnackBar)
- [ ] Typed `Failure` cases separated from the default catch-all

---

# 9. Network Layer

- [ ] Uses Dio with interceptors as HTTP foundation
- [ ] Endpoints centralized in `core/network/endpoints.dart`
- [ ] DataSources are stateless — no caching, no retry logic, no state
- [ ] DataSources do NOT use `try/catch` — errors handled by ErrorInterceptor

---

# 10. Service Access

- [ ] ViewModel/Feature accesses services through Repository — never directly
- [ ] Core infrastructure (interceptor, dio) may access services directly
- [ ] If storage backend changes, only RepositoryImpl changes — ViewModel/UseCase untouched

---

# 11. Testing

## 11.1 Structure & Naming

- [ ] Test file path mirrors source file structure
- [ ] Uses AAA pattern (Arrange / Act / Assert)
- [ ] Test subject variable named `sut` (System Under Test)
- [ ] Uses `createContainer(overrides: [...])` to replace providers
- [ ] `group()` at first level organized by method name

## 11.2 State Verification

- [ ] Compares the ENTIRE UiState — not just individual fields
- [ ] `expectedState` initialized in `setUp()`
- [ ] Expected values built with `copyWith` in each test
- [ ] Uses `collectStates` to verify full state transition sequence

## 11.3 Coverage

- [ ] At least 1 success case per method
- [ ] At least 1 failure case per distinct Failure type the method can encounter

## 11.4 Async Handling

- [ ] Uses `collectStates` as default approach
- [ ] Uses `Completer` pattern only when `collectStates` cannot handle timing

## 11.5 Test Data

- [ ] Dummy data defined with `_dummy*()` helper functions
- [ ] Placed at bottom of test file or in shared file for reuse

## 11.6 Widget Tests

- [ ] ViewModel overridden with fake implementation
- [ ] Verifies UI correctness and user interactions
- [ ] Follows test pyramid: many unit tests, moderate widget tests, few integration tests

---

# 12. Widget & Resource Management

## 12.1 Resource Disposal

- [ ] All controllers/nodes/timers disposed in `dispose()`: `ScrollController`, `TextEditingController`, `FocusNode`, `Timer`, `AnimationController`
- [ ] Listeners removed before dispose

## 12.2 Debounce

- [ ] Uses shared `Debouncer` class — no inline Timer-based debouncing
- [ ] Default durations: 500ms for search/text input, 300ms for UI interactions

## 12.3 Typography

- [ ] Uses `context.textTheme` (extension) as base for all text styles — NOT `Theme.of(context).textTheme`
- [ ] No hardcoded `fontFamily` in feature code — font families come from `DsTypography` via theme
- [ ] Only overrides `fontSize` / `fontWeight` via `copyWith` when design differs from theme defaults

## 12.4 Image Loading

- [ ] Uses `CachedNetworkImage` for remote images
- [ ] Does NOT use `Image.network`

## 12.5 Performance

- [ ] Uses `const` constructors wherever possible: `SizedBox`, `Padding`, `EdgeInsets`, `BorderRadius`, `TextStyle`
- [ ] List items with unique ID use `key: ValueKey(item.id)`
- [ ] Sub-widgets use `.select()` to subscribe only to needed UiState fields
- [ ] `AnimatedBuilder`: expensive child passed via `child` parameter — not inside `builder`

## 12.6 Widget Design

- [ ] Reusable UI extracted into separate widget classes (`StatelessWidget`)
- [ ] `_buildXxx()` helper methods used only for trivial, non-reusable sections
- [ ] New screens extract sub-widgets into `components/` subfolder

## 12.7 Widget Equality

- [ ] Never overrides `operator==` on widget classes — use `const` constructors instead

---

# 13. Code Quality

## 13.1 ViewModel State Purity

- [ ] No mutable instance fields in ViewModel — all state in `@freezed` UiState
- [ ] Exception: `late final` fields initialized once in `build()` are acceptable

## 13.2 Ref Invalidation

- [ ] UI does NOT call `ref.invalidate()` directly for complex flows
- [ ] ViewModel handles refresh/invalidation logic

## 13.3 Constants

- [ ] No magic numbers or strings — centralized in constants
- [ ] Prefers model properties over raw value checks (e.g. `product.isOutOfStock` over `product.stock == 0`)

## 13.4 Dependency Injection

- [ ] No direct instantiation of dependencies
- [ ] Easy to mock/override in tests

---

# 14. Security

## 14.1 External HTML

- [ ] Uses `SafeHtml` (NOT raw `Html`) for backend/external HTML content
- [ ] `HtmlSanitizer` allowlist covers only safe tags
- [ ] No `flutter_html` `Html` widget with unsanitized external data

## 14.2 URL Handling

- [ ] URL scheme validated before opening (allowlist: `https`, `http`, `mailto`)
- [ ] No `openURL()` with unvalidated external URLs
- [ ] No `javascript:`, `tel:`, `intent:` schemes from external data

## 14.3 Sensitive Data

- [ ] No hardcoded API keys, tokens, or credentials
- [ ] No sensitive data in logs (PII, tokens, passwords)
- [ ] No raw `e.toString()` shown to users
- [ ] `SharedPreferences` used only for non-sensitive data

## 14.4 API Response Validation

- [ ] API responses deserialized into typed Freezed models
- [ ] No raw `Map<String, dynamic>` or `dynamic` as return types
- [ ] `on ApiError catch (e)` separated from generic `catch (_)`
- [ ] Required fields validated — nulls handled gracefully

---

# Final Result

- [ ] **PASS** — Code follows conventions
- [ ] **FAIL** — Requires refactor (list violations, code examples, and suggested fixes)
