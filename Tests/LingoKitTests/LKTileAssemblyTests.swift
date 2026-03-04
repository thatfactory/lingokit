import Foundation
import Testing
@testable import LingoKit

private struct StubTileExercise: LKTileAssemblyExerciseType {
    let id: UUID
    let prompt: String
    let availableTiles: [String]
    let expectedTiles: [String]
    let feedback: String?
}

private func evaluateViaProtocol<Exercise: LKTileAssemblyExerciseType>(
    exercise: Exercise,
    selectedTiles: [Exercise.Tile]
) -> LKTileAssemblyEvaluation<Exercise.Tile> {
    LKTileAssemblyEvaluator.evaluate(
        exercise: exercise,
        selectedTiles: selectedTiles
    )
}

@Test func tileAssemblyReturnsCorrectEvaluationWithStandardScore() {
    // Given
    let exercise = LKTileAssemblyExercise(
        prompt: "Build the sentence.",
        availableTiles: ["Wie", "heißen", "Sie", "?"],
        expectedTiles: ["Wie", "heißen", "Sie", "?"],
        feedback: "Richtig!"
    )

    // When
    let evaluation = exercise.evaluate(
        selectedTiles: ["Wie", "heißen", "Sie", "?"]
    )

    // Then
    #expect(evaluation.isCorrect)
    #expect(evaluation.score == 10)
    #expect(evaluation.expectedTiles == ["Wie", "heißen", "Sie", "?"])
    #expect(evaluation.selectedTiles == ["Wie", "heißen", "Sie", "?"])
    #expect(evaluation.feedback == "Richtig!")
}

@Test func tileAssemblyReturnsIncorrectEvaluationWithStandardScore() {
    // Given
    let exercise = LKTileAssemblyExercise(
        prompt: "Build the sentence.",
        availableTiles: ["Wie", "heißen", "Sie", "?"],
        expectedTiles: ["Wie", "heißen", "Sie", "?"]
    )

    // When
    let evaluation = exercise.evaluate(
        selectedTiles: ["Sie", "heißen", "Wie", "?"]
    )

    // Then
    #expect(!evaluation.isCorrect)
    #expect(evaluation.score == 0)
    #expect(evaluation.expectedTiles == ["Wie", "heißen", "Sie", "?"])
    #expect(evaluation.selectedTiles == ["Sie", "heißen", "Wie", "?"])
}

@Test func tileAssemblySupportsCustomScoringPolicy() {
    // Given
    let exercise = LKTileAssemblyExercise(
        prompt: "Build the sentence.",
        availableTiles: ["Wie", "heißen", "Sie", "?"],
        expectedTiles: ["Wie", "heißen", "Sie", "?"]
    )
    let scoring = LKTileAssemblyScoring(
        correctPoints: 3,
        incorrectPoints: -1
    )

    // When
    let correctEvaluation = exercise.evaluate(
        selectedTiles: ["Wie", "heißen", "Sie", "?"],
        scoring: scoring
    )
    let incorrectEvaluation = exercise.evaluate(
        selectedTiles: ["Sie", "heißen", "Wie", "?"],
        scoring: scoring
    )

    // Then
    #expect(correctEvaluation.score == 3)
    #expect(incorrectEvaluation.score == -1)
}

@Test func tileAssemblyEvaluatorAndExerciseApiProduceSameResult() {
    // Given
    let exercise = LKTileAssemblyExercise(
        prompt: "Build the sentence.",
        availableTiles: ["Wie", "heißen", "Sie", "?"],
        expectedTiles: ["Wie", "heißen", "Sie", "?"]
    )

    // When
    let exerciseEvaluation = exercise.evaluate(
        selectedTiles: ["Wie", "heißen", "Sie", "?"]
    )
    let evaluatorEvaluation = LKTileAssemblyEvaluator.evaluate(
        exercise: exercise,
        selectedTiles: ["Wie", "heißen", "Sie", "?"]
    )

    // Then
    #expect(exerciseEvaluation.isCorrect == evaluatorEvaluation.isCorrect)
    #expect(exerciseEvaluation.score == evaluatorEvaluation.score)
    #expect(exerciseEvaluation.expectedTiles == evaluatorEvaluation.expectedTiles)
    #expect(exerciseEvaluation.selectedTiles == evaluatorEvaluation.selectedTiles)
}

@Test func tileAssemblyProtocolBasedAndConcreteEvaluatorProduceSameResult() {
    // Given
    let exercise = LKTileAssemblyExercise(
        id: UUID(uuidString: "D8E4D4FB-7D8B-4D6A-9F4B-4CF8A59543B1")!,
        prompt: "Build the sentence.",
        availableTiles: ["Wie", "heißen", "Sie", "?"],
        expectedTiles: ["Wie", "heißen", "Sie", "?"]
    )

    // When
    let concreteEvaluation = LKTileAssemblyEvaluator.evaluate(
        exercise: exercise,
        selectedTiles: ["Sie", "heißen", "Wie", "?"]
    )
    let protocolEvaluation = evaluateViaProtocol(
        exercise: exercise,
        selectedTiles: ["Sie", "heißen", "Wie", "?"]
    )

    // Then
    #expect(concreteEvaluation.isCorrect == protocolEvaluation.isCorrect)
    #expect(concreteEvaluation.score == protocolEvaluation.score)
    #expect(concreteEvaluation.expectedTiles == protocolEvaluation.expectedTiles)
    #expect(concreteEvaluation.selectedTiles == protocolEvaluation.selectedTiles)
}

@Test func tileAssemblyCustomExerciseConformingToProtocolCanBeEvaluated() {
    // Given
    let exercise = StubTileExercise(
        id: UUID(uuidString: "6D2F6A59-C1A9-4D6B-B9B2-2416D53D0A70")!,
        prompt: "Build the sentence.",
        availableTiles: ["Wie", "heißen", "Sie", "?"],
        expectedTiles: ["Wie", "heißen", "Sie", "?"],
        feedback: "Richtig!"
    )

    // When
    let evaluation = LKTileAssemblyEvaluator.evaluate(
        exercise: exercise,
        selectedTiles: ["Wie", "heißen", "Sie", "?"]
    )

    // Then
    #expect(evaluation.isCorrect)
    #expect(evaluation.score == 10)
    #expect(evaluation.expectedTiles == ["Wie", "heißen", "Sie", "?"])
    #expect(evaluation.selectedTiles == ["Wie", "heißen", "Sie", "?"])
    #expect(evaluation.feedback == "Richtig!")
}

@Test func tileAssemblyExerciseAndEvaluationSupportEquatableComparison() {
    // Given
    let exercise = LKTileAssemblyExercise(
        id: UUID(uuidString: "04D1C4F6-77D6-4BCE-A85D-225105951F4B")!,
        prompt: "Build the sentence.",
        availableTiles: ["Wie", "heißen", "Sie", "?"],
        expectedTiles: ["Wie", "heißen", "Sie", "?"],
        feedback: "Richtig!"
    )

    // When
    let matchingExercise = LKTileAssemblyExercise(
        id: UUID(uuidString: "04D1C4F6-77D6-4BCE-A85D-225105951F4B")!,
        prompt: "Build the sentence.",
        availableTiles: ["Wie", "heißen", "Sie", "?"],
        expectedTiles: ["Wie", "heißen", "Sie", "?"],
        feedback: "Richtig!"
    )
    let evaluationOne = exercise.evaluate(
        selectedTiles: ["Wie", "heißen", "Sie", "?"]
    )
    let evaluationTwo = exercise.evaluate(
        selectedTiles: ["Wie", "heißen", "Sie", "?"]
    )

    // Then
    #expect(exercise == matchingExercise)
    #expect(evaluationOne == evaluationTwo)
    #expect(LKTileAssemblyScoring.standard == LKTileAssemblyScoring.standard)
}
