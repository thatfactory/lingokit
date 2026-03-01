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
