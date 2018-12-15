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
    ],
    targets: [
        .target(
            name: "Reader",
            dependencies: []),
        .testTarget(
            name: "ReaderTests",
            dependencies: ["Reader"]),
    ]
)
