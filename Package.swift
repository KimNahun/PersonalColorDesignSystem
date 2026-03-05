// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PersonalColorDesignSystem",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "PersonalColorDesignSystem",
            targets: ["PersonalColorDesignSystem"]
        ),
    ],
    targets: [
        .target(
            name: "PersonalColorDesignSystem",
            path: "Sources/PersonalColorDesignSystem"
        ),
    ]
)
