import Foundation

/// Result of evaluating a tile-assembly answer.
public struct LKTileAssemblyEvaluation<Tile: Hashable & Codable & Sendable>: Codable, Sendable, Equatable {
    /// The tile sequence selected by the user.
    public let selectedTiles: [Tile]
    /// The expected correct tile sequence.
    public let expectedTiles: [Tile]
    /// Indicates whether the selected sequence matches the expected sequence.
    public let isCorrect: Bool
    /// The computed score based on the selected scoring policy.
    public let score: Int
    /// Optional feedback associated with the exercise.
    public let feedback: String?

    /// Creates a new evaluation result.
    ///
    /// - Parameters:
    ///   - selectedTiles: The tile sequence selected by the user.
    ///   - expectedTiles: The expected correct tile sequence.
    ///   - isCorrect: Whether the answer is correct.
    ///   - score: The computed score for this answer.
    ///   - feedback: Optional feedback associated with the exercise.
    public init(
        selectedTiles: [Tile],
        expectedTiles: [Tile],
        isCorrect: Bool,
        score: Int,
        feedback: String?
    ) {
        self.selectedTiles = selectedTiles
        self.expectedTiles = expectedTiles
        self.isCorrect = isCorrect
        self.score = score
        self.feedback = feedback
    }
}
