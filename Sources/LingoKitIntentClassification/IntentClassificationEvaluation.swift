import Foundation

/// Result of evaluating an intent-classification answer.
public struct IntentClassificationEvaluation<Intent: Hashable & Codable & Sendable>: Codable, Sendable, Equatable {
    /// The intent selected by the user.
    public let selectedIntent: Intent
    /// The expected correct intent.
    public let expectedIntent: Intent
    /// Indicates whether the selected intent matches the expected intent.
    public let isCorrect: Bool
    /// The computed score based on the selected scoring policy.
    public let score: Int
    /// Optional feedback associated with the exercise.
    public let feedback: String?

    /// Creates a new evaluation result.
    ///
    /// - Parameters:
    ///   - selectedIntent: The intent selected by the user.
    ///   - expectedIntent: The expected correct intent.
    ///   - isCorrect: Whether the answer is correct.
    ///   - score: The computed score for this answer.
    ///   - feedback: Optional feedback associated with the exercise.
    public init(
        selectedIntent: Intent,
        expectedIntent: Intent,
        isCorrect: Bool,
        score: Int,
        feedback: String?
    ) {
        self.selectedIntent = selectedIntent
        self.expectedIntent = expectedIntent
        self.isCorrect = isCorrect
        self.score = score
        self.feedback = feedback
    }
}
