// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Reader",
    products: [
        .library(name: "Reader", targets: ["Reader"]),
    ],
    dependencies: [
        .package(url: "https://github.com/typelift/SwiftCheck.git", from: "0.11.0"),
        .package(url: "https://github.com/orta/Komondor.git", from: "1.0.1"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat.git", from: "0.37.1"),
    ],
    targets: [
        .target(name: "Reader", dependencies: []),
        .testTarget(name: "ReaderTests", dependencies: ["Reader", "SwiftCheck"]),
    ]
)

// git-hooks via Komondor
#if canImport(PackageConfig)
    import PackageConfig

    let config = PackageConfig([
        "komondor": [
            "pre-commit": [
                "swift run swiftformat .",
                "git add .",
            ],
        ],
    ])
#endif
