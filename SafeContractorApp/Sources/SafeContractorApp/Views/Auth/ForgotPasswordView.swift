import SwiftUI

/// Transcribed from "Sign in / Forgot password".
public struct ForgotPasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var username = ""

    public init() {}

    public var body: some View {
        ZStack {
            SCColor.brandNavy.ignoresSafeArea()

            VStack(alignment: .leading, spacing: SCSpacing.large) {
                VStack(alignment: .leading, spacing: SCSpacing.small) {
                    Text("Forgot password?")
                        .font(SCTypography.h2)
                    Text("Enter your email address or username and we'll send you details of how to reset your password")
                        .font(SCTypography.body1)
                }
                .foregroundStyle(SCColor.textInverse)

                TextField("Enter email address or username", text: $username)
                    .textFieldStyle(.roundedBorder)
                    #if os(iOS)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    #endif

                VStack(spacing: SCSpacing.standard) {
                    Button("Reset password") { dismiss() }
                        .buttonStyle(.borderedProminent)
                        .tint(SCColor.primary)
                        .frame(maxWidth: .infinity)
                        .disabled(username.isEmpty)

                    Button("Cancel") { dismiss() }
                        .buttonStyle(.bordered)
                        .tint(SCColor.textInverse)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(SCSpacing.standard)
        }
    }
}
