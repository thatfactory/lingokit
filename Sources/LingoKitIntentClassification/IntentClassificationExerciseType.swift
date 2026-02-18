import Foundation

/// A protocol describing the data required to evaluate an intent-classification exercise.
public protocol IntentClassificationExerciseType: Codable, Sendable {
    /// The type of intents available in this exercise.
    associatedtype Intent: Hashable & Codable & Sendable

    /// A unique identifier for this exercise.
    var id: UUID { get }

    /// The prompt shown to the learner.
    var prompt: String { get }

    /// Candidate intents the learner can choose from.
    var intents: [Intent] { get }

    /// The expected correct intent.
    var expectedIntent: Intent { get }

    /// Optional feedback associated with this exercise.
    var feedback: String? { get }
}
