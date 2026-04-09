# Feature Specification: Welcome Screen — Anonymous Auth & User Bootstrap

**Feature Branch**: `001-welcome-auth`
**Created**: 2026-04-09
**Status**: Draft
**Input**: Logic implementation for the Welcome screen — replace the mock navigation shortcut with real anonymous sign-in, create the user profile document on first launch, and make Welcome reachable only before a user is signed in.

---

## Context

- UI is already implemented at [lib/features/welcome/](../../lib/features/welcome/). This spec covers **no UI or visual concerns**.
- Scope is limited to: data binding, state management, business logic, authentication, and Firestore integration.
- Shared entities, navigation contracts, and cross-screen state are defined in [docs/spec/app-domain.md](../../docs/spec/app-domain.md) — this spec MUST NOT redefine them.
- Firestore schema: [docs/db/zenna_mind_database_design.md](../../docs/db/zenna_mind_database_design.md).

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 — First-time launch creates an anonymous account (Priority: P1)

A person installs and opens Zenna Mind for the first time. They see a welcome screen, tap "Start", and land on the Home screen ready to meditate. Nothing else is asked of them.

**Why this priority**: This is the single path by which a new user ever gets into the app. Without it, no other feature is reachable.

**Independent Test**: Install the app on a fresh device, open it, verify the Welcome screen appears, tap "Start", verify Home appears within a short delay, verify that closing and reopening the app now opens Home directly (Welcome is no longer shown).

**Acceptance Scenarios**:

1. **Given** a fresh install with no signed-in user, **When** the app launches, **Then** the Welcome screen is shown.
2. **Given** the Welcome screen is shown, **When** the user taps "Start" and the device has network connectivity, **Then** the app signs in anonymously, creates a user profile record with default settings, and navigates to Home. The user never sees Welcome again on this device (back button from Home does not return to Welcome).
3. **Given** the Welcome screen is shown, **When** the user taps "Start" but sign-in fails because of no network, **Then** the user sees a friendly error message explaining the problem and inviting them to try again; the user remains on Welcome and can retry.
4. **Given** sign-in is in progress, **When** the user taps "Start" a second time, **Then** the second tap is ignored (no duplicate sign-in attempt, no duplicate user profile record).

---

### User Story 2 — Returning user bypasses Welcome (Priority: P1)

A person who has previously tapped "Start" closes the app and reopens it later. They go straight to Home without seeing Welcome.

**Why this priority**: Showing Welcome every launch would be annoying and break the "one-tap to meditate" value proposition. This behavior is what makes Welcome feel like an onboarding moment, not a roadblock.

**Independent Test**: After completing Story 1, force-close the app and relaunch. Verify Home appears immediately, with the user's profile already loaded (greeting name, avatar, streak data).

**Acceptance Scenarios**:

1. **Given** the user previously signed in anonymously (or with a linked account), **When** they launch the app, **Then** Home is shown as the initial screen and Welcome is skipped entirely.
2. **Given** the user is signed in, **When** they try to navigate to Welcome manually (e.g., via a deep link), **Then** they are redirected to Home instead.
3. **Given** the app was killed mid-launch the first time, **When** the user reopens the app, **Then** if sign-in had already completed, Home is shown; if not, Welcome is shown so the user can retry.

---

### User Story 3 — Existing user profile is not overwritten (Priority: P2)

A person signs in successfully, uses the app (building streaks, completing sessions), then reopens the app much later. Their profile data — longest streak, settings, account linking status — is preserved, not reset.

**Why this priority**: A silent data loss here would destroy the user's sense of progress. This is a correctness requirement rather than a new user-facing flow, which is why it is P2 rather than P1 — but it MUST be tested before release.

**Independent Test**: Sign in, manually edit the user's Firestore document to set `longestStreak: 42`, force-close the app, reopen it. Verify `longestStreak` is still `42` (not reset to `0`) and the app still functions normally.

**Acceptance Scenarios**:

1. **Given** a user profile document already exists for the current signed-in user, **When** the app launches, **Then** the existing profile is loaded and no fields are overwritten.
2. **Given** the anonymous user later links their account to a Google/Apple/email identity, **When** the app next launches, **Then** the same user profile is loaded (same UID, same data) — not a fresh empty profile.
3. **Given** a signed-in user with an existing profile, **When** the app launches on a day after a streak was broken, **Then** no write to the user profile document happens during Welcome/bootstrap — any streak rollover logic belongs to other features, not this one.

---

### Edge Cases

- **No network on first launch**: Sign-in MUST fail with a retryable error. The app MUST NOT create a local placeholder profile or enter a "degraded" state — Welcome stays on screen until sign-in succeeds.
- **User profile document write partially fails after sign-in succeeds**: The user is authenticated but has no profile doc. The next launch MUST detect this (signed-in but no profile doc) and complete the bootstrap before entering Home, so Home never renders against a missing profile.
- **Double-tap on Start**: Must be idempotent — produces at most one sign-in call and at most one profile write.
- **App resumed from background while Welcome is visible and sign-in is in flight**: Sign-in completes in the background and navigation still happens correctly once resumed.
- **User signed out somewhere (future feature)**: If a future feature calls sign-out, the next app launch MUST send the user back to Welcome. The redirect logic must be general, not hardcoded to "has seen Welcome once".
- **Clock skew / timezone**: `createdAt` and `lastActiveAt` use server timestamps, not device time, to avoid skew across timezones.
- **Cold start vs warm start**: Both must correctly read the current auth state before deciding which screen to open; no race condition where Home briefly appears before a redirect kicks the user back to Welcome.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The system MUST show the Welcome screen on app launch if and only if no user is currently signed in.
- **FR-002**: The system MUST show the Home screen on app launch if and only if a user (anonymous or linked) is currently signed in AND their profile document exists.
- **FR-003**: Tapping "Start" on Welcome MUST trigger an anonymous sign-in flow that results in a valid, unique user identifier for this install.
- **FR-004**: After a successful anonymous sign-in, the system MUST ensure a user profile record exists for that user. If none exists, the system MUST create one with the default values defined in the app-domain spec (anonymous provider, empty email/displayName/avatarUrl, `longestStreak = 0`, default `UserSettings`, server-generated `createdAt` and `lastActiveAt`).
- **FR-005**: If a user profile record already exists for the signed-in user, the system MUST NOT overwrite any of its fields during Welcome bootstrap. (Later features MAY update `lastActiveAt` on their own schedule.)
- **FR-006**: After successful sign-in and profile bootstrap, the system MUST navigate to Home with a replace-style transition so the back gesture from Home does not return the user to Welcome.
- **FR-007**: If anonymous sign-in fails, the system MUST keep the user on Welcome and show a user-friendly, localized error message describing the failure category (no network, service unavailable, unknown). The raw exception text MUST NOT be shown to the user.
- **FR-008**: Tapping "Start" MUST be idempotent: concurrent or repeated taps during an in-flight sign-in MUST result in at most one sign-in attempt and at most one profile write.
- **FR-009**: While sign-in is in flight, the Welcome state MUST expose a loading indicator that the "Start" button binds to, so the user sees that their tap was registered.
- **FR-010**: The system MUST bootstrap auth state before the first screen is chosen on app launch, so the user never sees a flicker of Home followed by a redirect to Welcome (or vice versa).
- **FR-011**: The system MUST expose the current user profile as a single shared, app-wide read source so that all downstream screens read a consistent view of the user without refetching.
- **FR-012**: The Welcome screen MUST NOT itself read or write any collection other than the user profile. It MUST NOT touch sessions, categories, moods, history, streak, or favorites.
- **FR-013**: If a user is signed in but their profile document is missing (e.g., because a prior bootstrap partially failed), the next launch MUST re-run the profile creation step before showing Home.
- **FR-014**: The system MUST persist the sign-in across app restarts without requiring the user to re-tap "Start".

### Key Entities *(defined in [docs/spec/app-domain.md](../../docs/spec/app-domain.md) — referenced here, not redefined)*

- **UserProfile** (`/users/{uid}`): the user record written on first successful sign-in. Welcome only writes this entity, and only for the creation case.
- **UserSettings** (nested in UserProfile): default values used when creating a new profile.
- **AuthProvider** (enum): `anonymous` is the only value Welcome sets. Other values (`google`, `apple`, `email`) are reserved for future account-linking features.

Welcome does NOT read or write: `MeditationSession`, `Category`, `Mood`, `SessionHistory`, `MonthlyStreak`.

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A first-time user can go from cold-launch to the Home screen in a single tap in under 3 seconds on a typical network connection.
- **SC-002**: A returning user's cold-launch reaches the Home screen without any intermediate Welcome flicker, in under 1 second after first paint.
- **SC-003**: 100% of successful anonymous sign-ins result in exactly one user profile record being created (no duplicates, no misses) as verified by counting profile records vs. sign-in events in a test run of 100 launches.
- **SC-004**: 100% of existing user profiles are preserved across app relaunches — no field is reset or overwritten by the Welcome bootstrap path.
- **SC-005**: When the device is offline, tapping "Start" surfaces a clear, localized error message in under 5 seconds, and the user can successfully retry once the device comes back online without having to restart the app.
- **SC-006**: Rapid repeated taps on the "Start" button during sign-in produce at most one sign-in network call and at most one user profile write.

---

## Assumptions

- The device has Firebase Authentication and Cloud Firestore reachable; there is no offline-first queue in MVP — sign-in failure simply keeps the user on Welcome and prompts retry.
- Welcome is the only screen that triggers sign-in. Account linking, sign-out, and re-authentication are out of scope for this feature and will be added later without modifying Welcome's contract.
- The default values for a new `UserSettings` (e.g., `notificationEnabled = false`, `notificationTime = "07:00"`, `defaultDuration = 10 min`, `backgroundSound = "rain"`) are taken verbatim from the example document in the database design. If the product team changes those defaults later, it is a code-level change, not a spec change.
- Vietnamese is the only supported locale for MVP. Error messages on sign-in failure exist as Vietnamese localization keys; an English fallback key exists for future use but is not required to be translated now.
- `createdAt` and `lastActiveAt` on the user profile use Firestore server timestamps to avoid device clock skew.
- The router's redirect logic will be extended later when additional auth-gated screens are added (account linking, settings). This spec establishes the redirect mechanism but does not enumerate future gates.
- No analytics or telemetry events are in scope for this feature.
- The existing Welcome UI already binds to the Welcome ViewModel's event field for navigation. No UI file changes are required — this spec only changes what the ViewModel does before emitting the navigate event, and adds a loading flag + an error message field to the Welcome UiState.
- There is no pre-existing mock data file for Welcome. The current Welcome ViewModel emits a navigate event immediately on tap without any real sign-in — that is the mock to be replaced.
