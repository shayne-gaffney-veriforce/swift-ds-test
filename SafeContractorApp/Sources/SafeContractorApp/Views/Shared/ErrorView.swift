import SwiftUI

/// Transcribed from "Error": an illustration, "Oops!" heading, a message, and a back action.
public struct ErrorView: View {
    @Environment(\.dismiss) private var dismiss

    public init() {}

    public var body: some View {
        VStack(spacing: SCSpacing.large) {
            Spacer()
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 96, height: 96)
                .foregroundStyle(SCColor.textTertiary)

            VStack(spacing: SCSpacing.small) {
                Text("Oops!")
                    .font(.system(size: 38, weight: .bold))
                Text("The page you were looking for could not be found")
                    .font(SCTypography.h5)
                    .multilineTextAlignment(.center)
            }
            .foregroundStyle(SCColor.textPrimary)

            Button("Back to previous page") { dismiss() }
                .buttonStyle(.borderedProminent)
                .tint(SCBlue._600)
                .frame(maxWidth: .infinity)

            Spacer()
        }
        .padding(SCSpacing.standard)
        .background(SCColor.surfaceDefault)
    }
}
