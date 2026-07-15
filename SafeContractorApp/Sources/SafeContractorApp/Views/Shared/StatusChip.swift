import SwiftUI

/// A pill-shaped status indicator — matches the "Circle icons" / "Status Icons" component set in
/// the Figma file's component library.
public struct StatusChip: View {
    public let status: ComplianceStatus

    public init(_ status: ComplianceStatus) {
        self.status = status
    }

    public var body: some View {
        Label(status.label, systemImage: status.systemImage)
            .font(SCTypography.caption.weight(.semibold))
            .foregroundStyle(status.tint)
            .padding(.horizontal, SCSpacing.small)
            .padding(.vertical, 4)
            .background(Capsule().fill(status.background))
    }
}
