---
name: commit-preview
description: Use when presenting a preview before creating git commits,
  including the commit message, body, time, and exact staged files or line
  ranges.
---

# Commit Preview

Present a clear preview before creating each commit.

For every commit, include:

- **Message:** the complete subject line.
- **Body:** the complete body, or `none`.
- **Time:** the author and committer date/time that will be used.
- **Staged files:** every staged path and line ranges if only part of the file
  is staged. Description is not needed here; if required, it should be in the
  commit message body.

For multiple commits, present the commits in chronological order and separate
each preview.

## Format

```text
**Commit 1** - <Weekday>, <Month> <Day>, <Year> - <HH:MM:SS>
Title: <message subject>
Body: <message body or none>
Staged Files:
- <relative path> [lines/hunks if partial]
```

Comitting is never a part of this skill.
