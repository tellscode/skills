---
name: typescript-preflight
description: Use when editing TypeScript or TSX, fixing TypeScript errors, or checking readiness for a build. Finds and fixes type errors with project-wide compiler checks and focused source review before production builds.
---

# TypeScript Preflight

Catch type errors before a production build. Use compiler diagnostics as the source of truth; text searches only locate code to review.

## 1. Select the check

- Read repository instructions, relevant `package.json` scripts, lockfile, and owning `tsconfig.json` files, including `extends`, `include`, `exclude`, and project references.
- Identify changed and untracked `.ts`/`.tsx` files from Git status and diff. For a requested full audit, select every TypeScript package instead. If only checking changes clearly state this with a hint that otherwise the user should ask for a full audit.
- Prefer an existing typecheck script if it checks types without bundling or starting a production build. Inspect the script before running it.
- Otherwise run the installed TypeScript compiler through the repository's package manager: `tsc --noEmit -p <tsconfig>`. Do not download a compiler implicitly.
- Never pass individual source files to `tsc`; that bypasses project configuration. Do not mix file arguments with `-p`.
- For project references, use the repository's reference-aware check. If none exists, inspect the graph and check each project with its required referenced declarations available; do not assume checking a solution config checks its children.
- If framework-generated types are required, run the installed framework's supported type-generation command first (for example, `next typegen` when supported). Report missing dependencies, configuration, or unsupported generation as blockers.

## 2. Scan systematically

- Run the selected check for the **whole owning TypeScript project**, not only changed files. For changed shared exports or types, also check consuming workspace projects; if the consumer graph is unclear, check all TypeScript projects.
- Capture all diagnostics, including file, line, code, and message. Read the complete output rather than fixing only the first reported error.
- Review changed files and diagnostic sites. Follow referenced type declarations, imports, and affected callers. Expand to sibling usages only when the same faulty pattern appears.
- For a manual full audit, enumerate `.ts`/`.tsx` files under the selected projects' configured source roots. Skip dependencies, build output, and generated files during manual review; let the compiler check whatever the project configuration includes.
- At each diagnostic, read the enclosing function/component and the relevant type definition, not just the highlighted line.
- Specifically inspect:
  - Union-specific property access: find the discriminator guard and verify it narrows the **same object** being accessed.
  - `.map`, `.filter`, event handlers, effects, timers, and async callbacks: check whether a mutable variable or nested property loses narrowing across the callback boundary.
  - Optional/nullable values: ensure access follows an applicable guard; distinguish missing data from valid empty values.
  - Object literals, component props, function calls, and returns: check required fields, union variants, argument types, and return types against their declarations.
  - Changed exports/imports: check callers, renamed members, and exhaustive switches for newly added variants.
- Do not infer safety from a filename search or regex match. No finite pattern scan replaces the compiler.

### Fallback: compiler unavailable

- If the compiler cannot run, continue with source-only scanning. Do not stop at the blocker or install dependencies merely to perform this fallback.
- Enumerate files in the selected scope using Git status/diff and configured source roots. Read each selected file completely; searches are navigation aids, not proof that a file is safe.
- Follow imported types, inferred return values, and affected callers until the relevant contract is known. Mark unavailable declarations as unresolved; do not guess their shape.
- Apply the checklist above, plus these checks:
  - For each union-specific property, list the possible variants at that access. Confirm the guard excludes every variant without the property, including inside callbacks and after assignments or `await`.
  - Check optional properties, nullable results, `.find()` results, and indexed lookups against the project's actual strictness settings. Require appropriate guards where absence is possible.
  - Compare object literals, JSX props, arguments, and returns with their target types: required keys, spelling, literal discriminators, optionality, and incompatible value types.
  - Trace promises and callbacks: missing `await`, promise/value confusion, incompatible callback parameters, and missing return paths for declared non-void results.
  - Resolve local imports/exports and changed signatures; check affected callers and exhaustive branches. Inspect assertions and suppressions for assumptions that conceal these errors.
- Fix only issues supported by declarations and control flow. Reread each fix and its affected usages against the same checklist.
- Finish with **source review only — compiler unavailable**, list reviewed files and unresolved checks, and give the deferred typecheck command. Do not claim compiler verification or block completion of the source review on running it.

## 3. Repair the cause

- `TS2339` (property does not exist): inspect every union member. If only some members have the property, narrow by the declared discriminator before access.
- When a callback loses narrowing, capture the guarded object in a local `const` and use that constant inside the callback. A constant binding to the outer object alone does not stabilize its mutable nested properties.
- If a callback must use the latest state, narrow that state **inside** the callback/updater instead of using a captured snapshot.
- Preserve existing behavior for every variant. Do not manufacture fields on variants where they do not belong.
- Fix related occurrences together. Use diagnostics and concrete source evidence to decide what is related.
- Do not hide errors with `any`, unsafe `as`, non-null assertions, `@ts-ignore`, `@ts-nocheck`, relaxed compiler settings, or disabled build checks. Use assertions only for independently verified external invariants, explaining the evidence.

### Callback narrowing example

```tsx
type Rule =
  | { type: 'once'; at: string }
  | { type: 'weekly'; weekdays: number[] }

function Days({ value }: { value: { rule: Rule } }) {
  const rule = value.rule
  if (rule.type !== 'weekly') return null

  return [0, 1, 2, 3, 4, 5, 6].map(day => (
    <button key={day} aria-pressed={rule.weekdays.includes(day)}>
      {day}
    </button>
  ))
}
```

Use the application's actual discriminator and rendering behavior. In an existing component, capture/narrow inside the relevant branch or extract a component; do not move hooks behind conditional returns.

## 4. Close the loop before building

- When the compiler is available, fix the complete diagnostic batch, then rerun the same project checks. Repeat until they exit successfully with no type errors. Otherwise complete the source-only fallback above.
- Run relevant existing lint checks and behavior tests when the fix changes runtime logic.
- After successful checks, run a production build if requested or required by the repository. In source-only mode, report the deferred check rather than using a build as a substitute. Typechecking does not prove bundling, framework rules, or runtime behavior will pass.
- Report changed files, root cause, exact commands and results, and any unchecked projects or blockers. Never report a clean preflight if a required check could not run.
