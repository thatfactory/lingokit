import Foundation
import Testing
@testable import LingoKit

private struct StubExercise: LKIntentClassificationExerciseType {
    let id: UUID
    let prompt: String
    let intents: [String]
    let expectedIntent: String
    let feedback: String?
}

private func evaluateViaProtocol<Exercise: LKIntentClassificationExerciseType>(
    exercise: Exercise,
    selectedIntent: Exercise.Intent
) -> LKIntentClassificationEvaluation<Exercise.Intent> {
    LKIntentClassificationEvaluator.evaluate(
        exercise: exercise,
        selectedIntent: selectedIntent
    )
}

@Test func returnsCorrectEvaluationWithStandardScore() {
    // Given
    let exercise = LKIntentClassificationExercise(
        prompt: "Wie heißen sie?",
        intents: ["Name", "Age", "Address"],
        expectedIntent: "Name",
        feedback: "Richtig!"
    )

    // When
    let evaluation = exercise.evaluate(selectedIntent: "Name")

    // Then
    #expect(evaluation.isCorrect)
    #expect(evaluation.score == 10)
    #expect(evaluation.expectedIntent == "Name")
    #expect(evaluation.selectedIntent == "Name")
    #expect(evaluation.feedback == "Richtig!")
}

@Test func returnsIncorrectEvaluationWithStandardScore() {
    // Given
    let exercise = LKIntentClassificationExercise(
        prompt: "Wie heißen sie?",
        intents: ["Name", "Age", "Address"],
        expectedIntent: "Name"
    )

    // When
    let evaluation = exercise.evaluate(selectedIntent: "Age")

    // Then
    #expect(!evaluation.isCorrect)
    #expect(evaluation.score == 0)
    #expect(evaluation.expectedIntent == "Name")
    #expect(evaluation.selectedIntent == "Age")
}

@Test func supportsCustomScoringPolicy() {
    // Given
    let exercise = LKIntentClassificationExercise(
        prompt: "Wie heißen sie?",
        intents: ["Name", "Age", "Address"],
        expectedIntent: "Name"
    )
    let scoring = LKIntentClassificationScoring(
        correctPoints: 3,
        incorrectPoints: -1
    )

    // When
    let correctEvaluation = exercise.evaluate(
        selectedIntent: "Name",
        scoring: scoring
    )
    let incorrectEvaluation = exercise.evaluate(
        selectedIntent: "Address",
        scoring: scoring
    )

    // Then
    #expect(correctEvaluation.score == 3)
    #expect(incorrectEvaluation.score == -1)
}

@Test func evaluatorAndExerciseApiProduceSameResult() {
    // Given
    let exercise = LKIntentClassificationExercise(
        prompt: "Wie heißen sie?",
        intents: ["Name", "Age", "Address"],
        expectedIntent: "Name"
    )

    // When
    let exerciseEvaluation = exercise.evaluate(selectedIntent: "Name")
    let evaluatorEvaluation = LKIntentClassificationEvaluator.evaluate(
        exercise: exercise,
        selectedIntent: "Name"
    )

    // Then
    #expect(exerciseEvaluation.isCorrect == evaluatorEvaluation.isCorrect)
    #expect(exerciseEvaluation.score == evaluatorEvaluation.score)
    #expect(exerciseEvaluation.expectedIntent == evaluatorEvaluation.expectedIntent)
    #expect(exerciseEvaluation.selectedIntent == evaluatorEvaluation.selectedIntent)
}

@Test func protocolBasedAndConcreteEvaluatorProduceSameResult() {
    // Given
    let exercise = LKIntentClassificationExercise(
        id: UUID(uuidString: "D8E4D4FB-7D8B-4D6A-9F4B-4CF8A59543B1")!,
        prompt: "Wie heißen sie?",
        intents: ["Name", "Age", "Address"],
        expectedIntent: "Name"
    )

    // When
    let concreteEvaluation = LKIntentClassificationEvaluator.evaluate(
        exercise: exercise,
        selectedIntent: "Age"
    )
    let protocolEvaluation = evaluateViaProtocol(
        exercise: exercise,
        selectedIntent: "Age"
    )

    // Then
    #expect(concreteEvaluation.isCorrect == protocolEvaluation.isCorrect)
    #expect(concreteEvaluation.score == protocolEvaluation.score)
    #expect(concreteEvaluation.expectedIntent == protocolEvaluation.expectedIntent)
    #expect(concreteEvaluation.selectedIntent == protocolEvaluation.selectedIntent)
}

@Test func customExerciseConformingToProtocolCanBeEvaluated() {
    // Given
    let exercise = StubExercise(
        id: UUID(uuidString: "6D2F6A59-C1A9-4D6B-B9B2-2416D53D0A70")!,
        prompt: "Wie heißen sie?",
        intents: ["Name", "Age", "Address"],
        expectedIntent: "Name",
        feedback: "Richtig!"
    )

    // When
    let evaluation = LKIntentClassificationEvaluator.evaluate(
        exercise: exercise,
        selectedIntent: "Name"
    )

    // Then
    #expect(evaluation.isCorrect)
    #expect(evaluation.score == 10)
    #expect(evaluation.expectedIntent == "Name")
    #expect(evaluation.selectedIntent == "Name")
    #expect(evaluation.feedback == "Richtig!")
}

@Test func exerciseAndEvaluationSupportEquatableComparison() {
    // Given
    let exercise = LKIntentClassificationExercise(
        id: UUID(uuidString: "04D1C4F6-77D6-4BCE-A85D-225105951F4B")!,
        prompt: "Wie heißen sie?",
        intents: ["Name", "Age", "Address"],
        expectedIntent: "Name",
        feedback: "Richtig!"
    )

    // When
    let matchingExercise = LKIntentClassificationExercise(
        id: UUID(uuidString: "04D1C4F6-77D6-4BCE-A85D-225105951F4B")!,
        prompt: "Wie heißen sie?",
        intents: ["Name", "Age", "Address"],
        expectedIntent: "Name",
        feedback: "Richtig!"
    )
    let evaluationOne = exercise.evaluate(selectedIntent: "Name")
    let evaluationTwo = exercise.evaluate(selectedIntent: "Name")

    // Then
    #expect(exercise == matchingExercise)
    #expect(evaluationOne == evaluationTwo)
    #expect(LKIntentClassificationScoring.standard == LKIntentClassificationScoring.standard)
}
