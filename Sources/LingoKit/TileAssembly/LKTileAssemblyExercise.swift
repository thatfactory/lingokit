import Foundation

/// A UI-agnostic tile-assembly exercise definition.
///
/// Use this type to define the prompt, available tiles, expected tile order,
/// and optional feedback for a single exercise round.
public struct LKTileAssemblyExercise<Tile: Hashable & Codable & Sendable>: LKTileAssemblyExerciseType, Equatable {
    /// A unique identifier for the exercise instance.
    public let id: UUID
    /// The exercise prompt presented to the user.
    public let prompt: String
    /// The tiles available for assembly.
    public let availableTiles: [Tile]
    /// The expected tile sequence for a correct answer.
    public let expectedTiles: [Tile]
    /// Optional feedback returned as part of the evaluation.
    public let feedback: String?

    /// Creates a new tile-assembly exercise.
    ///
    /// - Parameters:
    ///   - id: A unique identifier for the exercise.
    ///   - prompt: The prompt shown to the user.
    ///   - availableTiles: The constrained tile set shown to the user.
    ///   - expectedTiles: The expected tile sequence for a correct answer.
    ///   - feedback: Optional feedback to return in the evaluation result.
    public init(
        id: UUID = UUID(),
        prompt: String,
        availableTiles: [Tile],
        expectedTiles: [Tile],
        feedback: String? = nil
    ) {
        self.id = id
        self.prompt = prompt
        self.availableTiles = availableTiles
        self.expectedTiles = expectedTiles
        self.feedback = feedback
    }

    /// Evaluates a selected tile sequence and returns the scoring result.
    ///
    /// - Parameters:
    ///   - selectedTiles: The tile sequence selected by the user.
    ///   - scoring: The scoring policy used to compute the final score.
    /// - Returns: The evaluation result containing correctness and score.
    public func evaluate(
        selectedTiles: [Tile],
        scoring: LKTileAssemblyScoring = .standard
    ) -> LKTileAssemblyEvaluation<Tile> {
        LKTileAssemblyEvaluator.evaluate(
            exercise: self,
            selectedTiles: selectedTiles,
            scoring: scoring
        )
    }
}
