import SwiftUI

/// The "Settings page row" list linking to the four Settings subpages in the Figma file.
public struct SettingsView: View {
    public init() {}

    public var body: some View {
        List {
            NavigationLink("Edit Profile", value: SettingsRoute.editProfile)
            NavigationLink("Change Password", value: SettingsRoute.changePassword)
            NavigationLink("Company Name", value: SettingsRoute.companyName)
            NavigationLink("About", value: SettingsRoute.about)
        }
        .navigationTitle("Settings")
        .navigationDestination(for: SettingsRoute.self) { route in
            switch route {
            case .editProfile: EditProfileView()
            case .changePassword: ChangePasswordView()
            case .companyName: CompanyNameView()
            case .about: SettingsAboutView()
            }
        }
    }
}

enum SettingsRoute: Hashable {
    case editProfile
    case changePassword
    case companyName
    case about
}
