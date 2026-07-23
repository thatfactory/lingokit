import AppLogger
import Foundation
import Testing
@testable import LingoKit

@Suite struct LKLoggingTests {
    @Test func intentClassificationLogsOnePackageOwnedOutcome() throws {
        // Given
        let recorder = LKLogRecorder()
        let exercise = LKIntentClassificationExercise(
            prompt: "Sensitive prompt",
            intents: ["Expected", "Selected"],
            expectedIntent: "Expected",
            feedback: "Sensitive feedback"
        )

        // When
        LKLogging.$sink.withValue(recorder.record) {
            _ = exercise.evaluate(selectedIntent: "Selected")
        }

        // Then
        let entry = try #require(recorder.entries.first)
        #expect(recorder.entries.count == 1)
        #expect(entry.category == .evaluation)
        #expect(!entry.isPrivate)
        #expect(entry.message == "📚 evaluate | type=intentClassification, correct=false, score=0")
        #expect(LKLogging.subsystem == "com.thatfactory.lingokit")
        expectDebug(entry.level)
    }

    @Test func tileAssemblyLogsOnePackageOwnedOutcome() throws {
        // Given
        let recorder = LKLogRecorder()
        let exercise = LKTileAssemblyExercise(
            prompt: "Sensitive prompt",
            availableTiles: ["Expected", "Selected"],
            expectedTiles: ["Expected"],
            feedback: "Sensitive feedback"
        )

        // When
        LKLogging.$sink.withValue(recorder.record) {
            _ = exercise.evaluate(selectedTiles: ["Expected"])
        }

        // Then
        let entry = try #require(recorder.entries.first)
        #expect(recorder.entries.count == 1)
        #expect(entry.category == .evaluation)
        #expect(!entry.isPrivate)
        #expect(entry.message == "📚 evaluate | type=tileAssembly, correct=true, score=10")
        #expect(LKLogging.subsystem == "com.thatfactory.lingokit")
        expectDebug(entry.level)
    }
}

// MARK: - Private

private func expectDebug(
    _ level: AppLogLevel,
    sourceLocation: SourceLocation = #_sourceLocation
) {
    guard case .debug = level else {
        Issue.record(
            "Expected a debug log level.",
            sourceLocation: sourceLocation
        )
        return
    }
}

/// Records LingoKit log entries emitted during a test.
private final class LKLogRecorder: @unchecked Sendable {
    private var internalEntries: [LKRecordedLog] = []
    private let lock = NSLock()

    var entries: [LKRecordedLog] {
        lock.lock()
        defer {
            lock.unlock()
        }
        return internalEntries
    }

    func record(
        _ level: AppLogLevel,
        _ category: LKLogCategory,
        _ message: String,
        _ isPrivate: Bool
    ) {
        lock.lock()
        defer {
            lock.unlock()
        }
        internalEntries.append(
            LKRecordedLog(
                level: level,
                category: category,
                message: message,
                isPrivate: isPrivate
            )
        )
    }
}

private struct LKRecordedLog {
    let level: AppLogLevel
    let category: LKLogCategory
    let message: String
    let isPrivate: Bool
}
