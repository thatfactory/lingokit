# LingoKit

## Context

LingoKit is a UI-agnostic Swift package for reusable language-learning exercise models, evaluation contracts, and scoring policies. Read [README.md](README.md) and [ExerciseTypes.mmd](ExerciseTypes.mmd) before changing package scope or exercise taxonomy.

LingoKit must remain language-agnostic, deterministic, and independent from application UI, Redux, persistence, and product-specific content.

## Shared guidelines

Read only the guides relevant to the task:

- [Agent workflow](AgentGuidelines/Guidelines/AgentWorkflow.md)
- [Swift](AgentGuidelines/Guidelines/Swift/Swift.md)
- [Swift style](AgentGuidelines/Guidelines/Swift/SwiftStyle.md)
- [Swift format](AgentGuidelines/Guidelines/Swift/SwiftFormat.md)
- [Unit and integration testing](AgentGuidelines/Guidelines/Testing/UnitTesting.md)
- [Documentation](AgentGuidelines/Guidelines/Documentation.md)
- [Logging](AgentGuidelines/Guidelines/Logging.md)
- [Packages](AgentGuidelines/Guidelines/Packages.md)
- [CI/CD](AgentGuidelines/Guidelines/CICD.md)
- [Git repositories and SSH-first cloning](AgentGuidelines/Guidelines/Git/Repositories.md)
- [GitHub pull requests](AgentGuidelines/Guidelines/GitHub/PullRequests.md)
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

## Stack

- Use Swift 6.4 with Xcode 27 and the platform versions declared in `Package.swift`.
- Package and test targets use SwiftPM's default concurrency settings; no repository-specific default actor isolation, infer-isolated-conformance, or `nonisolated(nonsending)` settings are declared.

## Package specialization

- Organize public exercise engines by exercise type rather than learning modality.
- Expose the package through the `LingoKit` product and umbrella import.
- Keep scoring and evaluation deterministic and directly testable.
- Prefer stable minimal APIs that allow host applications to supply content, context, UI, persistence, and progression policy.
- Preserve compatibility deliberately when extending scoring with time, streak, or difficulty inputs.
- Use logging subsystem `com.thatfactory.lingokit`, category `evaluation`, and canonical package emoji `📚`.

<!-- BEGIN THATFACTORY CODE REVIEW CONTRACT v1 -->
## Code Review Rules

Review for release-blocking defects introduced or materially exposed by the pull request. A clean review means no unresolved P0/P1 findings; it does not mean exhaustive or perfect software.

A blocking finding must identify a concrete, reachable path in a supported use case or the documented threat model that can cause a credible security-boundary bypass, durable data loss or corruption, a crash or deadlock, loss of availability, violation of an explicit acceptance criterion, or a serious compatibility regression.

For every blocking finding, state the severity, preconditions, execution path, impact, evidence, and actionable remediation. Group manifestations that share the same root cause into one finding.

Treat P2/P3 observations as non-blocking, including defense-in-depth, theoretical completeness, unsupported use cases, malformed state that trusted code cannot produce, behavior by components outside the threat model, style preferences, and speculative refactoring. Record a useful lower-severity observation once as deferred, declined, duplicate, or follow-up work; do not keep the review loop open for it.

In an initial review, report substantiated blockers together. A follow-up review is limited to unresolved P0/P1 findings, changes since the last reviewed commit, and code directly affected by those changes. Do not restart an unrestricted review of unchanged code. A new follow-up finding must be a P0/P1 defect introduced by the remediation or genuinely hidden by the previous blocker.

Automatic Codex review is the initial review. Do not request a manual Codex review unless the repository owner explicitly asks. Never request another review after each remediation commit. Within the normal review budget, at most one owner-authorized, delta-scoped verification review may be requested under [the pull-request review workflow](AgentGuidelines/Guidelines/GitHub/PullRequests.md).
<!-- END THATFACTORY CODE REVIEW CONTRACT v1 -->

## Codex review scope

For consumer pull requests, do not substantively review `AgentGuidelines/**` after exact tagged-tree provenance has been verified. Verify its `VERSION`, compare its tree with the matching central tag, and verify the required `.gitattributes` rule. If provenance does not match exactly, review the subtree contents and stop the merge. Report substantive guideline feedback against the central `agent-guidelines` pull request.
