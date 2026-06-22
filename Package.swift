// swift-tools-version:6.4

import PackageDescription

let package = Package(
    name: "LingoKit",
    platforms: [
        .iOS(.v27),
        .macOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27)
    ],
    products: [
        .library(
            name: "LingoKit",
            targets: ["LingoKit"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.4.5")
    ],
    targets: [
        .target(
            name: "LingoKit"
        ),
        .testTarget(
            name: "LingoKitTests",
            dependencies: ["LingoKit"]
        )
    ]
)
