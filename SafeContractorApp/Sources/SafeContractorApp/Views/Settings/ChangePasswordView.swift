import SwiftUI

/// Transcribed from "Settings / Change Password".
public struct ChangePasswordView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""

    public init() {}

    private var isValid: Bool {
        !currentPassword.isEmpty && !newPassword.isEmpty && newPassword == confirmPassword
    }

    public var body: some View {
        Form {
            Section {
                SecureField("Enter current password", text: $currentPassword)
                SecureField("Enter new password", text: $newPassword)
                SecureField("Enter new password", text: $confirmPassword)
            } header: {
                Text("Current Password")
            } footer: {
                if !newPassword.isEmpty && newPassword != confirmPassword {
                    Text("Passwords don't match")
                        .foregroundStyle(SCColor.criticalText)
                }
            }
        }
        .navigationTitle("Change Password")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save Changes") { dismiss() }
                    .disabled(!isValid)
            }
        }
    }
}
