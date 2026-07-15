import SwiftUI

/// A read-only field display that labels which party's data this is, per the Worker Profile UI
/// requirement ("Clear labeling of which fields were set by contractor vs. self-entered").
public struct FieldRow: View {
    public let label: String
    public let value: String
    public let owner: FieldOwner

    public init(_ label: String, value: String?, owner: FieldOwner) {
        self.label = label
        self.value = (value?.isEmpty == false) ? value! : "—"
        self.owner = owner
    }

    public var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(VeriforceTypography.caption)
                    .foregroundStyle(VeriforceColor.textSecondary)
                Text(value)
                    .foregroundStyle(VeriforceColor.textPrimary)
            }
            Spacer()
            Text(owner.rawValue)
                .font(VeriforceTypography.caption)
                .foregroundStyle(VeriforceColor.textTertiary)
        }
    }
}
