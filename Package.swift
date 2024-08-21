// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "BitcoinCore",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "BitcoinCore",
            targets: ["BitcoinCore"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/attaswift/BigInt.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/Brightify/Cuckoo.git", .upToNextMajor(from: "1.5.0")),
        .package(url: "https://github.com/groue/GRDB.swift.git", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git", from: "10.0.0"),
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "5.0.1")),

        .package(url: "https://github.com/sunimp/Checkpoints.git", .upToNextMajor(from: "1.1.0")),
        .package(url: "https://github.com/sunimp/HDWalletKit.Swift.git", .upToNextMajor(from: "1.3.4")),
        .package(url: "https://github.com/sunimp/WWCryptoKit.Swift.git", .upToNextMajor(from: "1.3.4")),
        .package(url: "https://github.com/sunimp/WWExtensions.Swift.git", .upToNextMajor(from: "1.0.8")),
        .package(url: "https://github.com/sunimp/WWToolKit.Swift.git", .upToNextMajor(from: "2.0.7")),
    ],
    targets: [
        .target(
            name: "BitcoinCore",
            dependencies: [
                "BigInt",
                "Checkpoints",
                .product(name: "GRDB", package: "GRDB.swift"),
                .product(name: "HDWalletKit", package: "HDWalletKit.Swift"),
                .product(name: "WWCryptoKit", package: "WWCryptoKit.Swift"),
                .product(name: "WWExtensions", package: "WWExtensions.Swift"),
                .product(name: "WWToolKit", package: "WWToolKit.Swift"),
            ]
        ),
        .testTarget(
            name: "BitcoinCoreTests",
            dependencies: [
                "BitcoinCore",
                "Cuckoo",
                "Nimble",
                "Quick",
            ]
        ),
    ]
)
