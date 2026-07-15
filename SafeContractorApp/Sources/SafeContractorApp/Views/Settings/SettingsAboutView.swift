import SwiftUI

/// Transcribed from "Settings / About": a row list, no field content was legible in the source
/// frame, so standard about-page rows are used here.
public struct SettingsAboutView: View {
    public init() {}

    public var body: some View {
        List {
            LabeledContent("Version", value: "2.6.0 (198)")
            NavigationLink("Terms and Conditions") { EmptyView() }
            NavigationLink("Privacy Policy") { EmptyView() }
            NavigationLink("Licenses") { EmptyView() }
        }
        .navigationTitle("About")
    }
}
