import SwiftUI

/// The 5-item bottom tab bar — matches the "Tab bar" component's 5 icon slots. My File,
/// Notifications, and Settings live under Menu rather than getting their own tab slot.
public struct RootTabView: View {
    public init() {}

    public var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem { Label("Home", systemImage: "house.fill") }

            NavigationStack {
                TasksView()
            }
            .tabItem { Label("Tasks", systemImage: "checklist") }

            NavigationStack {
                GateAccessView()
            }
            .tabItem { Label("Gate Access", systemImage: "qrcode") }

            NavigationStack {
                ElearningListView()
            }
            .tabItem { Label("Elearning", systemImage: "graduationcap.fill") }

            NavigationStack {
                MenuView()
            }
            .tabItem { Label("Menu", systemImage: "line.3.horizontal") }
        }
        .tint(SCColor.primary)
    }
}
