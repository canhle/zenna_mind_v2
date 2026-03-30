---
description: Scaffold a complete Clean Architecture feature across all layers
allowed-tools: Read, Write, Glob, Grep, Bash(dart run build_runner build --delete-conflicting-outputs), Bash(flutter gen-l10n), Bash(flutter analyze)
---

# /scaffold-feature

Scaffold a complete Flutter Clean Architecture feature across all layers.

## Usage

```
/scaffold-feature
```

## What this command does

Generates all files for a new feature following the conventions in
`coding-conventions.md` and `architecture-guide.md`.

## Process

### Step 1 — Gather information

Ask the user for the following (collect all in one turn):

**Required:**
- Feature name (`snake_case`) — e.g. `order_list`, `product_detail`
- Entity name (`PascalCase`) — e.g. `Order`, `Product`
- API endpoint + method — e.g. `GET /orders`
- Entity fields — name, type, nullable

**Optional (use defaults if not provided):**
- UseCase needed? Default: only if filtering/validation logic described
- Screen arguments? Default: one `String id` field
- Events? Default: `NavigateToDetail` + `ShowError`
- Pagination? Default: no
- Generate test stub? Default: yes

### Step 2 — Generate files in order

Generate each file completely — no placeholders, no `// TODO`.

Order:
1. `domain/entities/{entity}.dart`
2. `domain/repositories/{entity}_repository.dart`
3. `domain/usecases/{entity}/get_{entity}s_usecase.dart` (if needed)
4. `domain/providers/{entity}_domain_providers.dart`
5. `data/models/{entity}_model.dart`
6. `data/datasources/{entity}_remote_datasource.dart`
7. `data/repositories/{entity}_repository_impl.dart`
8. `data/providers/{entity}_data_providers.dart`
9. `features/{feature}/models/{feature}_ui_state.dart`
10. `features/{feature}/models/{feature}_arguments.dart`
11. `features/{feature}/{feature}_view_model.dart`
12. `features/{feature}/{feature}_screen.dart`
13. `test/features/{feature}/{feature}_view_model_test.dart`

Also add the endpoint constant to `core/network/endpoints.dart`.

### Step 3 — Summary

After generating:
- Show the complete file tree
- List any new `pubspec.yaml` dependencies needed
- Remind to run: `dart run build_runner build --delete-conflicting-outputs`
- State any assumptions made

## Key rules to enforce

- ViewModel is `Notifier<XxxUiState>` — never `AsyncNotifier`
- UiState is `@freezed` — never `bool isLoading`
- Never `AsyncValue<List<T>>` — wrap in a Freezed data class
- ViewModel imports only from `domain/providers/` — never from `data/`
- No `try/catch` in DataSource or Repository — `ErrorInterceptor` handles it
- Pass only IDs in Arguments — never full entities
- `listenWithAutoClose` for all data loading
- Events are `sealed class`, consumed via `consumeEvent()`
