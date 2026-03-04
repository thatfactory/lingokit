import Foundation

/// Identifies the exercise taxonomy category for an exercise engine.
public enum LKExerciseType: String, Codable, Sendable {
    /// Intent-classification exercises.
    case intentClassification
    /// Tile-assembly construction exercises.
    case tileAssembly
}
