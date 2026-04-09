<!--
Sync Impact Report
===================
Version change: 1.0.0 -> 1.1.0 (Firestore-first data backend)

Modified principles:
  - IV. Sealed Error Handling — updated for FirebaseException translation in DataSource

Modified sections:
  - Technical Standards — replaced Dio/REST with Cloud Firestore as primary data backend

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

- **domain/** (layer-first): Pure Dart only. Contains entities (`@freezed`), repository interfaces (`abstract interface class`), and UseCases. MUST NOT import Flutter, `cloud_firestore`, or any infrastructure package.
- **data/** (layer-first): Implements domain contracts. Contains Models (`@JsonSerializable` with `fromFirestore`/`toFirestore` helpers), DataSources (stateless Firestore queries via `cloud_firestore`), and RepositoryImpl. MUST NOT import UI code.
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

- Cloud Firestore is the primary data backend. `FirebaseException` MUST be translated to the appropriate `Failure` subtype inside the FirestoreDataSource (the Firestore SDK has no interceptor mechanism — translation lives at the call site, wrapped in a single helper).
- DataSources contain a single `try/catch` boundary that maps `FirebaseException` codes (`unavailable`, `permission-denied`, `not-found`, `unauthenticated`, etc.) to `Failure` subtypes. No business logic in the catch block.
- ViewModels translate `Failure` subtypes to localized user-facing messages via `switch` pattern matching.
- If a second data source is added later (REST API, local DB), it MUST translate its own exceptions to the same `Failure` hierarchy at its own boundary.

### V. Design System Separation

The `design_system/` layer MUST remain independent from business logic and app context.

- Design system components (`DsButton`, `DsCard`, etc.) accept only primitive inputs (`String`, `VoidCallback`, `Color`) — never entities or UiState.
- Design tokens (`DsColors`, `DsTypography`, `DsSpacing`, `DsRadius`, `DsShadows`, `DsDurations`) map 1:1 to Figma.
- `core/widgets/` contains app-specific composite widgets that USE design system components but know about app context (localization, error types).
- Dependency flow: `features/ -> core/widgets/ -> design_system/`.

## Technical Standards

- **Language**: Flutter 3.x / Dart 3.x
- **Target platforms**: iOS and Android
- **Data backend**: Cloud Firestore via the `cloud_firestore` package. The Firestore schema is defined in `docs/db/zenna_mind_database_design.pdf` — that document is the authoritative source for all collection paths, document shapes, and relationships. There is NO REST API layer.
- **Read modes**: Use one-shot `get()` for static/cacheable data and `snapshots()` streams for data that must update in realtime (e.g., live progress, presence). Choose deliberately per query, not by default.
- **Authentication**: Firebase Authentication. The `currentUser.uid` MUST be passed into queries that read user-scoped data — never trust client-side filters alone (rely on Firestore Security Rules as the enforcement layer).
- **Navigation**: GoRouter with `AppRoutes` constants
- **Localization**: Flutter `gen-l10n` with ARB files. Keys MUST be grouped by feature prefix (`common_`, `error_`, `productList_`, `auth_`).
- **Storage**: SharedPreferences for preferences, FlutterSecureStorage for tokens/secrets
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

**Version**: 1.1.0 | **Ratified**: 2026-03-30 | **Last Amended**: 2026-04-09
