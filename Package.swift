// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SamplePackageA",
    defaultLocalization: "en",
    platforms: [.iOS(.v14), .macOS(.v11), .tvOS(.v15), .watchOS(.v8)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SamplePackageA",
            targets: ["SamplePackageA"]),
        .library(
            name: "SamplePackageAConfig",
            targets: ["SamplePackageAConfig"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/kalub92/SamplePackageAInterface.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/kalub92/SamplePackageB-iOS.git",
            branch: "master"
        ),
        .package(
            url: "https://github.com/kalub92/SamplePackageB-macOS.git",
            branch: "master"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SamplePackageA",
            dependencies: [
                .product(
                    name: "SamplePackageB-iOS",
                    package: "SamplePackageB-iOS",
                    condition: .when(platforms: [.iOS])
                ),
                .product(
                    name: "ThirdPartyAdapter",
                    package: "SamplePackageB-iOS",
                    condition: .when(platforms: [.iOS])
                ),
                .product(
                    name: "SamplePackageB-macOS",
                    package: "SamplePackageB-macOS",
                    condition: .when(platforms: [.macOS])
                ),
                "SamplePackageAConfig"
            ],
            resources: [.process("Resources")]
        ),
        .target(
            name: "SamplePackageAConfig",
            dependencies: [
                .product(
                    name: "SamplePackageAInterface",
                    package: "SamplePackageAInterface"
                ),
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "SamplePackageATests",
            dependencies: ["SamplePackageA"]),
    ]
)
