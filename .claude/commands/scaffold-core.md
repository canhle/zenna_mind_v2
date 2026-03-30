---
description: Generate core infrastructure files (network, error, theme, l10n, etc.)
allowed-tools: Read, Write, Glob, Bash(flutter pub get), Bash(dart run build_runner build --delete-conflicting-outputs), Bash(flutter gen-l10n), Bash(flutter analyze)
---

# /scaffold-core

Generate the core infrastructure files for a new Flutter Clean Architecture project.

## Usage

```
/scaffold-core
```

## What this command generates

The shared foundation used by all features:

```
lib/
├── app.dart                             # MaterialApp.router + DsTheme + l10n
├── main_common.dart                     # ProviderScope + env setup
├── main_dev.dart
├── main_staging.dart
├── main_production.dart
│
├── design_system/
│   ├── tokens/
│   │   ├── ds_colors.dart               # Brand color palette
│   │   ├── ds_typography.dart           # Text styles
│   │   ├── ds_spacing.dart              # Spacing scale
│   │   ├── ds_radius.dart               # Border radius
│   │   ├── ds_shadows.dart              # Box shadows
│   │   └── ds_durations.dart            # Animation durations
│   ├── components/
│   │   ├── ds_button.dart               # Primary/secondary/text buttons
│   │   ├── ds_text_field.dart           # Input fields
│   │   ├── ds_badge.dart                # Status badges
│   │   ├── ds_card.dart                 # Card variants
│   │   ├── ds_bottom_sheet.dart         # Bottom sheet
│   │   ├── ds_dialog.dart               # Dialog / alert
│   │   ├── ds_app_bar.dart              # Custom app bar
│   │   └── ds_toast.dart                # Snackbar / toast
│   ├── icons/
│   │   └── ds_icons.dart                # Custom icon set
│   ├── theme/
│   │   └── ds_theme.dart                # Maps tokens → ThemeData
│   └── design_system.dart               # Barrel export
│
├── core/
│   ├── constants/
│   │   └── app_constants.dart           # Pagination, scroll thresholds
│   ├── env/
│   │   ├── env.dart                     # Abstract Env interface
│   │   ├── env_dev.dart
│   │   ├── env_staging.dart
│   │   └── env_production.dart
│   ├── error/
│   │   └── failures.dart                # Sealed Failure hierarchy
│   ├── extensions/
│   │   ├── context_extensions.dart      # BuildContext helpers
│   │   ├── string_extensions.dart       # String helpers
│   │   └── date_extensions.dart         # DateTime helpers
│   ├── l10n/
│   │   └── arb/
│   │       ├── app_en.arb               # English
│   │       └── app_vi.arb               # Vietnamese
│   ├── mixins/
│   │   └── listen_with_auto_close.dart  # ViewModel data loading mixin
│   ├── network/
│   │   ├── dio_client.dart              # Dio setup + interceptors
│   │   ├── endpoints.dart               # Centralized URL constants
│   │   ├── error_interceptor.dart       # DioException → Failure
│   │   └── auth_interceptor.dart        # Bearer token injection
│   ├── router/
│   │   └── app_router.dart              # GoRouter config + AppRoutes
│   ├── services/
│   │   └── storage_service.dart         # SharedPreferences + SecureStorage
│   ├── utils/
│   │   ├── debouncer.dart               # Shared debounce utility
│   │   ├── app_logger.dart              # Debug logger
│   │   └── validators.dart              # Email, phone, common validations
│   └── widgets/
│       ├── loading_view.dart            # Loading state widget
│       └── error_view.dart              # Error state widget with retry
│
├── l10n.yaml                            # Localization config
└── scripts/
    └── gen.sh                           # Codegen shortcut
```

## Process

### Step 1 — Ask for project config

Collect in one turn:

**Required:**
- App name (e.g. `MyApp`)
- API base URL per flavor (e.g. `https://dev-api.example.com`)

**Optional (use defaults if not provided):**
- Supported locales? Default: `en`, `vi`
- Primary brand color? Default: `#6750A4`

### Step 2 — Generate all files

Generate each file completely — no placeholders except env URLs.
Read `docs/architecture-guide.md` for full architecture rules.
Read existing source files in `lib/` as reference patterns.

Follow this order:
1. `pubspec.yaml` — add dependencies
2. `l10n.yaml` — localization config
3. `design_system/tokens/` — all token files
4. `design_system/components/` — all component files
5. `design_system/icons/ds_icons.dart`
6. `design_system/theme/ds_theme.dart`
7. `design_system/design_system.dart` — barrel export
8. `core/error/failures.dart` — sealed Failure hierarchy
9. `core/network/` — dio_client, endpoints, error_interceptor, auth_interceptor
10. `core/env/` — env abstract + per-flavor implementations
11. `core/constants/app_constants.dart`
12. `core/extensions/` — context, string, date
13. `core/mixins/listen_with_auto_close.dart`
14. `core/router/app_router.dart`
15. `core/services/storage_service.dart`
16. `core/utils/` — debouncer, app_logger, validators
17. `core/widgets/` — loading_view, error_view
18. `core/l10n/arb/` — ARB files
19. `app.dart` — MaterialApp.router
20. `main_common.dart` + `main_dev.dart` + `main_staging.dart` + `main_production.dart`
21. `test/helpers/` — createContainer, collectStates, pumpApp
22. `scripts/gen.sh`

### Step 3 — Run codegen

```bash
flutter pub get
flutter gen-l10n
dart run build_runner build --delete-conflicting-outputs
flutter analyze
```

### Step 4 — Summary

After generating:
- Show the complete file tree
- List any manual steps (iOS schemes, Android gradle sync)
- Confirm `flutter analyze` passes with 0 issues

## Key patterns to follow

- `ErrorInterceptor` handles all `DioExceptionType` + `HttpStatus` codes
- `AuthInterceptor` reads token from `StorageService`
- `StorageKeys` defined inside `storage_service.dart`
- `core/widgets/` uses `design_system/` components internally
- `core/extensions/` only for SDK types — never domain entities
- ARB keys grouped by feature prefix (`common_`, `error_`, `btn_`, ...)
