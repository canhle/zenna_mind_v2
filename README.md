# Flutter Clean Architecture Template

Production-ready Flutter project template following Clean Architecture with Riverpod, Freezed, and Dio.

## Tech Stack

| Concern | Library |
|---------|---------|
| State management | `riverpod` + `riverpod_annotation` |
| Immutable state | `freezed` |
| HTTP | `dio` |
| Navigation | `go_router` |
| Storage | `shared_preferences` + `flutter_secure_storage` |
| Localization | Flutter `gen-l10n` (ARB) |
| Code generation | `build_runner`, `freezed_generator`, `riverpod_generator` |

## Project Structure

```
lib/
├── app.dart                     # MaterialApp.router + theme + l10n
├── main_common.dart             # ProviderScope + env setup
├── main_{dev,staging,production}.dart
│
├── design_system/               # UI kit (maps to Figma)
│   ├── tokens/                  # Colors, typography, spacing, radius, shadows
│   ├── components/              # DsButton, DsTextField, DsBadge, DsCard, ...
│   ├── icons/                   # Custom icon set
│   └── theme/                   # ThemeData (light/dark)
│
├── core/                        # Shared infrastructure
│   ├── constants/               # Pagination, scroll thresholds
│   ├── env/                     # Flavor config (dev/staging/production)
│   ├── error/                   # Sealed Failure hierarchy
│   ├── extensions/              # SDK type extensions (BuildContext, String, DateTime)
│   ├── l10n/                    # ARB translations + generated S class
│   ├── mixins/                  # listenWithAutoClose
│   ├── network/                 # Dio, interceptors, endpoints
│   ├── router/                  # GoRouter config
│   ├── services/                # StorageService
│   ├── utils/                   # Debouncer, logger, validators
│   └── widgets/                 # App-specific widgets (LoadingView, ErrorView)
│
├── domain/                      # Business logic (layer-first)
│   ├── entities/                # Pure Dart business objects (@freezed)
│   ├── repositories/            # Abstract interfaces
│   ├── usecases/                # Business rules
│   └── providers/               # Riverpod wiring
│
├── data/                        # Infrastructure (layer-first)
│   ├── models/                  # JSON-serializable API models
│   ├── datasources/             # Stateless HTTP calls
│   ├── repositories/            # Repository implementations
│   └── providers/               # Riverpod wiring
│
└── features/                    # Presentation (feature-first)
    └── {feature_name}/
        ├── {feature}_screen.dart
        ├── {feature}_view_model.dart
        ├── models/              # UiState, Events, Arguments
        └── components/          # Feature-specific widgets
```

## Getting Started

### Prerequisites

- Flutter 3.x / Dart 3.x
- Xcode (for iOS)
- Android Studio (for Android)

### Setup

```bash
# Install dependencies
flutter pub get

# Generate localization
flutter gen-l10n

# Generate code (freezed, riverpod, json_serializable)
dart run build_runner build --delete-conflicting-outputs

# Or use the shortcut script
./scripts/gen.sh
```

### Run

```bash
# Dev
flutter run --flavor dev -t lib/main_dev.dart

# Staging
flutter run --flavor staging -t lib/main_staging.dart

# Production
flutter run --flavor production -t lib/main_production.dart
```

### Build

```bash
# APK
flutter build apk --flavor production -t lib/main_production.dart

# iOS
flutter build ios --flavor production -t lib/main_production.dart
```

### Test

```bash
flutter test
```

### Lint

```bash
flutter analyze
```

## Architecture

This template follows **Clean Architecture** with a hybrid folder organization:

- `domain/` and `data/` are **layer-first** (shared across features)
- `features/` is **feature-first** (each screen owns its ViewModel, UiState, components)
- `design_system/` is the **UI kit** (maps 1:1 to Figma, no business logic)

### Key Patterns

- **ViewModel** = `Notifier<UiState>` (never `AsyncNotifier`)
- **UiState** = `@freezed` with `AsyncValue<XxxData>` (never `bool isLoading`)
- **Error handling** = `sealed class Failure` translated in `ErrorInterceptor`
- **Events** = `sealed class` for one-shot side effects (navigation, toast)
- **Data loading** = `listenWithAutoClose` mixin for auto-cancellation

### Dependency Flow

```
features/ -> core/widgets/ -> design_system/
     |
     v
domain/providers/ -> domain/usecases/ -> domain/repositories/ (abstract)
                                              |
                                              v
                          data/repositories/ (impl) -> data/datasources/ -> Dio
```

## Documentation

- [Architecture Guide](docs/architecture-guide.md) - Full architecture rules, folder structure, step-by-step feature guide
- [Coding Conventions](docs/coding-conventions.md) - Detailed coding rules, naming, and patterns

## Claude Code Commands

| Command | Description |
|---------|-------------|
| `/scaffold-feature` | Scaffold a complete Clean Architecture feature |
| `/review-feature` | Review feature code against conventions |
| `/scaffold-core` | Generate core infrastructure files |
| `/setup-flavors` | Set up Flutter flavors |
| `/commit` | Commit following project rules |
