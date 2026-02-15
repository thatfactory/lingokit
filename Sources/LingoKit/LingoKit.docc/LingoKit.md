# ``LingoKit``

UI-agnostic domain logic for language-learning exercises.

@Metadata {
    @Available(iOS, introduced: "26.0")
    @Available(macOS, introduced: "26.0")
    @Available(tvOS, introduced: "26.0")
    @Available(watchOS, introduced: "26.0")
}

## Overview

`LingoKit` is the umbrella module for exercise engines.

It currently re-exports intent-classification APIs, so client apps can only `import LingoKit` and still access intent-classification symbols.

## Topics

### Intent Classification

Intent-classification APIs are re-exported from `LingoKitIntentClassification`.
