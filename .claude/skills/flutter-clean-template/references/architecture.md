# Architecture Reference

> **This is a compact rules-only reference for the Claude skill.**
> Full documentation with explanations, "why" decisions, and step-by-step guides:
> see [`docs/architecture-guide.md`](../../../../docs/architecture-guide.md).

---

## Quick Rules Checklist

When generating or reviewing code, enforce these rules:

### ViewModel
- Always `Notifier<XxxUiState>` — **never** `AsyncNotifier`
- `@riverpod` (auto-dispose). `@Riverpod(keepAlive: true)` only for app-global state
- `build(XxxArguments args)` returns initial UiState
- Data loading via `listenWithAutoClose` — not `ref.watch`
- `ref.read` only for one-time user actions
- No mutable instance fields — all state in UiState
- Always provide `consumeEvent()` when UiState has `event` field
- Error handling via `_handleError(Object error)` — switch on `Failure` types

### UiState
- Always `@freezed`
- Async fields: `AsyncValue<XxxData>` where `XxxData` is also `@freezed`
- **Never** `AsyncValue<List<T>>` — wrap in Freezed class
- **Never** `bool isLoading` — use `AsyncValue`
- Arguments: separate `@freezed` class, pass only IDs

### Events
- `sealed class XxxEvent` in same file as UiState
- Consumed via `consumeEvent()`, screen reacts with `ref.listen`

### Dependencies
- **Presentation** → `domain/providers/` only. Never `data/`
- **Domain** → `domain/repositories/` (abstract)
- **Data** → `domain/repositories/` (to implement)
- **Core** → imported by all. Imports nothing from domain/data/features

### Extensions
- `core/extensions/` = SDK types only (`BuildContext`, `String`, `DateTime`)
- Domain entity extensions → next to entity in `domain/entities/`
- 3rd-party type extensions → next to wrapper file
- Feature-specific → inside feature folder

### Error Handling
- `ErrorInterceptor` translates all `DioException` → `Failure`
- DataSource/Repository: no `try/catch`
- ViewModel: `switch` on `Failure` subtypes → update UiState + Event

### Network
- Dio + interceptors. All URLs in `Endpoints`
- DataSources are stateless — no cache, no retry, no business logic

### Localization
- ARB files in `lib/core/l10n/arb/`, keys grouped by feature prefix
- Generated class `S` — run `flutter gen-l10n` after edits
