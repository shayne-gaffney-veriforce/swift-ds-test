import SwiftUI

/// Transcribed from "Gate Access / All" (list) and "Gate Access / All / Detail" (row detail).
/// "Gate Access / Granted" and "Gate Access / Blocked" are the same list filtered to one status,
/// reflected here via the status chip on each row rather than as separate screens.
public struct GateAccessView: View {
    @EnvironmentObject private var store: AppStore
    @State private var searchText = ""

    public init() {}

    private var filteredRecords: [GateAccessRecord] {
        store.gateAccess.filter { searchText.isEmpty || $0.siteName.localizedCaseInsensitiveContains(searchText) }
    }

    public var body: some View {
        Group {
            if filteredRecords.isEmpty {
                EmptyStateView("No results for \u{201C}\(searchText)\u{201D}. Try adjusting your search.")
            } else {
                List(filteredRecords) { record in
                    NavigationLink(value: record.id) {
                        SiteRecordCard(title: record.siteName, dateRange: record.dateRange, referenceCode: record.referenceCode, status: record.status)
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: SCSpacing.tight, leading: SCSpacing.standard, bottom: SCSpacing.tight, trailing: SCSpacing.standard))
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
        }
        .searchable(text: $searchText, prompt: "Search sites")
        .background(SCColor.surfaceDefault)
        .navigationTitle("Gate Access")
        .navigationDestination(for: UUID.self) { id in
            if let record = store.gateAccess.first(where: { $0.id == id }) {
                GateAccessDetailView(record: record)
            }
        }
    }
}
