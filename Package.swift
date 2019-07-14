// swift-tools-version:4.0
import PackageDescription

var package = Package(
    name: "MongoKitten",
    products: [
        .library(name: "MongoKitten", targets: ["MongoKitten"]),
    ],
    dependencies: [
        // For MongoDB Documents
        .package(url: "https://github.com/GregPerez83/BSON.git", .upToNextMinor(from: "5.3.0")),

        // For ExtendedJSON support
        .package(url: "https://github.com/GregPerez83/Cheetah.git", .upToNextMinor(from: "2.1.0")),

        // Authentication
        .package(url: "https://github.com/GregPerez83/CryptoKitten.git", .upToNextMinor(from: "0.3.0")),

        // Asynchronous behaviour
        .package(url: "https://github.com/GregPerez83/Schrodinger.git", .upToNextMinor(from: "1.1.0")),
    ],
    targets: [
        .target(name: "GeoJSON", dependencies: ["BSON"]),
        .target(name: "MongoSocket", dependencies: []),
        .target(name: "ExtendedJSON", dependencies: ["GeoJSON", "Cheetah", "CryptoKitten"]),
        .target(name: "MongoKitten", dependencies: ["BSON", "GeoJSON", "MongoSocket", "ExtendedJSON", "Schrodinger"])
        ]

)

// Provides Sockets + SSL
#if !os(macOS) && !os(iOS)
package.dependencies.append(.Package(url: "https://github.com/OpenKitten/KittenCTLS.git", majorVersion: 1))
#endif
