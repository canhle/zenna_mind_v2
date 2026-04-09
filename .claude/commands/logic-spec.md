---
description: Create a logic spec for a specific screen. Focuses on data binding, state, API calls — not UI (already implemented). Prepares context then delegates to speckit.specify.
---

## User Input

```text
$ARGUMENTS
```

The argument is the screen name (e.g., `welcome`, `browse`, `home`, `player`, `streak`, `meditation_complete`).

If no argument provided, ask: "Which screen do you want to spec? (welcome / browse / home / player / streak / meditation_complete)"

---

## Pre-checks

1. Verify `docs/spec/app-domain.md` exists. If NOT:
   - STOP and output:
     ```
     ⚠ app-domain.md not found.
     Run /logic-init first to create the shared domain spec before speccing individual screens.
     ```

2. Determine SCREEN_NAME from `$ARGUMENTS`.

3. Locate and **read** these screen artifacts now (before delegation):
   - UI Plan: `docs/design/{SCREEN_NAME}/ui_plan.md`
   - UiState: `lib/features/{SCREEN_NAME}/models/{SCREEN_NAME}_ui_state.dart`
   - ViewModel: `lib/features/{SCREEN_NAME}/{SCREEN_NAME}_view_model.dart`
   - Mock data: `lib/features/{SCREEN_NAME}/models/{SCREEN_NAME}_mock_data.dart` (may not exist)
   - `docs/spec/app-domain.md`
   - `docs/db/zenna_mind_database_design.md` — **Firestore schema** (authoritative data source for this app)

   If `ui_plan.md` is not found, warn but continue.

---

## Outline

### Step 1 — Build enriched feature description

From the artifacts read above, synthesize a detailed feature description that will be passed to `speckit.specify`. The description MUST include:

```
Logic implementation for the {SCREEN_NAME} screen.

CONTEXT:
- UI is already implemented at lib/features/{SCREEN_NAME}/. Do NOT spec any UI or visual concerns.
- This spec covers only: data binding, state management, business logic, Firestore integration.

DATA BACKEND:
- Data source: Cloud Firestore (NO REST API)
- Firestore schema: see docs/db/zenna_mind_database_design.md
- Read patterns: one-shot `get()` or realtime `snapshots()` depending on the UX need — specify which per field
- Error translation: FirebaseException → Failure at data source boundary

CURRENT MOCK DATA (to be replaced with real data):
[List each field from *_mock_data.dart or UiState with its current hardcoded value]

SHARED ENTITIES (from docs/spec/app-domain.md — do NOT redefine):
[List entity names and which fields are relevant to this screen]

NAVIGATION CONTRACTS (from docs/spec/app-domain.md):
[List incoming arguments and outgoing navigation for this screen]

DATA REQUIREMENTS:
[For each mocked field: "Field X → Firestore path {collection}/{doc}.{field} (per database design PDF) | local | computed | static/l10n"]
[Specify read mode: one-shot get() or realtime snapshots()]

STATE TRANSITIONS NEEDED:
- Loading state while fetching data
- Error state with user-friendly message
- Empty state (if applicable)
- Populated state
[Add any screen-specific states visible to the user]

ONE-SHOT EVENTS:
[Navigation triggers, snackbar messages the ViewModel must emit]
```

### Step 2 — Delegate to speckit.specify

Read `.claude/commands/speckit.specify.md` in full and execute ALL its steps with the enriched description from Step 1 as the `$ARGUMENTS`.

**Additional constraints to enforce during speckit.specify execution:**
- User Stories MUST describe data flows and interactions, NOT visual elements (UI is done)
- Entities section MUST reference `docs/spec/app-domain.md` — never redefine shared entities
- Success criteria MUST be technology-agnostic and user-facing
- Every mocked field from Step 1 must appear in at least one user story or be explicitly marked as static/l10n

All speckit.specify behavior applies in full: branch creation, template structure, validation loop, clarification questions (max 3), extension hooks.

### Step 3 — Clarify (optional but recommended)

After speckit.specify completes, ask:

```
Spec created. Run /speckit.clarify now to deepen ambiguous areas before planning?
Logic screens often have unclear business decisions (caching, error retry, offline, state persistence).

- yes → Read .claude/commands/speckit.clarify.md in full and execute ALL its steps
- no  → Skip; you can run /speckit.clarify manually before /logic-impl if needed
```

Wait for user response before proceeding to Step 4.

### Step 4 — Post-delegation report

After speckit.specify (and optionally speckit.clarify) completes:
- Confirm all mock data fields are accounted for in the spec
- Next step: `Run /logic-impl {SCREEN_NAME} to begin planning and implementation`
