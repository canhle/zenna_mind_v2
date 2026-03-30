---
description: Set up Flutter flavors (dev, staging, production) with env config
allowed-tools: Read, Write, Edit, Glob, Bash(flutter pub get), Bash(chmod +x *)
---

# /setup-flavors

Set up Flutter flavors (dev, staging, production) for the current project.

## Usage

```
/setup-flavors
```

## What this command does

Generates all files needed to support `dev`, `staging`, `production` flavors:
- Dart `Env` class + per-flavor implementations
- `main_dev.dart`, `main_staging.dart`, `main_production.dart`
- Android `build.gradle` productFlavors block
- iOS `.xcconfig` files per flavor
- `envProvider` for Riverpod DI
- Run scripts + VS Code `launch.json`

## Process

### Step 1 — Detect existing project structure

Read these files if they exist:
- `android/app/build.gradle` — detect current applicationId
- `ios/Runner.xcodeproj/project.pbxproj` — detect bundle ID
- `pubspec.yaml` — detect package name and existing dependencies
- `lib/main.dart` — detect existing app entry point

### Step 2 — Ask for config values

Collect in one turn:

**Required:**
- App name per flavor (e.g. `MyApp Dev` / `MyApp Staging` / `MyApp`)
- API base URL per flavor
- App ID suffix for dev and staging (e.g. `.dev`, `.staging` — production has none)

**Optional:**
- Extra config keys? (e.g. Sentry DSN, feature flags, analytics ID)
- Generate app icon overlay (DEV/STG badge)? Default: yes
- Firebase / Google Services? Default: yes (generate placeholders)

### Step 3 — Generate files

Follow the patterns in the skill's `references/flavor-patterns.md`.

Generate in this order:
1. `lib/core/env/env.dart`
2. `lib/core/env/env_dev.dart`
3. `lib/core/env/env_staging.dart`
4. `lib/core/env/env_production.dart`
5. `lib/core/env/env_provider.dart`
6. `lib/main_dev.dart`
7. `lib/main_staging.dart`
8. `lib/main_production.dart`
9. `android/app/build.gradle` — insert productFlavors block
10. `android/app/src/dev/res/values/strings.xml`
11. `android/app/src/staging/res/values/strings.xml`
12. `android/app/src/production/res/values/strings.xml`
13. `android/app/src/dev/google-services.json` (placeholder)
14. `android/app/src/staging/google-services.json` (placeholder)
15. `android/app/src/production/google-services.json` (placeholder)
16. `ios/Flutter/dev.xcconfig`
17. `ios/Flutter/staging.xcconfig`
18. `ios/Flutter/production.xcconfig`
19. `.vscode/launch.json`
20. `scripts/_load_env.sh`
21. `scripts/run_dev.sh`
22. `scripts/run_staging.sh`
23. `scripts/run_production.sh`
24. `.env.example` — documents available secret keys, committed to git
25. Update `.gitignore` — add `.env`, Firebase files, keystore
26. Update `CLAUDE.md` with flavor run commands

If icon overlay requested:
27. `pubspec.yaml` — add flutter_launcher_icons config block

### Step 4 — Show manual steps

After generating, clearly list what the user must do manually.
Read `references/manual-steps.md` for the complete list:
- Android: Gradle sync, replace google-services.json, signing config
- iOS: Create Xcode Schemes, Build Configurations, Bundle ID per scheme
- `.gitignore` additions for credentials

### Key rules to enforce

- `Env` is abstract — no concrete values in `env.dart`
- Non-secret config (URLs, app name) hardcoded in `EnvDev/Staging/Production` — safe to commit
- Secrets use `String.fromEnvironment('KEY')` in `Env` base class — never hardcoded
- `envProvider` is overridden in `main_xxx.dart` — never hardcoded in providers
- All providers read config via `ref.read(envProvider).xxx`
- `.env` is gitignored — `.env.example` is committed as documentation
- `_load_env.sh` reads `.env` and converts to `--dart-define` args — no `flutter_dotenv`
- CI/CD passes secrets directly as `--dart-define=KEY=${{ secrets.KEY }}`
- Placeholder `google-services.json` must be clearly marked as TODO
- `key.properties` and real Firebase files must be in `.gitignore`
