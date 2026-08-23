---
name: spoof-commit-date
description: Use when assigning dates to commits or when the user explicitly
  asks to spoof, fake, backdate, or customize git dates.
---

# Spoof Commit Date

Use these rules when assigning dates to commits.

## Date Allocation

- Establish the allowed range. Use user-supplied inclusive boundaries; otherwise
  use a plausible work period (Mo-Fr 6AM-7PM; use after-hours, Mo-Fr 6PM-3AM or
  Sa-Su 6AM-3AM, only when specified or clearly personal work).
- Never generate a date at or before the latest existing commit (`HEAD`'s
  committer timestamp). For generated dates, move the lower bound forward; for
  an explicit exact date, reject it. Reject ranges with no valid timestamp.
- For one commit, randomize one timestamp within the effective range.
- For multiple commits, start from the current date, estimate effort, allocate
  backward, then randomize without duplicates or leaving the range. Use varied
  timestamps, no conspicuously round minute/hour/second values. Timestamps
  should look irregular and random, not deliberately patterned.
- Produce one exact `commit_date` per commit, including timezone. Use it for
  both author and committer dates unless explicitly separated.

## Commit Commands

Mac/Linux: `GIT_COMMITTER_DATE="2026-08-24T14:30:00-04:00" git commit -m "message" --date="2026-08-24T14:30:00-04:00"`
Windows: `set GIT_COMMITTER_DATE="2026-08-24T14:30:00-04:00" && git commit -m "message" --date="2026-08-24T14:30:00-04:00"`
