---
description: Commit staged files following project commit rules
allowed-tools: Bash, Read
---

You are creating a git commit for this Flutter project. Follow the rules in `.claude/commit-rules.md` exactly.

## Steps

1. Run `git diff --cached` to read staged changes in full.
2. Run `git log --oneline -10` to understand recent commit style in this repo.
3. Analyze the staged diff and draft a commit message:
   - Choose the correct `type` from: feat, fix, docs, style, refactor, perf, test, build, ci, chore
   - Choose a `scope` only if it clearly maps to one of the known scopes (auth, esim, payment, subscription, insurance, ui, api, i18n, analytics, ios, android). Omit scope if none fits.
   - Write the subject in **imperative mood**, **lowercase**, **no trailing period**, **under 50 characters**.
   - Add `!` after type/scope for breaking changes.
   - If the change warrants a body (non-obvious motivation or multi-concern change), add a blank line then 1–3 concise sentences.
4. Run the commit using a HEREDOC to preserve formatting. **Do NOT add `Co-Authored-By` or any attribution lines.**
5. Run `git status` to confirm the commit succeeded.

## Hard rules (never break these)

- No `Co-Authored-By` lines
- No "Generated with Claude" or similar attribution
- Subject must be lowercase (except proper nouns like Flutter, Stripe, ANA)
- Subject must be imperative mood ("add" not "added", "fix" not "fixed")
- Subject must be under 50 characters
- No trailing period on subject line

## Example commit command format

```bash
git commit -m "$(cat <<'EOF'
type(scope): subject under 50 chars

Optional body explaining the why, not the what.
One or two sentences max.
EOF
)"
```
