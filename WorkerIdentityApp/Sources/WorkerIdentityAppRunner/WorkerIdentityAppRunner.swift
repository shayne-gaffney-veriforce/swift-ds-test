import SwiftUI
import WorkerIdentityApp

@main
struct WorkerIdentityAppRunner: App {
    @StateObject private var store = WorkerDirectoryStore.seeded()

    public init() {}

    public var body: some Scene {
        WindowGroup {
            RoleSwitcherView()
                .environmentObject(store)
                .tint(VeriforceColor.primary)
        }
    }
}
