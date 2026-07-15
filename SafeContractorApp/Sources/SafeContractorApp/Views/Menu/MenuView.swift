import SwiftUI

/// Transcribed from "Menu": profile photo/name/email with an "Edit profile" link, a "Switch to
/// Manager view" button, then grouped rows for the screens that don't get their own tab slot
/// (My File, Notifications, Settings), and an app version footer.
public struct MenuView: View {
    @EnvironmentObject private var store: AppStore

    public init() {}

    public var body: some View {
        List {
            Section {
                HStack(spacing: SCSpacing.standard) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 56, height: 56)
                        .foregroundStyle(SCColor.textTertiary)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(store.profile.fullName)
                            .font(SCTypography.h5)
                        Text(store.profile.email)
                            .font(SCTypography.subtitle2)
                            .foregroundStyle(SCColor.textSecondary)
                        NavigationLink("Edit profile", value: SettingsRoute.editProfile)
                            .font(SCTypography.caption)
                    }
                }
                .padding(.vertical, SCSpacing.tight)

                Button("Switch to Manager view") { }
                    .buttonStyle(.borderedProminent)
                    .tint(SCColor.primary)
                    .frame(maxWidth: .infinity)
            }
            .listRowSeparator(.hidden)

            Section {
                NavigationLink(value: MenuRoute.myFile) { Label("My File", systemImage: "folder.fill") }
                NavigationLink(value: MenuRoute.notifications) { Label("Notifications", systemImage: "bell.fill") }
            }

            Section {
                NavigationLink(value: MenuRoute.settings) { Label("Settings", systemImage: "gearshape.fill") }
            }

            Section {
                Button(role: .destructive) {
                    store.isSignedIn = false
                } label: {
                    Label("Sign out", systemImage: "rectangle.portrait.and.arrow.right")
                }
            }

            Section {
                Text("v 2.6.0 (198)")
                    .font(SCTypography.caption)
                    .foregroundStyle(SCColor.textSecondary)
            }
            .listRowSeparator(.hidden)
        }
        .navigationTitle("Menu")
        .navigationDestination(for: SettingsRoute.self) { route in
            switch route {
            case .editProfile: EditProfileView()
            case .changePassword: ChangePasswordView()
            case .companyName: CompanyNameView()
            case .about: SettingsAboutView()
            }
        }
        .navigationDestination(for: MenuRoute.self) { route in
            switch route {
            case .myFile: MyFileView()
            case .notifications: NotificationsView()
            case .settings: SettingsView()
            }
        }
    }
}

enum MenuRoute: Hashable {
    case myFile
    case notifications
    case settings
}
