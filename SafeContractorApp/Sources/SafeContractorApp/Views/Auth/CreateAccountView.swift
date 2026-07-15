import SwiftUI

/// The Figma frame for this screen ("Create account") was left empty in the source file — this is
/// a minimal stub consistent with the Sign In screen's style, not a transcription.
public struct CreateAccountView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var email = ""
    @State private var password = ""

    public init() {}

    public var body: some View {
        ZStack {
            SCColor.brandNavy.ignoresSafeArea()

            VStack(alignment: .leading, spacing: SCSpacing.large) {
                Text("Create account")
                    .font(SCTypography.h2)
                    .foregroundStyle(SCColor.textInverse)

                VStack(spacing: SCSpacing.standard) {
                    TextField("Enter email address", text: $email)
                        .textFieldStyle(.roundedBorder)
                        #if os(iOS)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        #endif
                    SecureField("Create password", text: $password)
                        .textFieldStyle(.roundedBorder)
                }

                Button("Create account") { dismiss() }
                    .buttonStyle(.borderedProminent)
                    .tint(SCColor.primary)
                    .frame(maxWidth: .infinity)
                    .disabled(email.isEmpty || password.isEmpty)

                Button("Cancel") { dismiss() }
                    .buttonStyle(.bordered)
                    .tint(SCColor.textInverse)
                    .frame(maxWidth: .infinity)
            }
            .padding(SCSpacing.standard)
        }
    }
}
