---
name: spoof-commit-date
description: Use only when the user explicitly asks to spoof, fake, backdate,
  or customize git commit dates.
---

# Spoof Commit Date

- Apply these instructions only when the user explicitly requests date or time spoofing.
- If the user gives a date range, spread commits sequentially across that range
  estimating reasonable, non-uniform intervals based on the size, complexity, dependencies,
  and likely work required for each commit.
- Along the educated guesses, introduce some randomization within the given
  boundaries for realismh, use those time ranges:
  - workday hours (mo-fr 6am to 7pm) (default)
  - after hours (mo-fr 6pm to 3am, sa-su 6am to 3am) (only if explicitly specified, hobby, personal or side project mentioned)
- Commands:
  - Mac/Linux: `GIT_COMMITTER_DATE="YYYY-MM-DDTHH:MM:SS" git commit -m "message" --date="YYYY-MM-DDTHH:MM:SS"`
  - Windows: `set GIT_COMMITTER_DATE="YYYY-MM-DDTHH:MM:SS" && git commit -m "message" --date="YYYY-MM-DDTHH:MM:SS"`
