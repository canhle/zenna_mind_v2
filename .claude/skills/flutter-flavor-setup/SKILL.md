---
name: flutter-flavor-setup
description: >
  Sets up Flutter flavors (dev, staging, production) for a Flutter project. Use this
  skill whenever the user wants to add flavors, environments, or build variants to a
  Flutter project. Triggers on phrases like "tạo flavor", "setup flavor", "thêm
  environment", "cấu hình dev/staging/production", "setup build variant",
  "tạo môi trường", "configure environments", "add flavors", "multiple environments",
  or any request involving separating app config per environment. Always use this skill
  when flavor, environment, or build variant setup is involved — even if only partially
  mentioned.
---

# Flutter Flavor Setup

Generates all files needed to support `dev`, `staging`, and `production` flavors
in a Flutter project — including Dart env config, native setup for Android/iOS,
app icons per flavor, and a helper launch script.

---

## What this skill produces

```
lib/
└── core/
    └── env/
        ├── env.dart                    # Abstract Env class
        ├── env_dev.dart                # Dev config (main_dev.dart entry)
        ├── env_staging.dart            # Staging config
        └── env_production.dart         # Production config

android/app/src/
├── dev/
│   └── google-services.json           # (placeholder — user fills in)
├── staging/
│   └── google-services.json
└── production/
    └── google-services.json

ios/
└── Flutter/
    ├── dev.xcconfig
    ├── staging.xcconfig
    └── production.xcconfig

lib/
├── main_dev.dart
├── main_staging.dart
└── main_production.dart

scripts/
├── run_dev.sh
├── run_staging.sh
└── run_production.sh
```

Also updates:
- `android/app/build.gradle` — adds `flavorDimensions` + `productFlavors`
- `CLAUDE.md` — adds flavor run commands

---

## Step 1 — Ask for config values

Collect all in one turn:

**Required:**
- App name per flavor (e.g. `MyApp Dev`, `MyApp Staging`, `MyApp`)
- App ID / bundle ID per flavor (e.g. `com.example.app.dev`, `.staging`, (none for prod))
- API base URL per flavor
- Any extra config keys? (e.g. Sentry DSN, analytics ID, feature flags)

**Optional (use defaults if not provided):**
- Enable Google Services (Firebase)? Default: yes, generate placeholder files
- Generate app icon overlay (DEV / STG badge)? Default: yes, via flutter_launcher_icons
- Platform: Android only / iOS only / both? Default: both

Read `references/flavor-patterns.md` before generating any code.

---

## Step 2 — Generate files in order

Generate each file completely — no placeholders except where user must fill in
credentials (mark those with `// TODO: replace with your value`).

Order:
1. `lib/core/env/env.dart`
2. `lib/core/env/env_dev.dart`
3. `lib/core/env/env_staging.dart`
4. `lib/core/env/env_production.dart`
5. `lib/main_dev.dart`
6. `lib/main_staging.dart`
7. `lib/main_production.dart`
8. `android/app/build.gradle` (productFlavors block)
9. `android/app/src/dev/`, `staging/`, `production/` — strings.xml + placeholder google-services
10. `ios/Flutter/dev.xcconfig`, `staging.xcconfig`, `production.xcconfig`
11. `scripts/run_dev.sh`, `run_staging.sh`, `run_production.sh`
12. `flutter_launcher_icons` config block (if icon overlay requested)

---

## Step 3 — Summary

After generating all files:

1. Show the complete file tree.
2. List manual steps the user must do (sign in credentials, Firebase config, Xcode scheme).
3. Show the run commands:
   ```bash
   flutter run --flavor dev -t lib/main_dev.dart
   flutter run --flavor staging -t lib/main_staging.dart
   flutter run --flavor production -t lib/main_production.dart
   ```
4. Show VS Code launch.json snippet for one-click debugging per flavor.

Read `references/manual-steps.md` for the complete list of manual steps
(Xcode scheme creation, Android signing, Firebase per-flavor setup).
