// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SamplePackageA",
    defaultLocalization: "en",
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
                "SamplePackageAConfig"
            ],
            resources: [.process("Resources")],
            swiftSettings: [
                .define("BUILD_LIBRARY_FOR_DISTRIBUTION=YES")
            ]
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
