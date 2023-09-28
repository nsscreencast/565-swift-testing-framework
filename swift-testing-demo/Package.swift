// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "swift-testing-demo",
    products: [
        .library(
            name: "swift-testing-demo",
            targets: ["swift-testing-demo"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-testing.git", branch: "main")
    ],
    targets: [
        .target(
            name: "swift-testing-demo"),
        .testTarget(
            name: "swift-testing-demoTests",
            dependencies: [
                .target(name: "swift-testing-demo"),
                .product(name: "Testing", package: "swift-testing")
            ]),
    ]
)
