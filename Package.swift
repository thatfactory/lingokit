// swift-tools-version:6.4

import PackageDescription

let strictSwiftSettings: [SwiftSetting] = [
    .treatAllWarnings(as: .error),
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("InferIsolatedConformances"),
    .enableUpcomingFeature("InternalImportsByDefault"),
    .enableUpcomingFeature("MemberImportVisibility"),
    .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
]

let package = Package(
    name: "LingoKit",
    platforms: [
        .iOS(.v26),
        .macOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
    ],
    products: [
        .library(
            name: "LingoKit",
            targets: ["LingoKit"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/thatfactory/applogger", from: "1.1.0"),
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.4.5"),
    ],
    targets: [
        .target(
            name: "LingoKit",
            dependencies: [
                .product(
                    name: "AppLogger",
                    package: "applogger"
                )
            ]
        ),
        .testTarget(
            name: "LingoKitTests",
            dependencies: [
                "LingoKit",
                .product(
                    name: "AppLogger",
                    package: "applogger"
                ),
            ]
        ),
    ]
)

package.swiftLanguageModes = [.v6]

for target in package.targets {
    target.swiftSettings = strictSwiftSettings
}
