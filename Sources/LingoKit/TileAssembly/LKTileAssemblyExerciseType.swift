import Foundation

/// A protocol describing the data required to evaluate a tile-assembly exercise.
public protocol LKTileAssemblyExerciseType: Codable, Sendable {
    /// The tile element type used by this exercise.
    associatedtype Tile: Hashable & Codable & Sendable

    /// A unique identifier for this exercise.
    var id: UUID { get }

    /// The prompt shown to the learner.
    var prompt: String { get }

    /// The tiles available to assemble an answer.
    var availableTiles: [Tile] { get }

    /// The expected tile sequence for a correct answer.
    var expectedTiles: [Tile] { get }

    /// Optional feedback associated with this exercise.
    var feedback: String? { get }
}

public extension LKTileAssemblyExerciseType {
    /// The taxonomy exercise type represented by this exercise protocol.
    var exerciseType: LKExerciseType {
        .tileAssembly
    }
}
