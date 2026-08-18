import Foundation

/// Evaluates intent-classification exercises.
///
/// Each evaluation emits one `📚` debug log containing only the exercise type, correctness, and score.
public enum LKIntentClassificationEvaluator {
    /// Evaluates a selected intent against an exercise definition.
    ///
    /// - Parameters:
    ///   - exercise: The exercise being solved.
    ///   - selectedIntent: The intent selected by the user.
    ///   - scoring: The scoring policy used for score calculation.
    /// - Returns: A result containing correctness, score, and feedback.
    public static func evaluate<Intent: Hashable & Codable & Sendable>(
        exercise: LKIntentClassificationExercise<Intent>,
        selectedIntent: Intent,
        scoring: LKIntentClassificationScoring = .standard
    ) -> LKIntentClassificationEvaluation<Intent> {
        makeEvaluation(
            selectedIntent: selectedIntent,
            expectedIntent: exercise.expectedIntent,
            feedback: exercise.feedback,
            scoring: scoring
        )
    }

    /// Evaluates a selected intent against any exercise conforming to the protocol.
    ///
    /// - Parameters:
    ///   - exercise: The protocol-based exercise being solved.
    ///   - selectedIntent: The intent selected by the user.
    ///   - scoring: The scoring policy used for score calculation.
    /// - Returns: A result containing correctness, score, and feedback.
    public static func evaluate<Exercise: LKIntentClassificationExerciseType>(
        exercise: Exercise,
        selectedIntent: Exercise.Intent,
        scoring: LKIntentClassificationScoring = .standard
    ) -> LKIntentClassificationEvaluation<Exercise.Intent> {
        makeEvaluation(
            selectedIntent: selectedIntent,
            expectedIntent: exercise.expectedIntent,
            feedback: exercise.feedback,
            scoring: scoring
        )
    }
}

// MARK: - Private

extension LKIntentClassificationEvaluator {
    fileprivate static func makeEvaluation<Intent: Hashable & Codable & Sendable>(
        selectedIntent: Intent,
        expectedIntent: Intent,
        feedback: String?,
        scoring: LKIntentClassificationScoring
    ) -> LKIntentClassificationEvaluation<Intent> {
        let isCorrect = selectedIntent == expectedIntent
        let score = isCorrect ? scoring.correctPoints : scoring.incorrectPoints

        let evaluation = LKIntentClassificationEvaluation(
            selectedIntent: selectedIntent,
            expectedIntent: expectedIntent,
            isCorrect: isCorrect,
            score: score,
            feedback: feedback
        )
        LKLogging.logEvaluation(
            exerciseType: .intentClassification,
            isCorrect: evaluation.isCorrect,
            score: evaluation.score
        )
        return evaluation
    }
}
