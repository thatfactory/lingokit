# LingoKit

## Context

LingoKit is a UI-agnostic Swift package for reusable language-learning exercise models, evaluation contracts, and scoring policies. Read [README.md](README.md) and [ExerciseTypes.mmd](ExerciseTypes.mmd) before changing package scope or exercise taxonomy.

LingoKit must remain language-agnostic, deterministic, and independent from application UI, Redux, persistence, and product-specific content.

## Shared guidelines

Read only the guides relevant to the task:

- [Swift](AgentGuidelines/Guidelines/Swift/Swift.md)
- [Swift style](AgentGuidelines/Guidelines/Swift/SwiftStyle.md)
- [SwiftLint](AgentGuidelines/Guidelines/Swift/SwiftLint.md)
- [Unit and integration testing](AgentGuidelines/Guidelines/Testing/UnitTesting.md)
- [Documentation](AgentGuidelines/Guidelines/Documentation.md)
- [Packages](AgentGuidelines/Guidelines/Packages.md)
- [CI/CD](AgentGuidelines/Guidelines/CICD.md)
- [Xcode MCP](AgentGuidelines/Guidelines/Xcode/MCP.md)
- [Xcode security audits](AgentGuidelines/Guidelines/Xcode/Security.md)

Redux, SwiftUI, and application-localization guidance do not apply unless a future target explicitly adopts those concerns.

## Physical folder map

| Role | Physical folder |
|---|---|
| Package sources | `Sources/LingoKit/` |
| Exercise implementations | `Sources/LingoKit/<ExerciseType>/` |
| DocC catalog | `Sources/LingoKit/LingoKit.docc/` |
| Unit tests | `Tests/LingoKitTests/` |

## Package specialization

- Organize public exercise engines by exercise type rather than learning modality.
- Expose the package through the `LingoKit` product and umbrella import.
- Keep scoring and evaluation deterministic and directly testable.
- Prefer stable minimal APIs that allow host applications to supply content, context, UI, persistence, and progression policy.
- Preserve compatibility deliberately when extending scoring with time, streak, or difficulty inputs.
