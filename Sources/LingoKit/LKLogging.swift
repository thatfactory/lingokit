import AppLogger

/// Routes LingoKit-owned diagnostics through the package logging identity.
enum LKLogging {
    typealias Sink = @Sendable (AppLogLevel, LKLogCategory, String, Bool) -> Void

    static let emoji = "📚"
    static let subsystem = "com.thatfactory.lingokit"

    @TaskLocal
    static var sink: Sink = { level, category, message, isPrivate in
        let logger = AppLogger(
            subsystem: subsystem,
            category: category.rawValue
        )
        logger.log(
            level: level,
            message,
            isPrivate: isPrivate
        )
    }

    static func logEvaluation(
        exerciseType: LKExerciseType,
        isCorrect: Bool,
        score: Int
    ) {
        sink(
            .debug,
            .evaluation,
            """
            \(emoji) evaluate | type=\(exerciseType.rawValue), \
            correct=\(isCorrect), score=\(score)
            """,
            false
        )
    }
}

/// Identifies stable diagnostic categories owned by LingoKit.
enum LKLogCategory: String, Sendable {
    case evaluation
}
