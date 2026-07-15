import SwiftUI

/// Transcribed from "My File / All", "My File / Qualifications", and "My File / Training" — one
/// screen with a segmented filter rather than three separate screens.
public struct MyFileView: View {
    @EnvironmentObject private var store: AppStore
    @State private var category: MyFileCategory?

    public init() {}

    private var filteredRecords: [MyFileRecord] {
        guard let category else { return store.fileRecords }
        return store.fileRecords.filter { $0.category == category.rawValue }
    }

    public var body: some View {
        VStack(spacing: SCSpacing.standard) {
            Picker("Category", selection: $category) {
                Text("All").tag(MyFileCategory?.none)
                ForEach(MyFileCategory.allCases) { option in
                    Text(option.rawValue).tag(MyFileCategory?.some(option))
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, SCSpacing.standard)
            .padding(.top, SCSpacing.small)

            if filteredRecords.isEmpty {
                EmptyStateView("No records yet.")
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: SCSpacing.standard) {
                        ForEach(filteredRecords) { record in
                            SiteRecordCard(
                                title: record.title,
                                dateRange: record.clientName,
                                referenceCode: record.expiresOn.map { "Expires \($0)" } ?? "",
                                status: record.status
                            )
                        }
                    }
                    .padding(SCSpacing.standard)
                }
            }
        }
        .background(SCColor.surfaceDefault)
        .navigationTitle("My File")
    }
}
