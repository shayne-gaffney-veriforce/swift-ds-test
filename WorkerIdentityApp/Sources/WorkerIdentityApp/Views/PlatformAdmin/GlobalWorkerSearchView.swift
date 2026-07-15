import SwiftUI
import SwiftUIX

/// Platform Admin: "look up any worker by ID or name across all contractors."
public struct GlobalWorkerSearchView: View {
    @EnvironmentObject private var store: WorkerDirectoryStore
    @State private var searchText = ""
    @State private var isSearching = false

    public init() {}

    private var results: [Worker] {
        guard !searchText.isEmpty else { return store.workers }
        return store.workers.filter {
            $0.fullName.localizedCaseInsensitiveContains(searchText)
                || $0.id.uuidString.localizedCaseInsensitiveContains(searchText)
        }
    }

    public var body: some View {
        VStack(spacing: 0) {
            SearchBar("Search by name or worker ID…", text: $searchText, isEditing: $isSearching)
                #if os(iOS) || os(visionOS)
                .showsCancelButton(isSearching)
                #endif
                .padding(.horizontal)
                .padding(.top, 8)

            if results.isEmpty {
                Spacer()
                Text("No results for “\(searchText)”. Try a different search term.")
                    .foregroundStyle(VeriforceColor.textSecondary)
                Spacer()
            } else {
                List {
                    ForEach(results) { worker in
                        NavigationLink(value: worker.id) {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(worker.fullName).font(VeriforceTypography.subtitle1)
                                Text(worker.primaryEmail).font(VeriforceTypography.caption).foregroundStyle(VeriforceColor.textSecondary)
                                Text(worker.id.uuidString).font(VeriforceTypography.caption).foregroundStyle(VeriforceColor.textTertiary)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
        }
        .background(VeriforceColor.surfaceDefault)
        .navigationTitle("Worker lookup")
        .navigationDestination(for: UUID.self) { workerID in
            LinkUnlinkAssociationView(workerID: workerID)
        }
    }
}
