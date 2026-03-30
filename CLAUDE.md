# CLAUDE.md

# Flutter Clean Architecture Project

## Project overview
Mobile app built with Flutter, using Clean Architecture + Riverpod + Freezed + Dio.

## Tech stack
- Flutter 3.x / Dart 3.x
- State management: flutter_riverpod + riverpod_annotation
- Immutable state: freezed
- HTTP: dio
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
- Error handling = `sealed class Failure` — translated in ErrorInterceptor
- Folder: domain/ and data/ are layer-first, features/ is feature-first

## Code generation note
After creating any @freezed, @riverpod, or @JsonSerializable file,
always run build_runner before testing.

## Linting

Uses `package:flutter_lints/flutter.yaml` as the lint rule base (configured in `analysis_options.yaml`).
