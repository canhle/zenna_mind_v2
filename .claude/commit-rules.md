# Commit Message Rules

When creating git commits for this project, ALWAYS follow these rules:

## Format

```
<type>(<scope>): <subject>
```

## Quick Reference

### Types (Required)
- `feat` → New feature
- `fix` → Bug fix
- `docs` → Documentation
- `style` → Formatting (no code change)
- `refactor` → Code restructuring
- `perf` → Performance improvement
- `test` → Tests
- `build` → Build system
- `ci` → CI/CD changes
- `chore` → Maintenance

### Common Scopes (Optional)
- `auth`, `payment`, `subscription`,
- `ui`, `api`, `i18n`, `analytics`
- `ios`, `android`

## Rules

1. **Use imperative mood**: "add feature" not "added feature"
2. **Lowercase**: Start with lowercase (except proper nouns)
3. **No period**: Don't end subject with a period
4. **50 char limit**: Keep subject line under 50 characters
5. **Breaking changes**: Add `!` after type → `feat!:` or `feat(scope)!:`
6. **No Co-Authored-By**: Do NOT add `Co-Authored-By` lines to commits
7. **No Claude attribution**: Do NOT add "Generated with Claude" or similar lines to PRs

## Examples

```bash
# Good
feat(subscription): add Japan coverage option
fix(payment): resolve crash on Google Pay timeout
refactor(auth): simplify login flow logic
docs: update API integration guide
chore: bump flutter version to 3.27.4

# Bad
Added new feature          # No type, past tense
feat: Add Feature.         # Capitalized, has period
fix: fixed the bug         # Past tense
update stuff               # No type, vague
```

## Mapping to CHANGELOG.md

| Commit Type | Changelog Section |
|-------------|-------------------|
| `feat` | ### Added |
| `fix` | ### Fixed |
| `refactor`, `perf` | ### Changed |
| `deprecate` | ### Deprecated |
| `remove` | ### Removed |
| `security` | ### Security |
