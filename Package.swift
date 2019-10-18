// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "ActionKit",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(name: "ActionKit", targets: ["ActionKit"])
    ],
    dependencies: [
        // no dependencies
    ],
    targets: [
        .target(name: "ActionKit", dependencies: [], path: "ActionKit"),
        .testTarget(name: "ActionKitTests", dependencies: ["ActionKit"], path: "ActionKitTests")
    ]
)
