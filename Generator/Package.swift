// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Generator",
    products: [
        .library(name: "Generator", targets: ["Generator"]),
    ],
    dependencies: [
        .package(url: "https://github.com/jpsim/Yams", from: "4.0.0"),
        .package(url: "https://github.com/kylef/PathKit", from: "1.0.0"),
        .package(url: "https://github.com/SwiftGen/StencilSwiftKit", from: "2.0.0"),
        .package(url: "https://github.com/stencilproject/Stencil.git", from: "0.15.1"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.9.6"),
    ],
    targets: [
        .target(name: "Generator", dependencies: ["Yams", "PathKit", "StencilSwiftKit", "Stencil", "SwiftFormat"]),
        .testTarget(name: "GeneratorTests", dependencies: ["Generator"]),
    ]
)
