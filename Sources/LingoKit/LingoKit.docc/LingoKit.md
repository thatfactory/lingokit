# ``LingoKit``

UI-agnostic domain logic for language-learning exercises.

@Metadata {
    @Available(iOS, introduced: "26.0")
    @Available(macOS, introduced: "26.0")
    @Available(tvOS, introduced: "26.0")
    @Available(watchOS, introduced: "26.0")
}

## Overview

`LingoKit` supports activities across *reading*, *writing*, *listening*, and *speaking* by providing reusable exercise modules and consistent evaluation/scoring logic.

Instead of organizing by modality, `LingoKit` organizes by exercise type—such as `intent classification`, `cloze`, or `ordering`—allowing the same exercise to be reused across different contexts. For example, `intent classification` can work with written prompts (*reading*) or audio transcripts (*listening*).

This approach keeps UI and content flexible while making it easy to integrate well-defined challenges and receive consistent, comparable results.

## Topics

### Intent Classification

Use this module to define a prompt, candidate intents, and the expected intent.
Then evaluate a selected intent and receive a typed evaluation result with correctness and score.
When host apps use custom catalog models, conform them to ``IntentClassificationExerciseType`` and evaluate them with ``IntentClassificationEvaluator``.
