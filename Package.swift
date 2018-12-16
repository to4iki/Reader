// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Reader",
    products: [
        .library(
            name: "Reader",
            targets: ["Reader"]),
    ],
    dependencies: [
        .package(url: "https://github.com/typelift/SwiftCheck.git", from: "0.11.0")
    ],
    targets: [
        .target(
            name: "Reader",
            dependencies: []),
        .testTarget(
            name: "ReaderTests",
            dependencies: ["Reader", "SwiftCheck"]),
    ]
)
