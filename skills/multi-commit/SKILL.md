---
name: multi-commit
description: Use when changes should be investigated and split into multiple
  logical git commits, with previews and distinct sequential commit dates.
---

# Multi-Commit Workflow

Follow the `commit` skill for baseline commit rules and the `commit-preview`
skill for the required presentation format. This skill adds rules for splitting
changes and assigning commit dates.

## Flow

1. Follow steps 1-2 of the `commit` skill.
2. Split all relevant changes into the smallest reasonable set of coherent
   commits.
3. Inspect each proposed commit for independent understandability and
   buildability or testability where practical.
4. Create one complete commit record for each commit, including its exact
   `commit_date`, subject, body, and staged files.
5. Assign commit dates using the `spoof-commit-date` skill, anchoring the
   sequence to the current date and time and allocating commits backward from it.
6. Forward all records unchanged to `commit-preview` in chronological order.
7. Follow steps 3-6 of the `commit` skill.

## Rules

- Respect comments of the user regarding which features or files
  should be grouped together or kept separate.
- Inspect all changes before and keep each commit independently
  understandable and buildable or testable where practical.
- Group by features and intent, not just filenames.
- Do not split changes to increase the commit count, try to
  keep commit count reasonably low and meaningful.
- Try to keep feature and doc changes together in the same commit.
- Use `spoof-commit-date` for date allocation, even when the user did not
  explicitly request historical dates. In this workflow, “spoofing” means
  assigning plausible dates to the commit sequence, not necessarily backdating it.
- All rules from the `commit` skill.
