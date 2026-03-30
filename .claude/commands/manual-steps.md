---
description: Manual steps required after flavor setup (Xcode schemes, signing, Firebase)
allowed-tools: Read
---

# Manual Steps Reference

Steps the user must complete manually after the skill generates files.
Always present these clearly after generation — these cannot be automated.

---

## Android manual steps

### 1. Sync Gradle
After `build.gradle` is updated:
```
Android Studio → File → Sync Project with Gradle Files
```
Or from terminal:
```bash
cd android && ./gradlew tasks
```

### 2. Replace Google Services files
Replace each placeholder `google-services.json` with the real file from Firebase Console:
- `android/app/src/dev/google-services.json`
- `android/app/src/staging/google-services.json`
- `android/app/src/production/google-services.json`

Each flavor needs its own Firebase project (or at minimum its own Android app
registered in the same Firebase project with the correct `applicationId`).

### 3. Signing config (release builds)
Create `android/key.properties` (do NOT commit to git):
```
storePassword=<password>
keyPassword=<password>
keyAlias=<alias>
storeFile=<path-to-keystore>
```

Add to `android/app/build.gradle`:
```groovy
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
        }
    }
    // ...
}
```

---

## iOS manual steps

### 1. Create Xcode Schemes (one per flavor)

Open `ios/Runner.xcworkspace` in Xcode, then for each flavor:

1. `Product` → `Scheme` → `Manage Schemes`
2. Click `+` → select target `Runner` → name it `dev` / `staging` / `production`
3. For each scheme, edit it:
   - `Run` → `Info` → `Build Configuration`: select `Debug-dev` (or staging/production)
   - `Archive` → `Info` → `Build Configuration`: select `Release-dev`

### 2. Create Build Configurations

In Xcode project settings → `Info` tab → `Configurations`:
- Duplicate `Debug` three times → rename to `Debug-dev`, `Debug-staging`, `Debug-production`
- Duplicate `Release` three times → rename to `Release-dev`, `Release-staging`, `Release-production`

For each configuration, set the xcconfig file:
- `Debug-dev` → `ios/Flutter/dev.xcconfig`
- `Debug-staging` → `ios/Flutter/staging.xcconfig`
- `Debug-production` → `ios/Flutter/production.xcconfig`
- `Release-dev` → `ios/Flutter/dev.xcconfig`
- (same pattern)

### 3. Bundle ID per flavor

In Xcode → `Runner` target → `Signing & Capabilities`:
- Select scheme `dev` → set Bundle Identifier to `com.example.app.dev`
- Select scheme `staging` → `com.example.app.staging`
- Select scheme `production` → `com.example.app`

### 4. Firebase GoogleService-Info.plist per flavor

Add per-flavor Firebase plist files:
1. Download `GoogleService-Info.plist` for each Firebase app
2. Rename to `GoogleService-Info-dev.plist`, etc.
3. Place in `ios/` folder
4. In Xcode, add a `Run Script` Build Phase before `Compile Sources`:

```bash
# Copy correct GoogleService-Info.plist based on scheme
SCHEME="${SCHEME_NAME:-production}"
PLIST_PATH="${PROJECT_DIR}/GoogleService-Info-${SCHEME}.plist"
DEST_PATH="${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"

if [ -f "$PLIST_PATH" ]; then
  cp "$PLIST_PATH" "$DEST_PATH"
  echo "Copied $PLIST_PATH"
else
  echo "WARNING: $PLIST_PATH not found, using default"
fi
```

---

## CLAUDE.md update

After setup, add this block to `CLAUDE.md`:

```markdown
## Flavor run commands
- Dev:        `flutter run --flavor dev -t lib/main_dev.dart`
- Staging:    `flutter run --flavor staging -t lib/main_staging.dart`
- Production: `flutter run --flavor production -t lib/main_production.dart`

## Flavor build commands
- APK Dev:    `flutter build apk --flavor dev -t lib/main_dev.dart`
- APK Prod:   `flutter build apk --flavor production -t lib/main_production.dart`
- iOS Dev:    `flutter build ios --flavor dev -t lib/main_dev.dart`

## Env config
Environment values live in `lib/core/env/`.
Never hardcode URLs or keys — always use `ref.read(envProvider).xxx`.
```

---

## .gitignore additions

Add to `.gitignore`:
```gitignore
# Local secrets — never commit
.env

# Firebase - real config files
android/app/src/dev/google-services.json
android/app/src/staging/google-services.json
ios/GoogleService-Info-dev.plist
ios/GoogleService-Info-staging.plist
ios/GoogleService-Info-production.plist

# Android signing
android/key.properties
*.keystore
*.jks
```

Commit `.env.example` thay thế — đây là tài liệu các key cần có:
```gitignore
# Do NOT ignore this — it documents available secret keys
!.env.example
```
