import Foundation

/// Evaluates tile-assembly exercises.
///
/// Each evaluation emits one `📚` debug log containing only the exercise type, correctness, and score.
public enum LKTileAssemblyEvaluator {
    /// Evaluates a selected tile sequence against an exercise definition.
    ///
    /// - Parameters:
    ///   - exercise: The exercise being solved.
    ///   - selectedTiles: The tile sequence selected by the user.
    ///   - scoring: The scoring policy used for score calculation.
    /// - Returns: A result containing correctness, score, and feedback.
    public static func evaluate<Tile: Hashable & Codable & Sendable>(
        exercise: LKTileAssemblyExercise<Tile>,
        selectedTiles: [Tile],
        scoring: LKTileAssemblyScoring = .standard
    ) -> LKTileAssemblyEvaluation<Tile> {
        makeEvaluation(
            selectedTiles: selectedTiles,
            expectedTiles: exercise.expectedTiles,
            feedback: exercise.feedback,
            scoring: scoring
        )
    }

    /// Evaluates a selected tile sequence against any protocol-based exercise.
    ///
    /// - Parameters:
    ///   - exercise: The protocol-based exercise being solved.
    ///   - selectedTiles: The tile sequence selected by the user.
    ///   - scoring: The scoring policy used for score calculation.
    /// - Returns: A result containing correctness, score, and feedback.
    public static func evaluate<Exercise: LKTileAssemblyExerciseType>(
        exercise: Exercise,
        selectedTiles: [Exercise.Tile],
        scoring: LKTileAssemblyScoring = .standard
    ) -> LKTileAssemblyEvaluation<Exercise.Tile> {
        makeEvaluation(
            selectedTiles: selectedTiles,
            expectedTiles: exercise.expectedTiles,
            feedback: exercise.feedback,
            scoring: scoring
        )
    }
}

// MARK: - Private

private extension LKTileAssemblyEvaluator {
    static func makeEvaluation<Tile: Hashable & Codable & Sendable>(
        selectedTiles: [Tile],
        expectedTiles: [Tile],
        feedback: String?,
        scoring: LKTileAssemblyScoring
    ) -> LKTileAssemblyEvaluation<Tile> {
        let isCorrect = selectedTiles == expectedTiles
        let score = isCorrect ? scoring.correctPoints : scoring.incorrectPoints

        let evaluation = LKTileAssemblyEvaluation(
            selectedTiles: selectedTiles,
            expectedTiles: expectedTiles,
            isCorrect: isCorrect,
            score: score,
            feedback: feedback
        )
        LKLogging.logEvaluation(
            exerciseType: .tileAssembly,
            isCorrect: evaluation.isCorrect,
            score: evaluation.score
        )
        return evaluation
    }
}
