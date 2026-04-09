# CLAUDE.md

# Flutter Clean Architecture Project

## Project overview
Mobile app built with Flutter, using Clean Architecture + Riverpod + Freezed. Data backend is **Cloud Firestore** (no REST API).

## Tech stack
- Flutter 3.x / Dart 3.x
- State management: flutter_riverpod + riverpod_annotation
- Immutable state: freezed
- Data backend: `cloud_firestore` (primary) — schema in `docs/db/zenna_mind_database_design.pdf`
- Auth: `firebase_auth`
- HTTP: `dio` is kept in the codebase for potential future REST endpoints but is NOT used for any current feature data
- Navigation: go_router
- Code generation: build_runner

## Key commands
- Run app (dev): `flutter run --flavor dev -t lib/main_dev.dart`
- Run app (staging): `flutter run --flavor staging -t lib/main_staging.dart`
- Run app (production): `flutter run --flavor production -t lib/main_production.dart`
- Build: `flutter build apk --flavor production -t lib/main_production.dart`
- Run codegen: `dart run build_runner build --delete-conflicting-outputs`
- Watch codegen: `dart run build_runner watch --delete-conflicting-outputs`
- Test: `flutter test`
- Lint: `flutter analyze`
- Get dependencies: `flutter pub get`

## Architecture conventions
See full rules: `docs/architecture-guide.md`
See coding conventions: `docs/coding-conventions.md`

## Quick rules (most important)
- ViewModel = `Notifier<XxxUiState>` — never AsyncNotifier
- UiState = `@freezed` — never `bool isLoading`
- Error handling = `sealed class Failure` — `FirebaseException` translated in FirestoreDataSource (try/catch boundary); `DioException` translated in `ErrorInterceptor` (only if a REST feature is ever added)
- Data backend = Cloud Firestore. DataSources are `*_firestore_datasource.dart` using `cloud_firestore`. Cite the Firestore path from `docs/db/zenna_mind_database_design.pdf` for every read.
- Folder: domain/ and data/ are layer-first, features/ is feature-first

## Code generation note
After creating any @freezed, @riverpod, or @JsonSerializable file,
always run build_runner before testing.

## Linting

Uses `package:flutter_lints/flutter.yaml` as the lint rule base (configured in `analysis_options.yaml`).
