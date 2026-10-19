# AGENTS.md

Instructions for AI coding agents and human contributors working in this
repository. Read this whole file before changing anything.

## Package

- Package: `Test20261019075102`, repository `JuliaPackageFactory/Test20261019075102.jl`. Requires Julia 1.12 or later.
- Layout: `src/Test20261019075102.jl` is the package code. `test/` holds the test suite
  and its own environment (`test/Project.toml`, a workspace member of the root
  project). `.github/workflows/` holds CI.
- Run every command below from the repository root. Always pass
  `--startup-file=no` so results do not depend on a user's startup file.

## Commands

```sh
# One-time setup: install the test dependencies.
julia --project=test --startup-file=no -e 'using Pkg; Pkg.instantiate()'

# Full test suite: package tests + Aqua + ExplicitImports + Runic check + JET.
julia --project=. --startup-file=no -e 'using Pkg; Pkg.test()'

# Format the code in place (do this before running the suite).
julia --project=test --startup-file=no -m Runic --inplace src test

# Fast iteration: run a single, self-contained test file.
julia --project=test --startup-file=no test/runtests.jl
julia --project=test --startup-file=no test/jet.jl
```

The first `Pkg.test()` precompiles the dependencies and can take several
minutes. Do not interrupt it. `JET_TEST=false` skips the JET analysis when you
only need the package tests.

## Definition of done

A task is finished only when all of the following hold. Do not report a task
as done otherwise; report what failed instead.

1. `julia --project=test --startup-file=no -m Runic --inplace src test` was run
   and left no changes behind.
2. `julia --project=. --startup-file=no -e 'using Pkg; Pkg.test()'` passes.
3. Every new feature or bug fix has a test that fails without the change.
4. Every public function, type, and constant has a docstring with its
   signature, a short description, and an example.
5. `CHANGELOG.md` has an entry under `[Unreleased]` for user-visible changes.

## Rules

- Never weaken a check to make it pass: do not delete or skip tests, loosen
  tolerances without justification, or disable Aqua, ExplicitImports, JET, or
  Runic. Fix the code. If a check reports a genuine false positive, say so
  explicitly and explain why.
- Do not edit `.github/workflows/`, `LICENSE`, or the `version` field of
  `Project.toml` unless the task asks for it.
- Do not commit `Manifest.toml`, coverage files, or editor and agent settings.
  `.gitignore` already excludes them.
- Add a dependency only when it clearly pays for itself. To add one, run
  `julia --project=. --startup-file=no -e 'using Pkg; Pkg.add("Name")'`, then
  add a `[compat]` entry in `Project.toml` (Aqua fails without one).
  Standard libraries also need a `[compat]` entry.
- Do not run `Pkg.update()`, `Pkg.gc()`, or registry operations.
- Keep changes focused on the task. Mention unrelated problems you notice
  instead of fixing them silently.

## Code conventions

- Formatting is decided by Runic, not by hand. Run it; do not argue with it.
- Imports are explicit: `using Foo: bar, baz` or `import Foo`. Never bare
  `using Foo`. ExplicitImports fails on implicit and stale imports.
- Mark the public API with `public name` (or `export` only when users should
  get the name with `using Test20261019075102`). Everything else is internal.
- Prefer type-stable code: concrete container element types, no untyped
  globals, no `Any` fields in structs. JET reports inference failures as
  errors.
- Docstrings follow this shape:

  ````julia
  """
      f(x; tol = 1e-8)

  One-sentence summary. Then details, arguments, and return value.

  # Examples

  ```julia
  julia> f(1.0)
  2.0
  ```
  """
  ````

- Tests: one file per feature in `test/`, included from `test/runtests.jl`.
  Each file starts with `using Test20261019075102` and `using Test` so it can run on
  its own. Use `@testset` with descriptive names. For numerical code, test
  against analytic results or known values with explicit tolerances
  (`isapprox` with `rtol` or `atol`), and test edge cases and error paths
  (`@test_throws`).
- Keep `src/Test20261019075102.jl` as the module file; move larger features into
  `src/<feature>.jl` and `include` them from the module file.

## Git

- Work on a branch. Make small commits with imperative messages
  ("Add finite-difference Hamiltonian", not "Added…").
- Pull request descriptions follow `.github/PULL_REQUEST_TEMPLATE.md`: what
  changed, why, and which commands you ran to validate it.
