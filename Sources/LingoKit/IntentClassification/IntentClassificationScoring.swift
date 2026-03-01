import Foundation

/// Scoring policy for intent-classification exercises.
public struct IntentClassificationScoring: Codable, Sendable, Equatable {
    /// Score awarded when the selected intent is correct.
    public let correctPoints: Int
    /// Score awarded when the selected intent is incorrect.
    public let incorrectPoints: Int

    /// Creates a scoring policy.
    ///
    /// - Parameters:
    ///   - correctPoints: Score for correct answers.
    ///   - incorrectPoints: Score for incorrect answers.
    public init(
        correctPoints: Int,
        incorrectPoints: Int
    ) {
        self.correctPoints = correctPoints
        self.incorrectPoints = incorrectPoints
    }

    /// The default scoring policy used by evaluation.
    ///
    /// Correct answers award 10 points and incorrect answers award 0 points.
    public static let standard = IntentClassificationScoring(
        correctPoints: 10,
        incorrectPoints: 0
    )
}
