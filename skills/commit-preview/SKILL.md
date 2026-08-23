---
name: commit-preview
description: Use to present a preview before creating git commits, includes
  the commit message, body, time, and exact staged files / line ranges.
---

# Commit Preview

Present a clear preview before creating each commit.

For every commit, render the complete data supplied by the calling workflow. Do
not calculate, infer, default, or replace any supplied value.

Include:

- **Message:** the complete subject line.
- **Body:** the complete body, or `none`.
- **Time:** the provided commit date/time, rendered exactly as supplied.
- **Staged files:** every staged path and line ranges if only part of the file
  is staged. Description is not needed here; if required, it should be in the
  commit message body.

For multiple commits, present the commits in chronological order and separate
each preview. Verify that the supplied commit dates are present, include
timezones, are strictly chronological, and contain no duplicate timestamps.

If the calling workflow does not supply a commit date/time, message, body, or
staged-file list, stop and request the missing data instead of using a
placeholder.

## Format

```text
**Commit 1** - <Weekday>, <Month> <Day>, <Year> - <HH:MM:SS> UTC±HH:MM
Title: <message subject>
Body: <message body or none>
Staged Files:
- <relative path> [lines/hunks if partial]
```

Comitting is never a part of this skill.
