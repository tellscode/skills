---
name: multi-commit
description: Use when changes should be investigated and split into multiple
  logical git commits, with previews and spoofed dates for the resulting commit
  sequence.
---

# Multi-Commit Workflow

Follow the `commit` skill for baseline commit rules and the `commit-preview`
skill for the required presentation format. This skill only adds rules for splitting
changes into multiple commits.

## Flow

Same as `commit` skill, with additional steps for splitting all changes into
reasonable, coherent commits between step 1 and step 2.

1. Step 1-2 of `commit` skill.
3. Split all changes into multiple commits based on the state rules.
4. Step 3-6 of `commit` skill.

## Rules

- Respect comments of the user regarding which features or files
  should be grouped together or kept separate.
- Inspect all changes before and keep each commit independently
  understandable and buildable or testable where practical.
- Group by features and intent, not just filenames.
- Do not split changes to increase the commit count, try to
  keep commit count reasonably low and meaningful.
- Try to keep feature and doc changes together in the same commit.
- All rules from the `commit` skill.
