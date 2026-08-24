---
name: skill-tester
description: Use when testing an agent or skill against described behavior. Iteratively refine it with skill-creator and fresh isolated evaluations until it meets the criteria.
---

# Skill Tester

Test an agent or skill as a black box against behavior the user describes.

## Core Rule

Treat every iteration as a fresh run. Do not rely on a running session to reload
an edited skill. Inject the current instruction text directly into the test
prompt, or use a temporary isolated fixture, instead of assuming live skill
reloads.

## Workflow

1. Ask for the target skill or agent, desired behavior, representative inputs,
   unacceptable behavior, and pass criteria.
2. Use `skill-creator` to clarify missing requirements and produce the smallest
   suitable instruction change.
3. Build a test case from the confirmed requirements. Include normal, boundary,
   ambiguous, and failure inputs when relevant.
4. Start a new evaluator invocation for each test case or iteration. Prefer a
   separate process or API call for the strongest isolation. A new OpenCode
   subagent invocation creates a child session, but does not guarantee zero
   parent context; minimize the task prompt explicitly.
5. Provide the evaluator only the current instruction text, the test input, and
   the evaluation task. Do not expose prior failures unless they are part of
   the test input. Do not claim stronger isolation than the runtime provides.
6. Record the evaluator's output and judge it against the pass criteria, not
   against the intended implementation.
7. If it fails, give `skill-creator` only a compact failure report containing the
   input, observed output, violated criterion, and relevant reproduction data.
8. Repeat clarification, revision, and fresh evaluation until the criteria pass
   or the user-defined iteration limit is reached.
9. Before saving, show the final instruction text or a concise diff and state
   which cases passed, failed, or remain untested.

## Isolation

- Assume installed or running skills are not hot-reloaded; edits take effect
  reliably only after restarting OpenCode.
- Keep candidate instructions as plain text during testing; do not edit the
  live skill after every iteration unless the user asks for that workflow.
- For a separate process or API call, reset conversation, tool results, scratch
  files, and remembered failure analysis between iterations.
- For an OpenCode subagent, start a new child session and pass a minimal task;
  describe this as session separation, not guaranteed context erasure.
- If no new session or process is available, use a clean prompt with explicit
  candidate-text injection, label the result as weak isolation, and do not
  present it as an independent test.
- Never let the evaluator edit the target skill or repair its own instructions.

## Evaluation

- Test one behavior or a small related set at a time.
- Use deterministic inputs where possible and repeat flaky cases.
- Distinguish instruction defects from evaluator variance, unavailable tools,
  and unclear criteria.
- Do not call a skill successful because it sounds plausible; require observable
  output, action, or refusal criteria.
- Stop when all required criteria pass. Do not optimize optional behavior or
  expand scope without user approval.

## Output

Report the candidate tested, isolation method and its limitations, test cases
and expected results, iteration count, pass/fail evidence, remaining risks, and
the exact final change. Save or apply the change only after the user approves
when approval is required by context.
