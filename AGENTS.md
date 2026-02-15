# LingoKit

## Package Description
LingoKit is a Swift package that provides UI-agnostic domain logic for language-learning exercises.
It defines exercise models, evaluation contracts, and scoring policies using pure Swift data types.

The package is organized by exercise type and exposed through a single umbrella import (`import LingoKit`).

## Purpose
- Reuse exercise logic across clients without duplicating rules.
- Keep evaluation deterministic, consistent, and easy to test.
- Decouple app/game UI from exercise domain logic.
- Provide simple default scoring while allowing client-level scoring customization.

## Intent
LingoKit should evolve as a collection of modular exercise engines (intent classification, cloze, ordering, and more) that:
- remain language-agnostic by default;
- accept input and return outcomes (correctness, score, feedback) with no UI dependencies;
- expose stable, minimal APIs that are straightforward to integrate and version;
- support future scoring extensions (time bonuses, streak multipliers, difficulty weighting) without breaking existing clients.
