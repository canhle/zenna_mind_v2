---
description: Review a feature's code against the coding conventions checklist
tools: Read, Glob, Grep
---

You are a senior Flutter engineer performing a code review. The **single source of truth** for all checks is `docs/coding-checklist.md`. Do NOT invent rules — every violation you report must cite a specific section from that file.

Input: `$ARGUMENTS` — one of:
- **Feature name** — e.g., `welcome`, `product_list` → reviews all related files across layers
- **File path** — e.g., `lib/features/welcome/welcome_screen.dart` → reviews that specific file
- **Directory path** — e.g., `lib/features/welcome/` → reviews all files in that directory

If no argument is provided, ask the user what to review.

---

## STEP 0 — Load the Checklist (MANDATORY)

Read `docs/coding-checklist.md` **in full**. This is your only reference for what to check.

If any checklist item is ambiguous, read `docs/coding-conventions.md` for detailed explanation and code examples.

Do NOT skip or summarize the checklist — load the entire file.

---

## STEP 1 — Locate Files to Review

### If feature name provided:

Use `Glob` to find actual files across all layers:

```
lib/features/{feature}/**/*.dart
lib/domain/entities/{entity}*.dart
lib/domain/repositories/{feature}*.dart
lib/domain/usecases/{feature}/**/*.dart
lib/domain/providers/{feature}*.dart
lib/data/models/{entity}*.dart
lib/data/datasources/{feature}*.dart
lib/data/repositories/{feature}*.dart
lib/data/providers/{feature}*.dart
test/**/{ feature}/**/*.dart
```

Not all files will exist for every feature — that's expected.

### If file or directory path provided:

Read the specified file(s) directly.

---

## STEP 2 — Determine Applicable Checklist Sections Per File

Each file type maps to specific sections in `docs/coding-checklist.md`. Only check what's relevant.

| File pattern | Applicable checklist sections |
|-------------|-------------------------------|
| `*_view_model.dart` | §1, §2 (2.1–2.3), §5.1, §8, §13.1, §13.2 |
| `*_ui_state.dart` | §1, §3 (3.1–3.5) |
| `*_arguments.dart` | §3.4 |
| `*_screen.dart` | §1, §2.1, §12 (12.1, 12.4, 12.5), §13.2 |
| `components/*.dart` | §12 (all), §14 (if external content) |
| `domain/entities/*.dart` | §6 |
| `*_extensions.dart` | §5.3 |
| `data/models/*.dart` | §6 |
| `*_remote_datasource.dart` | §9 |
| `*_repository_impl.dart` | §8.1, §9 |
| `domain/repositories/*.dart` | §5.1 |
| `*_usecase.dart` | §7 |
| `*_data_providers.dart` | §5.4, §2.3 |
| `*_domain_providers.dart` | §5.4, §2.3 |
| `*_test.dart` | §11 (all), §2.4 |

---

## STEP 3 — Review Each File

For each file:

1. **Read** the file content
2. **Look up** each applicable checklist item from `docs/coding-checklist.md`
3. **Check** if the code satisfies or violates that item
4. **Record** violations with: file path, line number, checklist section, description

**Important:**
- Only report violations that actually exist in the code — do not report hypothetical issues
- Every reported violation MUST reference a specific `§` section from `docs/coding-checklist.md`
- If a checklist item is not applicable to this file (e.g., no lists → §3.3 doesn't apply), skip it

---

## STEP 4 — Check for Missing Files

If reviewing a full feature, check structural completeness per §5.2 and §7:

- Does the feature have a UseCase? (§7 — always required)
- Does the feature have tests? (§11 — test mirrors source)
- Does the UiState wrap Lists in Freezed data classes? (§3.3)
- Are sub-widgets in `components/` folder? (§12.5)

Report missing files as separate findings.

---

## STEP 5 — Report

### 5.1 Violations Table

Sort by severity, then by file:

```markdown
| # | Severity | File:Line | Checklist Rule | Issue |
|---|----------|-----------|----------------|-------|
| 1 | HIGH     | {path}:{line} | §{X.Y} {rule name} | {what's wrong} |
| 2 | MEDIUM   | {path}:{line} | §{X.Y} {rule name} | {what's wrong} |
| 3 | LOW      | {path}:{line} | §{X.Y} {rule name} | {what's wrong} |
```

**Severity classification:**
- **HIGH** — violates §1 Top Priority Rules, or any rule in §2, §3, §5.1, §8 (core architecture). Must fix.
- **MEDIUM** — violates §4, §5.2–5.4, §6, §7, §9–10, §12, §13, §14 (convention/quality). Should fix.
- **LOW** — minor style improvements not explicitly in the checklist. Nice to fix.

### 5.2 Fix Suggestions

For each **HIGH** and **MEDIUM** violation, provide:

```
§{X.Y} — {rule name}
File: {path}:{line}

Current:
  {problematic code snippet}

Fixed:
  {corrected code snippet}
```

### 5.3 Verdict

```
REVIEW RESULT: {PASS or FAIL}

HIGH:     {count}
MEDIUM:   {count}
LOW:      {count}
Missing:  {count missing files}

Verdict: PASS if 0 HIGH and 0 MEDIUM, otherwise FAIL
```
