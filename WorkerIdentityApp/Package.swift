// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "WorkerIdentityApp",
    platforms: [
        // iOS is the target deployment platform for this app.
        // macOS is also declared so `swift build`/`swift test` can run locally without Xcode/Simulator.
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "WorkerIdentityApp",
            targets: ["WorkerIdentityApp"]
        ),
        .executable(
            name: "WorkerIdentityAppRunner",
            targets: ["WorkerIdentityAppRunner"]
        )
    ],
    dependencies: [
        .package(path: "..")
    ],
    targets: [
        // All models, store, access control, and views — no entry point, so it links cleanly
        // into both the test target and the runner below.
        .target(
            name: "WorkerIdentityApp",
            dependencies: [
                .product(name: "SwiftUIX", package: "swift_design_system")
            ]
        ),
        // Thin `@main App` wrapper. Split into its own executable target because a `@main` type
        // inside the library target collides with SwiftPM's generated test-runner `main` at link
        // time. On macOS this is runnable via `swift run WorkerIdentityAppRunner`; the real iOS
        // target still requires opening this package in Xcode and picking a Simulator.
        .executableTarget(
            name: "WorkerIdentityAppRunner",
            dependencies: ["WorkerIdentityApp"]
        ),
        .testTarget(
            name: "WorkerIdentityAppTests",
            dependencies: ["WorkerIdentityApp"]
        )
    ]
)
