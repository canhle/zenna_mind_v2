---
description: Analyze all existing screens and create app domain spec + recommended implementation order for logic phase
---

## User Input

```text
$ARGUMENTS
```

## Purpose

This command prepares the foundation before implementing logic for any screen.
It creates two artifacts:
1. `docs/spec/app-domain.md` — shared domain entities, navigation contracts, cross-screen shared state
2. `docs/spec/screen-order.md` — recommended screen implementation order with dependency rationale

Run this ONCE before starting `/logic-spec` on any screen.

---

## Outline

### Phase 1 — Discover existing screens

1. Scan `docs/design/` for all `ui_plan.md` files. List each screen found.

2. For each screen found, read:
   - Its `ui_plan.md` (data classification, elements, navigation)
   - Its mock data file(s) in `lib/features/{screen}/models/*_mock_data.dart` (if exists)
   - Its UiState file `lib/features/{screen}/models/*_ui_state.dart`

3. Also read:
   - `.specify/memory/constitution.md`
   - `docs/architecture-guide.md`
   - `docs/db/zenna_mind_database_design.md` — **authoritative source** for Firestore collection structure, document shapes, and relationships

---

### Phase 2 — Extract shared domain knowledge

From all the material gathered in Phase 1, identify:

**A. Shared Domain Entities**
Entities that appear in MORE THAN ONE screen. For each:
- Canonical name (PascalCase Dart class name)
- Fields (name, type, nullable, description)
- Which screens use it
- **Firestore collection/document path** that backs this entity (from `docs/db/zenna_mind_database_design.md`)

**B. Navigation Contracts**
For each screen-to-screen transition:
- Source screen → Target screen
- Argument passed (type + field name)
- Return value (if any, e.g. after pop)
- Trigger (what user action causes navigation)

**C. Cross-screen Shared State**
State that must be `keepAlive: true` because multiple screens read it:
- Provider name
- Data it holds
- Which screens read/write it

---

### Phase 3 — Create `docs/spec/app-domain.md`

Create or overwrite `docs/spec/app-domain.md` with this structure:

```markdown
# App Domain Spec — Zenna Mind

> Single source of truth for shared entities, navigation contracts, and cross-screen state.
> All screen-level specs MUST reference this file — never redefine entities locally.

## Data Backend

**The app fetches all data directly from Cloud Firestore.** No REST API layer.
Firestore collection structure and document shapes are defined in `docs/db/zenna_mind_database_design.md` — that file is the authoritative source for all data contracts.

Implications:
- DataSources are Firestore data sources (using `cloud_firestore` package), not Dio/HTTP
- There are NO REST endpoints — `core/network/endpoints.dart` is not used for data
- Error handling: `FirebaseException` is translated to `Failure` at the data source boundary (equivalent role to `ErrorInterceptor` for Dio)
- Realtime streams (`snapshots()`) MAY be used where the design calls for live updates

## Shared Domain Entities

### {EntityName}

**Firestore source:** `{collection}/{doc}` (per database design PDF)

| Field | Type | Nullable | Description |
|-------|------|----------|-------------|
| ...   | ...  | ...      | ...         |

Used by: {screen1}, {screen2}

[Repeat for each shared entity]

## Navigation Contracts

| From | To | Argument | Return | Trigger |
|------|----|----------|--------|---------|
| ...  | ...| ...      | ...    | ...     |

## Cross-screen Shared State

| Provider | Holds | Read by | Written by | keepAlive |
|----------|-------|---------|------------|-----------|
| ...      | ...   | ...     | ...        | ...       |

## Notes

[Any cross-cutting concerns: auth flow, error handling patterns, deep link considerations]
```

---

### Phase 4 — Determine implementation order

Analyze screen dependencies:
- Which screens depend on entities/state produced by other screens?
- Which screens are "leaf" screens (no data producers)?
- Which screens have simpler logic and serve as good starting points?

Output a recommended order with rationale for each position.

---

### Phase 5 — Create `docs/spec/screen-order.md`

Create `docs/spec/screen-order.md`:

```markdown
# Screen Implementation Order

> Recommended order for implementing logic, from simplest/least-dependent to most complex.

| # | Screen | Feature Folder | Rationale |
|---|--------|----------------|-----------|
| 1 | ...    | lib/features/  | ...       |
| 2 | ...    | ...            | ...       |

## Dependencies Map

[Diagram or description of which screens depend on which]

## Notes

[Any special coordination needed between screens]
```

---

### Phase 6 — Report

Output:
- Summary of shared entities found
- Navigation contracts identified
- Screens ordered for implementation
- Paths to created files: `docs/spec/app-domain.md`, `docs/spec/screen-order.md`
- Next step: `Run /logic-spec {first-screen-name} to begin the first screen`
