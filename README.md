[![swift-version](https://img.shields.io/badge/swift-6.2-ea7a50.svg?logo=swift&logoColor=white)](https://developer.apple.com/swift/)
[![xcode-version](https://img.shields.io/badge/xcode-26.3-50ace8.svg?logo=xcode&logoColor=white)](https://developer.apple.com/xcode/)
[![spm-ready](https://img.shields.io/badge/spm-ready-b68f6a.svg?logo=gitlfs&logoColor=white)](https://developer.apple.com/documentation/xcode/swift-packages)
[![platforms](https://img.shields.io/badge/platforms-iOS%2026+%20%7C%20macOS%2026+%20%7C%20tvOS%2026+%20%7C%20watchOS%2026+-lightgrey.svg?logo=apple&logoColor=white)](https://en.wikipedia.org/wiki/List_of_Apple_operating_systems)
[![docc](https://img.shields.io/badge/docc-documentation-0288D1.svg?logo=bookstack&logoColor=white)](https://thatfactory.github.io/lingokit/documentation/lingokit/)
[![license](https://img.shields.io/badge/license-MIT-67ac5b.svg?logo=googledocs&logoColor=white)](https://en.wikipedia.org/wiki/MIT_License)
[![ci](https://github.com/thatfactory/lingokit/actions/workflows/ci.yml/badge.svg)](https://github.com/thatfactory/lingokit/actions/workflows/ci.yml)
[![release](https://github.com/thatfactory/lingokit/actions/workflows/release.yml/badge.svg)](https://github.com/thatfactory/lingokit/actions/workflows/release.yml)

# LingoKit
A plug-and-play, UI-agnostic Swift toolkit for building and scoring language-learning exercises. 📚

It supports activities across *reading*, *writing*, *listening*, and *speaking* by providing reusable exercise modules and consistent evaluation/scoring logic.

Instead of organizing by modality, `LingoKit` organizes by exercise type—such as `intent classification`, `cloze`, or `ordering`—allowing the same exercise to be reused across different contexts. For example, `intent classification` can work with written prompts (*reading*) or audio transcripts (*listening*).

This approach keeps UI and content flexible while making it easy to integrate well-defined challenges and receive consistent, comparable results.

```mermaid
flowchart TB
  subgraph HOST["Host App/Game"]
    FLOW["ExerciseFlow"]
  end

  subgraph LK[" "]
    ALL["LingoKit"]
    CORE["LingoKitCore"]

    IC["LingoKitIntentClassification"]
    CLOZE["LingoKitCloze"]
    ORDER["LingoKitOrdering"]
    TILES["LingoKitTileAssembly"]
    FTXT["LingoKitFreeText"]
    SPEECH["LingoKitSpeechScoring"]
    ETC["..."]
  end

  FLOW --> ALL

  ALL --> IC
  ALL --> CLOZE
  ALL --> ORDER
  ALL --> TILES
  ALL --> FTXT
  ALL --> SPEECH
  ALL --> ETC

  IC --> CORE
  CLOZE --> CORE
  ORDER --> CORE
  TILES --> CORE
  FTXT --> CORE
  SPEECH --> CORE
  ETC --> CORE
```
