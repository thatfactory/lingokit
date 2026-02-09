// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "LingoKit",
    products: [
        .library(
            name: "LingoKit",
            targets: ["LingoKit"]
        ),
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
