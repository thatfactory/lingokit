import Testing
@testable import LingoKit

@Test func exposesIntentClassificationFromSingleModule() {
    // Given
    let exercise = LKIntentClassificationExercise(
        prompt: "Wie heißen sie?",
        intents: ["Name", "Age", "Address"],
        expectedIntent: "Name"
    )

    // When
    let evaluation = exercise.evaluate(selectedIntent: "Name")

    // Then
    #expect(evaluation.isCorrect)
    #expect(evaluation.score == 10)
}

@Test func exposesExerciseType() {
    // Given
    let exercise = LKIntentClassificationExercise(
        prompt: "Wie heißen sie?",
        intents: ["Name", "Age", "Address"],
        expectedIntent: "Name"
    )

    // When
    let exerciseType = exercise.exerciseType

    // Then
    #expect(exerciseType == .intentClassification)
}
