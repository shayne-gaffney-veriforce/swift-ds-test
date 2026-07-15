import SwiftUI

public struct GateAccessDetailView: View {
    public let record: GateAccessRecord

    public init(record: GateAccessRecord) {
        self.record = record
    }

    public var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: SCSpacing.small) {
                    HStack {
                        Text(record.dateRange)
                        Spacer()
                        Text(record.referenceCode)
                            .foregroundStyle(SCColor.textSecondary)
                    }
                    .font(SCTypography.caption)
                    StatusChip(record.status)
                }
            }

            if !record.requirements.isEmpty {
                Section("Requirements") {
                    ForEach(record.requirements) { requirement in
                        HStack {
                            Text(requirement.title)
                            Spacer()
                            StatusChip(requirement.status)
                        }
                    }
                }
            }
        }
        .navigationTitle(record.siteName)
    }
}
