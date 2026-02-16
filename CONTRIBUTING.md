# Contributing to aeg

Thanks for contributing to `aeg`.

## Scope

This repository is an Elixir umbrella focused on agent runtime, safety, evals, memory, proactive behavior, persistence, and world-model loops.

Please keep contributions aligned with:
- safety-first runtime semantics
- explicit contracts via behaviours
- OTP-friendly design
- testability and observability

## Development Setup

1. Install prerequisites (Elixir/Erlang/Git).
2. From repository root:

```powershell
mix deps.get
mix compile
mix test
```

## Branching and Commit Style

- Create a feature branch from `main`.
- Use commit subjects in this style:
  - `feat: add X`
  - `fix: correct Y`
  - `refactor: simplify Z`
  - `docs: update W`

## Pull Request Checklist

Before opening a PR:

1. Ensure code compiles: `mix compile`.
2. Ensure tests pass: `mix test`.
3. Add or update tests for behavioral changes.
4. Update docs (`README.md`, module docs) when APIs change.
5. Keep PRs focused and small when possible.

In your PR description include:
- problem statement
- approach/architecture choices
- verification commands executed
- risk notes and rollback plan (if relevant)

## Coding Guidelines

- Prefer small modules with clear responsibilities.
- Define behaviours for extension points.
- Avoid hidden side effects in core runtime paths.
- Keep public API minimal and stable.
- Add typespecs for public functions.

## Testing Expectations

- Unit tests for pure logic.
- Integration tests for runtime pipeline boundaries.
- For safety features, include at least one negative test.
- For eval changes, ensure gate behavior is covered.

## Issue Reporting

For bugs, please include:
- steps to reproduce
- expected vs actual behavior
- Elixir/Erlang versions
- relevant logs or stack traces

## Community Standards

Be respectful and constructive.
Critique code, not people.
