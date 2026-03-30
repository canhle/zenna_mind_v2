---
description: Review a feature's code against Clean Architecture conventions
allowed-tools: Read, Glob, Grep
---

# /review-feature

Review an existing feature's code against the Clean Architecture conventions.

## Usage

```
/review-feature {feature_name}
```

Example: `/review-feature order_list`

## What this command does

Reads all files for the given feature across all layers and checks them against
the conventions in `coding-conventions.md`.

## Process

### Step 1 — Locate files

Read files from:
- `domain/entities/{entity}.dart`
- `domain/repositories/{entity}_repository.dart`
- `domain/usecases/{entity}/`
- `domain/providers/{entity}_domain_providers.dart`
- `data/models/{entity}_model.dart`
- `data/datasources/{entity}_remote_datasource.dart`
- `data/repositories/{entity}_repository_impl.dart`
- `data/providers/{entity}_data_providers.dart`
- `features/{feature}/`

### Step 2 — Check each rule

For each file, verify the following checklist:

**ViewModel**
- [ ] Extends `Notifier<XxxUiState>` — not `AsyncNotifier`
- [ ] Annotated `@riverpod` (not `@Riverpod(keepAlive: true)` unless justified)
- [ ] Uses `listenWithAutoClose` for data loading — not `ref.watch`
- [ ] No mutable instance fields (except `late final`)
- [ ] Has `consumeEvent()` method
- [ ] `_handleError()` switches on `Failure` types — not on generic `Exception`
- [ ] Does not import from `data/` layer

**UiState**
- [ ] Is `@freezed`
- [ ] No `bool isLoading` fields — uses `AsyncValue`
- [ ] No `AsyncValue<List<T>>` — List wrapped in Freezed data class
- [ ] Events defined as `sealed class`

**DataSource**
- [ ] No `try/catch` blocks
- [ ] No cached state
- [ ] Uses `Endpoints.*` constants — no hardcoded URL strings
- [ ] Interface + implementation separated

**Repository**
- [ ] No `try/catch` blocks
- [ ] Only calls DataSource + maps to Entity
- [ ] No business logic

**Domain Providers**
- [ ] UseCase provider present (if UseCase exists)
- [ ] Functional provider uses `ref.read` — not `ref.watch`

**Arguments**
- [ ] Is `@freezed`
- [ ] Contains only IDs — not full entities

**Screen**
- [ ] `ref.listen` for Events, calls `consumeEvent()` after handling
- [ ] Uses `.select()` for sub-widget subscriptions
- [ ] Sub-widgets extracted as classes — not `_buildXxx()` methods

### Step 3 — Report

Output a table:

| File | Issues | Severity |
|------|--------|----------|
| order_list_view_model.dart | Uses `ref.watch` in ViewModel | 🔴 High |
| order_model.dart | `AsyncValue<List<Order>>` in UiState | 🔴 High |
| order_list_screen.dart | Missing `.select()` on sub-widget | 🟡 Medium |

Severity:
- 🔴 High — violates core architecture rule, must fix
- 🟡 Medium — convention violation, should fix
- 🟢 Low — style suggestion

After the table, list specific fixes for each High issue with corrected code snippets.
