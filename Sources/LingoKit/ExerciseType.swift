import Foundation

/// Identifies the exercise taxonomy category for an exercise engine.
public enum ExerciseType: String, Codable, Sendable {
    /// Intent-classification exercises.
    case intentClassification
}
