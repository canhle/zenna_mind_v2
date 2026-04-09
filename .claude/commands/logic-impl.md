---
description: Full logic implementation pipeline for a screen: plan → tasks → implement (task by task with review) → final cross-artifact check. Pauses between phases for confirmation.
---

## User Input

```text
$ARGUMENTS
```

The argument is the screen name (e.g., `welcome`, `browse`, `home`, `player`, `streak`, `meditation_complete`).

If no argument provided, ask: "Which screen do you want to implement? (welcome / browse / home / player / streak / meditation_complete)"

---

## Pre-checks

1. Run `.specify/scripts/bash/check-prerequisites.sh --json --require-tasks` to verify feature setup.
   - If it fails: STOP and output the error with guidance.
   - If it succeeds: parse FEATURE_DIR.

2. Verify that `FEATURE_DIR/spec.md` exists. If not:
   ```
   ⚠ spec.md not found for this screen.
   Run /logic-spec {SCREEN_NAME} first to create the logic spec.
   ```

3. Read `docs/spec/app-domain.md` for shared entity context throughout this session.

4. Read `docs/db/zenna_mind_database_design.md` — Firestore schema is the authoritative source for all data contracts. All DataSources in this project read from Cloud Firestore, NOT REST.

5. Determine SCREEN_NAME from `$ARGUMENTS`.

---

## Pipeline

This command runs in **5 phases**. After each phase, report what was done and ask:

```
✅ Phase {N} complete: {short summary}

Continue to Phase {N+1}: {next phase name}? (yes / no / show-details)
- yes → proceed
- no → stop here; you can resume by running /logic-impl {SCREEN_NAME} again
- show-details → show full output of this phase before deciding
```

---

### PHASE 1 — Technical Plan

Read `.claude/commands/speckit.plan.md` in full and execute ALL its steps.

**Additional constraints specific to logic-impl:**

1. File structure note: "UI already implemented — no new Screen or component files. Only domain/, data/, and ViewModel/UiState updates."

2. **Data layer MUST use Cloud Firestore**, not Dio/HTTP:
   - DataSources use `cloud_firestore` (`FirebaseFirestore.instance`) — not Dio
   - Name DataSources `{screen}_firestore_datasource.dart` (not `*_remote_datasource.dart`)
   - For every entity fetched, cite the exact Firestore path from `docs/db/zenna_mind_database_design.md` in the plan
   - Specify read mode per query: one-shot `get()` vs realtime `snapshots()` stream
   - Error handling: `FirebaseException` → `Failure` translated inside the DataSource (no Dio interceptor applies here)
   - Models use `@JsonSerializable` with `fromFirestore`/`toFirestore` conversion helpers, or manual `fromMap`/`toMap`

3. The plan.md "Data Mapping" section MUST show: Firestore field → Model field → Entity field → UiState field.

After plan.md is written: **Pause → ask to continue to Phase 2.**

---

### PHASE 2 — Task Breakdown

Read `.claude/commands/speckit.tasks.md` in full and execute ALL its steps.

**Additional constraints**:

Task phases MUST be ordered by Clean Architecture layer dependency:
1. Domain layer first (entities, repository interface, UseCases, domain providers)
2. Data layer second (Firestore models with `fromFirestore`/`toFirestore`, FirestoreDataSource, RepositoryImpl, data providers)
3. Presentation layer third (update UiState, update ViewModel, wire events, remove mock usage)
4. Codegen + Polish last (build_runner, flutter analyze, remove *_mock_data.dart)

Every data-layer task MUST reference the exact Firestore collection/document path from the database design PDF.

After tasks.md is written: **Pause → ask to continue to Phase 3.**

---

### PHASE 3 — Cross-artifact Analysis

Read `.claude/commands/speckit.analyze.md` in full and execute ALL its steps.

**Additional checks beyond standard speckit.analyze:**
- Verify every mock field in existing UiState is accounted for in the plan (Firestore, local, computed, or explicit static/l10n)
- Verify entities in plan match definitions in `docs/spec/app-domain.md` — no drift
- Verify every Firestore path cited in the plan actually exists in `docs/db/zenna_mind_database_design.md` — no invented collections
- Verify no plan.md task mentions Dio, REST, endpoints, or HTTP — this app is Firestore-only

Output consistency report. If any blocker: STOP until resolved.

**Pause → ask to continue to Phase 4 (implementation).**

---

### PHASE 4 — Implementation (task by task with inline review)

Execute tasks from `FEATURE_DIR/tasks.md` one at a time:

**For each task:**

1. Read the task description and target file path.
2. Implement the task (create or modify file).
3. If new `@freezed`, `@riverpod`, or `@JsonSerializable` file created: run `dart run build_runner build --delete-conflicting-outputs`.
4. Run `flutter analyze` on the changed file(s). Fix all warnings before continuing.
5. **Inline review**: Read `docs/coding-checklist.md`. Apply only the sections relevant to this file type (per the file-type mapping table in `.claude/commands/review-feature.md`). Fix all HIGH/MEDIUM violations before the next task.
6. Mark task as `[X]` in tasks.md.
7. Report: `✅ T{NNN} done — {file path} — review: {PASS/FAIL with count}`

After every **layer boundary** (end of Domain, Data, Presentation, Codegen sub-phases):
```
✅ Phase 4/{sub-phase} complete.
Implemented {N} tasks. Continue to next sub-phase? (yes / no)
```

**If any task fails** (build error, analyzer error that cannot be auto-fixed):
- Report the error in full
- STOP and ask: "Task T{NNN} failed. How would you like to proceed? (fix / skip / stop)"

---

### PHASE 5 — Final Review & Cross-artifact Check

**Part A — Full feature review**:

Read `.claude/commands/review-feature.md` in full and execute ALL its steps for the SCREEN_NAME feature.

**Part B — Final cross-artifact analysis**:

Read `.claude/commands/speckit.analyze.md` in full and execute ALL its steps.
Additionally verify:
- All tasks in tasks.md are marked [X]
- All mock data files are removed or have a documented reason to keep
- `flutter analyze` passes with zero warnings across the entire project

**Part C — Summary report**:

```
## Logic Implementation Complete: {SCREEN_NAME}

### Phase Summary
| Phase | Status | Notes |
|-------|--------|-------|
| Plan  | ✅     | {N} files planned |
| Tasks | ✅     | {N} tasks generated |
| Analyze | ✅   | No blockers |
| Implement | ✅ | {N} tasks, {N} codegen runs |
| Review | {PASS/FAIL} | {N} HIGH, {N} MEDIUM, {N} LOW |

### Files Created/Modified
[list]

### Remaining Issues (if any)
[list — must be addressed before this screen is considered done]

### Next screen
Check `docs/spec/screen-order.md` for the next screen to implement.
Run: /logic-spec {next-screen}
```
