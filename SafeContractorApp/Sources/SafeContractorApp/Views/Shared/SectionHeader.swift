import SwiftUI

/// Matches the "List section header" component — a title with an optional trailing action.
public struct SectionHeader: View {
    public let title: String
    public let actionTitle: String?
    public let action: (() -> Void)?

    public init(_ title: String, actionTitle: String? = nil, action: (() -> Void)? = nil) {
        self.title = title
        self.actionTitle = actionTitle
        self.action = action
    }

    public var body: some View {
        HStack {
            Text(title)
                .font(SCTypography.h5)
                .foregroundStyle(SCColor.textPrimary)
            Spacer()
            if let actionTitle, let action {
                Button(actionTitle, action: action)
                    .font(SCTypography.body2)
            }
        }
    }
}
