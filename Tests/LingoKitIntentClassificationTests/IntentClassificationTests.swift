import Testing
@testable import LingoKitIntentClassification

@Test func returnsCorrectEvaluationWithStandardScore() {
    // Given
    let exercise = IntentClassificationExercise(
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
    let exercise = IntentClassificationExercise(
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
    let exercise = IntentClassificationExercise(
        prompt: "Wie heißen sie?",
        intents: ["Name", "Age", "Address"],
        expectedIntent: "Name"
    )
    let scoring = IntentClassificationScoring(
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
    let exercise = IntentClassificationExercise(
        prompt: "Wie heißen sie?",
        intents: ["Name", "Age", "Address"],
        expectedIntent: "Name"
    )

    // When
    let exerciseEvaluation = exercise.evaluate(selectedIntent: "Name")
    let evaluatorEvaluation = IntentClassificationEvaluator.evaluate(
        exercise: exercise,
        selectedIntent: "Name"
    )

    // Then
    #expect(exerciseEvaluation.isCorrect == evaluatorEvaluation.isCorrect)
    #expect(exerciseEvaluation.score == evaluatorEvaluation.score)
    #expect(exerciseEvaluation.expectedIntent == evaluatorEvaluation.expectedIntent)
    #expect(exerciseEvaluation.selectedIntent == evaluatorEvaluation.selectedIntent)
}
