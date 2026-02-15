# ``LingoKitIntentClassification``

Intent-classification exercise definitions, evaluation, and scoring.

@Metadata {
    @Available(iOS, introduced: "26.0")
    @Available(macOS, introduced: "26.0")
    @Available(tvOS, introduced: "26.0")
    @Available(watchOS, introduced: "26.0")
}

## Overview

Use this module to define a prompt, candidate intents, and the expected intent.
Then evaluate a selected intent and receive a typed evaluation result with correctness and score.

## Usage

```swift
let exercise = IntentClassificationExercise(
    prompt: "Wie heißen sie?",
    intents: ["Name", "Age", "Address"],
    expectedIntent: "Name",
    feedback: "Correct."
)

let evaluation = exercise.evaluate(selectedIntent: "Name")
```

## Topics

### Core Types

- ``IntentClassificationExercise``
- ``IntentClassificationEvaluation``
- ``IntentClassificationScoring``

### Evaluation

- ``IntentClassificationEvaluator``
- ``IntentClassificationExercise/evaluate(selectedIntent:scoring:)``
