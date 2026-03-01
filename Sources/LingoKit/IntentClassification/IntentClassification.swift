import Foundation

/// A UI-agnostic intent-classification exercise definition.
///
/// Use this type to define the prompt, possible intents, expected intent,
/// and optional feedback for a single exercise round.
public struct IntentClassificationExercise<Intent: Hashable & Codable & Sendable>: IntentClassificationExerciseType, Equatable {
    /// A unique identifier for the exercise instance.
    public let id: UUID
    /// The exercise prompt presented to the user.
    public let prompt: String
    /// The list of candidate intents shown to the user.
    public let intents: [Intent]
    /// The expected intent for this exercise.
    public let expectedIntent: Intent
    /// Optional feedback returned as part of the evaluation.
    public let feedback: String?

    /// Creates a new intent-classification exercise.
    ///
    /// - Parameters:
    ///   - id: A unique identifier for the exercise.
    ///   - prompt: The prompt shown to the user.
    ///   - intents: The candidate intents available for selection.
    ///   - expectedIntent: The expected intent for a correct answer.
    ///   - feedback: Optional feedback to return in the evaluation result.
    public init(
        id: UUID = UUID(),
        prompt: String,
        intents: [Intent],
        expectedIntent: Intent,
        feedback: String? = nil
    ) {
        self.id = id
        self.prompt = prompt
        self.intents = intents
        self.expectedIntent = expectedIntent
        self.feedback = feedback
    }

    /// Evaluates a selected intent and returns the scoring result.
    ///
    /// - Parameters:
    ///   - selectedIntent: The intent selected by the user.
    ///   - scoring: The scoring policy used to compute the final score.
    /// - Returns: The evaluation result containing correctness and score.
    public func evaluate(
        selectedIntent: Intent,
        scoring: IntentClassificationScoring = .standard
    ) -> IntentClassificationEvaluation<Intent> {
        IntentClassificationEvaluator.evaluate(
            exercise: self,
            selectedIntent: selectedIntent,
            scoring: scoring
        )
    }
}
