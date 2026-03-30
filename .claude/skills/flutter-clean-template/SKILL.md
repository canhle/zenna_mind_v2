---
name: flutter-clean-template
description: >
  Generates a complete Flutter Clean Architecture feature or full project template using
  Riverpod, Freezed, and Dio. Use this skill whenever the user wants to scaffold a new
  Flutter feature, create a new screen with ViewModel/UiState/providers, generate the
  full Clean Architecture folder structure, or bootstrap a new Flutter project following
  Clean Architecture conventions. Triggers on phrases like "tạo feature", "scaffold feature",
  "tạo màn hình mới", "create new screen", "generate template", "tạo project Flutter",
  "new Flutter feature", "tạo clean architecture", or any request to generate Flutter
  boilerplate following layered architecture with Riverpod.
---

# Flutter Clean Architecture Template Generator

Generates production-ready Flutter code following Clean Architecture with Riverpod,
Freezed, and Dio — based on the conventions defined in `coding-conventions.md`
and `architecture-guide.md`.

---

## What this skill produces

Given a feature name (e.g. `order_list`), this skill generates all files across all layers:

```
domain/
  entities/order.dart
  repositories/order_repository.dart          # abstract interface
  usecases/order/get_orders_usecase.dart       # only if business logic exists
  providers/order_domain_providers.dart

data/
  models/order_model.dart
  datasources/order_remote_datasource.dart
  repositories/order_repository_impl.dart
  providers/order_data_providers.dart

features/order_list/
  order_list_screen.dart
  order_list_view_model.dart
  models/
    order_list_ui_state.dart                   # UiState + Event + data wrapper
    order_list_arguments.dart
  components/                                  # empty, ready for sub-widgets
```

---

## Step 1 — Gather requirements

Before writing any code, ask the user for the following. Collect all answers in one turn.

**Required:**
- Feature name in `snake_case` (e.g. `order_list`, `product_detail`, `cart`)
- Primary data entity name (e.g. `Order`, `Product`)
- API endpoint and HTTP method (e.g. `GET /orders`)
- Key fields for the entity (name, type, nullable?)
- Key API response fields that map to entity fields

**Optional (ask, but proceed with sensible defaults if not provided):**
- Does this feature's UseCase need specific business logic (validation, filtering, coordination)?
  Default: always create a UseCase; add described logic if any.
- Screen arguments: what data is passed in when navigating to this screen?
  Default: only an ID string.
- Events: what one-shot side effects does this screen need (navigate, show toast)?
  Default: `NavigateToDetail` and `ShowError`.
- Does the list use pagination? Default: no.
- Generate test file stub? Default: yes.

Read `references/architecture.md` for the quick rules checklist, and `docs/architecture-guide.md` for full architecture details if needed.

---

## Step 2 — Generate files

Generate each file completely — no placeholders, no `// TODO: implement`. Every file
must be immediately usable.

Follow this order so each file can reference the previous:

1. Entity → 2. Repository interface → 3. UseCase (if needed) → 4. Domain providers
→ 5. Model → 6. DataSource → 7. RepositoryImpl → 8. Data providers
→ 9. UiState + Event → 10. Arguments → 11. ViewModel → 12. Screen
→ 13. Test stub (if requested)

Read `references/code-patterns.md` for exact code patterns and templates for each file type.

---

## Step 3 — Present output

After generating all files:

1. Show the complete folder tree of generated files.
2. List the `pubspec.yaml` dependencies required (if not already in project).
3. Mention the `build_runner` command to run after adding files.
4. Highlight any assumptions made (e.g. "I assumed no UseCase needed since the fetch
   has no filtering logic — add one in `domain/usecases/` if business rules emerge").

---

## Key conventions (summary)

Full rules are in `references/architecture.md`. The most critical:

- ViewModel is always `Notifier<XxxUiState>` — never `AsyncNotifier`.
- UiState is always `@freezed`. Never use `bool isLoading`.
- Never hold `List<T>` directly in `AsyncValue` — wrap in a Freezed data class.
- All `DioException` → `Failure` translation happens in `ErrorInterceptor`, not in
  DataSource or Repository.
- ViewModel imports only from `domain/providers/` — never from `data/`.
- Pass only IDs between screens, never full entities.
- `listenWithAutoClose` for all data loading in ViewModel.
- Events are `sealed class` held in UiState, consumed via `consumeEvent()`.
