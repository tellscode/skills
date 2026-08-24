---
name: skill-creator
description: Use when creating, rewriting, editing, or improving an agent or skill. Clarifies requirements, rules out edge cases, and produces concise, scoped instructions.
---

# Skill Creator

Create or improve agent and skill instructions through deliberate clarification.

## Workflow

1. Inspect the target file and nearby conventions before proposing changes.
2. Identify the requested scope: create, rewrite the entire file, or edit only a specified section.
3. Ask focused questions until the behavior, boundaries, priorities, and acceptance criteria are clear enough to implement; do not ask questions whose answers cannot change the result.
4. Ask about edge cases that could change the implementation, including:
   - trigger conditions and exclusions
   - ambiguous or conflicting requests
   - missing, invalid, or partial input
   - destructive actions, permissions, and user approval
   - scope limits, related files, and backward compatibility
   - failure handling, verification, and expected output
5. Do not invent answers. If an unresolved choice materially affects the result, ask it.
6. Summarize confirmed requirements in concise language and get confirmation when the request is substantially ambiguous.
7. Implement only the confirmed scope. Preserve unrelated content and conventions.
8. Review the result for contradictions, unnecessary repetition, vague wording, and uncovered edge cases.
9. Verify formatting and any practical checks relevant to the edited file.

## Runtime Boundaries

- Do not promise that editing a skill reloads it in the current OpenCode session.
- Treat loaded skills as static until OpenCode restarts.
- Do not claim that a subagent has zero parent context; its task prompt can carry context supplied by the invoking agent.
- When a workflow needs isolation, provide the smallest explicit prompt and state whether it uses a child session or a separate process.

## Scope Control

- For a paragraph or section request, change only that portion unless a dependent correction is necessary.
- For a targeted improvement, preserve the file's structure and unrelated behavior.
- For a full rewrite, replace the whole instruction body only after confirming goals, compatibility, and omissions.
- Do not add examples, sections, tooling, or fallback behavior merely because they seem useful.
- When the requested scope is unclear, ask whether to patch minimally or rewrite broadly before editing.

## Requirements Style

- State requirements as short, direct imperatives.
- Prefer one rule per line or bullet.
- Keep necessary precision; remove filler, repeated rationale, and speculative guidance.
- Define exceptions beside the rule they modify.
- Preserve important exact names, paths, commands, formats, and constraints.
- Separate required behavior from optional suggestions.

## Output

After clarification, report the chosen scope, key assumptions, files changed, and verification performed. If questions remain, ask them instead of editing.
