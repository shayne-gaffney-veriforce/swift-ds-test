import SwiftUI

public struct EmptyStateView: View {
    public let message: String

    public init(_ message: String) {
        self.message = message
    }

    public var body: some View {
        Text(message)
            .font(SCTypography.body1)
            .foregroundStyle(SCColor.textSecondary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .padding(.vertical, SCSpacing.large)
    }
}
