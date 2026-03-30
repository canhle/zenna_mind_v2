<!--
Sync Impact Report
===================
Version change: N/A -> 1.0.0 (initial creation)

Added principles:
  - I. Clean Architecture (layer separation)
  - II. Riverpod State Management (Notifier<UiState> pattern)
  - III. Freezed Immutable State (all UiState and entities)
  - IV. Sealed Error Handling (single Failure hierarchy)
  - V. Design System Separation (ds_* components)

Added sections:
  - Core Principles (5 principles)
  - Technical Standards
  - Development Workflow
  - Governance

Templates checked:
  - .specify/templates/plan-template.md ✅ compatible
  - .specify/templates/spec-template.md ✅ compatible
  - .specify/templates/tasks-template.md ✅ compatible

Follow-up TODOs: none
-->

# Zenna Mind Constitution

## Core Principles

### I. Clean Architecture

Every feature MUST follow a three-layer separation with strict dependency rules:

- **domain/** (layer-first): Pure Dart only. Contains entities (`@freezed`), repository interfaces (`abstract interface class`), and UseCases. MUST NOT import Flutter, Dio, or any infrastructure package.
- **data/** (layer-first): Implements domain contracts. Contains Models (`@JsonSerializable`), DataSources (stateless HTTP via Dio), and RepositoryImpl. MUST NOT import UI code.
- **features/** (feature-first): Presentation layer. Each feature folder owns its Screen (`ConsumerStatefulWidget`), ViewModel (`Notifier<UiState>`), UiState (`@freezed`), and components.

Dependency rule: `features/ -> domain/` and `features/ -> core/`, `data/ -> domain/`. Data MUST NOT depend on features. Domain MUST NOT depend on data or features.

### II. Riverpod State Management

All screen state MUST be managed through `Notifier<XxxUiState>` — never `AsyncNotifier`.

- ViewModel = `@riverpod class XxxViewModel extends _$XxxViewModel with ListenWithAutoClose`.
- Initial data loading MUST use `listenWithAutoClose` to auto-cancel on navigation.
- UI MUST obtain data only through the ViewModel's UiState. Direct `ref.watch` of domain providers in UI is prohibited.
- One-shot UI events (navigation, snackbar) MUST use a nullable `Event` field in UiState, consumed via `ref.listen` + `consumeEvent()`.
- Use `@riverpod` (auto-dispose) by default. Use `@Riverpod(keepAlive: true)` only for app-wide state (auth, user profile).

### III. Freezed Immutable State

All UiState classes and domain entities MUST use `@freezed`.

- UiState MUST represent async data fields as `AsyncValue<XxxData>` — never raw `bool isLoading` or `String? error`.
- Each async data group MUST be wrapped in a dedicated `XxxData` class (e.g., `ProductsData`, `OrdersData`).
- Screen arguments MUST be `@freezed` classes, not raw primitives or Maps.
- Entity extensions containing business logic MUST live in `domain/entities/` next to the entity file.

### IV. Sealed Error Handling

The app MUST use a single `sealed class Failure` hierarchy as the error language across all layers.

- `ErrorInterceptor` translates `DioException` to the appropriate `Failure` subtype at the infrastructure boundary.
- DataSources MUST NOT contain `try/catch` — error translation is handled by the interceptor.
- ViewModels translate `Failure` subtypes to localized user-facing messages via `switch` pattern matching.
- If a second data source is added (Firebase, local DB), a separate exception layer MAY be introduced at that point — not before.

### V. Design System Separation

The `design_system/` layer MUST remain independent from business logic and app context.

- Design system components (`DsButton`, `DsCard`, etc.) accept only primitive inputs (`String`, `VoidCallback`, `Color`) — never entities or UiState.
- Design tokens (`DsColors`, `DsTypography`, `DsSpacing`, `DsRadius`, `DsShadows`, `DsDurations`) map 1:1 to Figma.
- `core/widgets/` contains app-specific composite widgets that USE design system components but know about app context (localization, error types).
- Dependency flow: `features/ -> core/widgets/ -> design_system/`.

## Technical Standards

- **Language**: Flutter 3.x / Dart 3.x
- **Target platforms**: iOS and Android
- **HTTP client**: Dio with centralized endpoint constants in `core/network/endpoints.dart`
- **Navigation**: GoRouter with `AppRoutes` constants
- **Localization**: Flutter `gen-l10n` with ARB files. Keys MUST be grouped by feature prefix (`common_`, `error_`, `productList_`, `auth_`).
- **Storage**: SharedPreferences for preferences, FlutterSecureStorage for tokens
- **Code generation**: `build_runner` with `freezed_generator`, `riverpod_generator`, `json_serializable`. MUST run codegen after creating any `@freezed`, `@riverpod`, or `@JsonSerializable` file.
- **Flavors**: Three environments — `dev`, `staging`, `production` — each with its own entry point (`main_dev.dart`, `main_staging.dart`, `main_production.dart`) and env config.
- **Linting**: `package:flutter_lints/flutter.yaml` as base. All code MUST pass `flutter analyze` with zero warnings.

## Development Workflow

- **Screen IDs only**: Pass only entity IDs between screens. Detail screens MUST fetch their own fresh data.
- **UseCase always**: Every feature MUST have a UseCase, even if it only forwards to repository. This provides a ready place to add business logic later.
- **Provider wiring**: Domain providers wire UseCases. Data providers wire DataSources and RepositoryImpl. Both use `@riverpod` annotation.
- **Testing**: Tests follow AAA pattern (Arrange-Act-Assert) with `sut` naming. Use `overrideWith` for provider mocking — `overrideWithValue` is prohibited. No Riverpod Hooks (`flutter_hooks` / `HookConsumerWidget`).
- **Extensions**: `core/extensions/` is for SDK types only (`BuildContext`, `String`, `DateTime`). Domain entity extensions belong in `domain/entities/`. Feature-specific extensions stay in the feature folder until shared.

## Governance

- This constitution is the authoritative source for architectural decisions in Zenna Mind.
- All code reviews and PRs MUST verify compliance with these principles.
- Amendments require: (1) documented rationale, (2) impact analysis on existing code, (3) updated constitution version.
- Versioning follows semantic versioning: MAJOR for principle removals/redefinitions, MINOR for new principles or expanded guidance, PATCH for clarifications.
- Runtime development guidance lives in `CLAUDE.md` and `docs/architecture-guide.md`.

**Version**: 1.0.0 | **Ratified**: 2026-03-30 | **Last Amended**: 2026-03-30
