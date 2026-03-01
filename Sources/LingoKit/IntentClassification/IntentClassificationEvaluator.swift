import Foundation

/// Evaluates intent-classification exercises.
public enum IntentClassificationEvaluator {
    /// Evaluates a selected intent against an exercise definition.
    ///
    /// - Parameters:
    ///   - exercise: The exercise being solved.
    ///   - selectedIntent: The intent selected by the user.
    ///   - scoring: The scoring policy used for score calculation.
    /// - Returns: A result containing correctness, score, and feedback.
    public static func evaluate<Intent: Hashable & Codable & Sendable>(
        exercise: IntentClassificationExercise<Intent>,
        selectedIntent: Intent,
        scoring: IntentClassificationScoring = .standard
    ) -> IntentClassificationEvaluation<Intent> {
        let isCorrect = selectedIntent == exercise.expectedIntent
        let score = isCorrect ? scoring.correctPoints : scoring.incorrectPoints

        return IntentClassificationEvaluation(
            selectedIntent: selectedIntent,
            expectedIntent: exercise.expectedIntent,
            isCorrect: isCorrect,
            score: score,
            feedback: exercise.feedback
        )
    }

    /// Evaluates a selected intent against any exercise conforming to the protocol.
    ///
    /// - Parameters:
    ///   - exercise: The protocol-based exercise being solved.
    ///   - selectedIntent: The intent selected by the user.
    ///   - scoring: The scoring policy used for score calculation.
    /// - Returns: A result containing correctness, score, and feedback.
    public static func evaluate<Exercise: IntentClassificationExerciseType>(
        exercise: Exercise,
        selectedIntent: Exercise.Intent,
        scoring: IntentClassificationScoring = .standard
    ) -> IntentClassificationEvaluation<Exercise.Intent> {

        let isCorrect = selectedIntent == exercise.expectedIntent
        let score = isCorrect ? scoring.correctPoints : scoring.incorrectPoints

        return IntentClassificationEvaluation(
            selectedIntent: selectedIntent,
            expectedIntent: exercise.expectedIntent,
            isCorrect: isCorrect,
            score: score,
            feedback: exercise.feedback
        )
    }
}
