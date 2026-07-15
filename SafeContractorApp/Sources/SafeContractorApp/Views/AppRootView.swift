import SwiftUI

private enum LaunchStage {
    case loading
    case onboarding
    case signIn
}

/// Drives the app's outermost flow: Loading → Onboarding → Sign In → the signed-in tab shell,
/// matching the "All users" → "Employee" section order in the Figma file.
public struct AppRootView: View {
    @EnvironmentObject private var store: AppStore
    @State private var stage: LaunchStage = .loading

    public init() {}

    public var body: some View {
        if store.isSignedIn {
            RootTabView()
        } else {
            switch stage {
            case .loading:
                LoadingView { stage = .onboarding }
            case .onboarding:
                OnboardingView { stage = .signIn }
            case .signIn:
                SignInView()
            }
        }
    }
}
