---
name: commit
description: Use when creating git commits or when the user asks to commit
  changes. Enforces the user's conventional-commit style.
---

# Commit Conventions

## Message format
`<type>(<optional scope>): <imperative lowercase summary, no period, <=72 chars>`

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`

## Flow
1. Inspect `git status`, `git diff`, and `git diff --cached`
2. Inspect the 5 most recent commits to get a sense of the user's commit style, size and frequency.
  - Use `git log -5 --date=short --pretty=format:'%h %ad %s'` for commit dates and messages
  - Use `git log -5 --stat --oneline` for changed-file row counts and size summaries.
3. Based on the relevant changes, create a commit message. (If you think the changes should be split
   into multiple commits, load and follow the `multi-commit` skill.)
4. Use the `commit-preview` skill for providing an approvable overview for the user.
5. If the user suggests adjustments, never partially commit, apply the changes,
   preview and repeat until the user approves.
6. After approval, before committing, verify the mentioned staged changes within
   the preview against `git diff --cached`, adjust the staged files if needed to
   align with the preview.

## Rules
- Relevancy:
  - If the user mentions a specific feature, files, or changes, only those are relevant.
  - If nothing is staged, assume all changes are relevant.
  - If some files are staged, assume those staged files are relevant.
  - Never commit secret-like files. If secrets are detected, interrupt and
    suggest adding them to `.gitignore`.
- Add to the commit message body...
  - ...explanations if the "why" isn't obvious
  - ...per-file changes with why if it's a large change
- Never commit without approval; always utilize the `commit-preview` skill.
- If a file contains irrelevant parts, ask the user whether they should become a part of the commit.
  - To stage only relevant parts, either use `git add -p` where applicable, or
    rename the original file, create a temporary file in its place with only
    the relevant parts, stage this one, and then restore the original.
- Never merge, rebase, amend, or force-push unless explicitly asked.
- No AI attribution footers (no "Generated with..." lines).
- If the user mentions spoofing, faking, backdating, or customizing the commit date, load and
  follow the `spoof-commit-date` skill. Do not spoof dates otherwise.
