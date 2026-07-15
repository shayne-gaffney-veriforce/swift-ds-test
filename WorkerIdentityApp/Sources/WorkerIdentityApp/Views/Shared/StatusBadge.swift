import SwiftUI

public struct StatusBadge: View {
    public let status: AssociationStatus

    public init(_ status: AssociationStatus) {
        self.status = status
    }

    private var background: Color { status == .active ? VeriforceColor.successBg : VeriforceColor.neutralBg }
    private var foreground: Color { status == .active ? VeriforceColor.successText : VeriforceColor.neutralText }
    private var border: Color { status == .active ? VeriforceColor.successBorder : VeriforceColor.neutralBorder }

    public var body: some View {
        Text(status == .active ? "Active" : "Inactive")
            .font(VeriforceTypography.caption.weight(.semibold))
            .padding(.horizontal, VeriforceSpacing.small)
            .padding(.vertical, 3)
            .background(
                Capsule()
                    .fill(background)
                    .overlay(Capsule().strokeBorder(border, lineWidth: 1))
            )
            .foregroundStyle(foreground)
    }
}
