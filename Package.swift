// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Generator",
    products: [
        .executable(name: "codegen", targets: ["GeneratorCLI"]),
        .library(name: "Generator", targets: ["Generator"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.1.4"),
        .package(url: "https://github.com/jpsim/Yams", from: "5.0.0"),
        .package(url: "https://github.com/kylef/PathKit", from: "1.0.0"),
        .package(url: "https://github.com/SwiftGen/StencilSwiftKit", from: "2.0.0"),
        .package(url: "https://github.com/stencilproject/Stencil.git", from: "0.15.0"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.49.0"),
    ],
    targets: [
        .executableTarget(
            name: "GeneratorCLI",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Generator"
            ]
        ),
        .target(
            name: "Generator",
            dependencies: [
                "Yams",
                "PathKit",
                "StencilSwiftKit",
                "Stencil",
                "SwiftFormat"
            ]
        ),
        .testTarget(
            name: "GeneratorTests",
            dependencies: ["Generator"]
        ),
    ]
)
