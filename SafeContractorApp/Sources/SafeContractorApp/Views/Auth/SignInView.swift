import SwiftUI

/// Transcribed from "Sign in / Default" and "Sign in / Filled" in the Figma file: full-bleed
/// brand-navy background over a photo, white "Sign in" title, email + password fields, a
/// "Sign in" primary button, "Forgot password?" link, and a "Create account" secondary button.
public struct SignInView: View {
    @EnvironmentObject private var store: AppStore

    @State private var username = ""
    @State private var password = ""
    @State private var isPresentingForgotPassword = false
    @State private var isPresentingCreateAccount = false

    public init() {}

    private var isValid: Bool { !username.isEmpty && !password.isEmpty }

    public var body: some View {
        ZStack {
            Image("SignInBackground", bundle: .module)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            SCColor.brandNavy.opacity(0.85)
                .ignoresSafeArea()

            VStack(spacing: SCSpacing.large) {
                Spacer()

                Image("LogoWhite", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220)

                VStack(alignment: .leading, spacing: SCSpacing.medium) {
                    Text("Sign in")
                        .font(SCTypography.h2)
                        .foregroundStyle(SCColor.textInverse)

                    VStack(spacing: SCSpacing.standard) {
                        TextField("Enter email address or username", text: $username)
                            .textFieldStyle(.roundedBorder)
                            #if os(iOS)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            #endif
                        SecureField("Enter password", text: $password)
                            .textFieldStyle(.roundedBorder)
                    }

                    Button("Sign in") {
                        store.isSignedIn = true
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(SCColor.primary)
                    .frame(maxWidth: .infinity)
                    .disabled(!isValid)

                    Text("By signing in you agree to our Terms and Conditions.")
                        .font(SCTypography.caption)
                        .foregroundStyle(SCColor.textInverse)
                }

                Button("Forgot password?") { isPresentingForgotPassword = true }
                    .font(SCTypography.body1)
                    .foregroundStyle(SCColor.textInverse)

                Button("Create account") { isPresentingCreateAccount = true }
                    .buttonStyle(.bordered)
                    .tint(SCColor.textInverse)
                    .frame(maxWidth: .infinity)

                Spacer()
            }
            .padding(.horizontal, SCSpacing.standard)
        }
        .sheet(isPresented: $isPresentingForgotPassword) {
            ForgotPasswordView()
        }
        .sheet(isPresented: $isPresentingCreateAccount) {
            CreateAccountView()
        }
    }
}
