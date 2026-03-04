import Foundation

/// Evaluates tile-assembly exercises.
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
        let isCorrect = selectedTiles == exercise.expectedTiles
        let score = isCorrect ? scoring.correctPoints : scoring.incorrectPoints

        return LKTileAssemblyEvaluation(
            selectedTiles: selectedTiles,
            expectedTiles: exercise.expectedTiles,
            isCorrect: isCorrect,
            score: score,
            feedback: exercise.feedback
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

        let isCorrect = selectedTiles == exercise.expectedTiles
        let score = isCorrect ? scoring.correctPoints : scoring.incorrectPoints

        return LKTileAssemblyEvaluation(
            selectedTiles: selectedTiles,
            expectedTiles: exercise.expectedTiles,
            isCorrect: isCorrect,
            score: score,
            feedback: exercise.feedback
        )
    }
}
