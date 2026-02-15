// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "LingoKit",
    platforms: [
        .iOS(.v26),
        .macOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26)
    ],
    products: [
        .library(
            name: "LingoKit",
            targets: ["LingoKit"]
        ),
        .library(
            name: "LingoKitIntentClassification",
            targets: ["LingoKitIntentClassification"]
        )
    ],
    targets: [
        .target(
            name: "LingoKit",
            dependencies: ["LingoKitIntentClassification"]
        ),
        .target(
            name: "LingoKitIntentClassification"
        ),
        .testTarget(
            name: "LingoKitTests",
            dependencies: ["LingoKit"]
        ),
        .testTarget(
            name: "LingoKitIntentClassificationTests",
            dependencies: ["LingoKitIntentClassification"]
        )
    ]
)
