import SwiftUI
import SafeContractorApp

@main
struct SafeContractorAppRunner: App {
    @StateObject private var store = AppStore.seeded()

    public init() {}

    public var body: some Scene {
        WindowGroup {
            AppRootView()
                .environmentObject(store)
                .tint(SCColor.primary)
        }
    }
}
