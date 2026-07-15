import SwiftUI

/// Matches the "Content type/Task" and "Content type/Gate Access" card components: title, a
/// date-range + reference-code subtitle, a divider, then a status row.
public struct SiteRecordCard: View {
    public let title: String
    public let dateRange: String
    public let referenceCode: String
    public let status: ComplianceStatus
    public let trailingText: String?

    public init(title: String, dateRange: String, referenceCode: String, status: ComplianceStatus, trailingText: String? = nil) {
        self.title = title
        self.dateRange = dateRange
        self.referenceCode = referenceCode
        self.status = status
        self.trailingText = trailingText
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: SCSpacing.small) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(SCTypography.h5)
                    .foregroundStyle(SCColor.textPrimary)
                HStack(spacing: SCSpacing.small) {
                    Text(dateRange)
                        .font(SCTypography.caption)
                        .foregroundStyle(SCColor.textPrimary)
                    Text(referenceCode)
                        .font(SCTypography.caption)
                        .foregroundStyle(SCColor.textSecondary)
                }
            }
            Divider()
            HStack {
                StatusChip(status)
                Spacer()
                if let trailingText {
                    Text(trailingText)
                        .font(SCTypography.body2)
                        .foregroundStyle(SCColor.textPrimary)
                }
            }
        }
        .padding(SCSpacing.standard)
        .background(SCColor.surfaceElevated)
        .clipShape(RoundedRectangle(cornerRadius: SCRadius.card))
    }
}
