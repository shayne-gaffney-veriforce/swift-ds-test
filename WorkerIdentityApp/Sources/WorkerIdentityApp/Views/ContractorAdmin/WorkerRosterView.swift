import SwiftUI
import SwiftUIX

/// Contractor Admin roster: search by name, filter by status, add/edit/deactivate per row.
public struct WorkerRosterView: View {
    @EnvironmentObject private var store: WorkerDirectoryStore
    public let contractor: Contractor

    @State private var searchText = ""
    @State private var isSearching = false
    @State private var statusFilter: AssociationStatus? = .active
    @State private var isPresentingAddWorker = false

    public init(contractor: Contractor) {
        self.contractor = contractor
    }

    private var rosterWorkers: [(worker: Worker, association: ContractorWorkerAssociation)] {
        let workers = Permissions.visibleWorkers(in: store, for: .contractorAdmin(contractor))
        return workers.compactMap { worker in
            guard let association = store.associations(forWorker: worker.id).first(where: { $0.contractorID == contractor.id }) else {
                return nil
            }
            return (worker, association)
        }
        .filter { statusFilter == nil || $0.association.status == statusFilter }
        .filter { searchText.isEmpty || $0.worker.fullName.localizedCaseInsensitiveContains(searchText) }
        .sorted { $0.worker.lastName < $1.worker.lastName }
    }

    public var body: some View {
        VStack(spacing: 0) {
            SearchBar("Search workers…", text: $searchText, isEditing: $isSearching)
                #if os(iOS) || os(visionOS)
                .showsCancelButton(isSearching)
                #endif
                .padding(.horizontal)
                .padding(.top, 8)

            Picker("Status", selection: $statusFilter) {
                Text("Active").tag(AssociationStatus?.some(.active))
                Text("Inactive").tag(AssociationStatus?.some(.inactive))
                Text("All").tag(AssociationStatus?.none)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .padding(.vertical, 8)

            if rosterWorkers.isEmpty {
                Spacer()
                Text(searchText.isEmpty ? "No workers yet. Add a worker to get started." : "No results for “\(searchText)”. Try adjusting your filters.")
                    .foregroundStyle(VeriforceColor.textSecondary)
                Spacer()
            } else {
                List {
                    ForEach(rosterWorkers, id: \.worker.id) { entry in
                        NavigationLink(value: entry.worker.id) {
                            WorkerRosterRow(worker: entry.worker, association: entry.association)
                        }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
        }
        .background(VeriforceColor.surfaceDefault)
        .navigationTitle(contractor.name)
        .navigationDestination(for: UUID.self) { workerID in
            if let worker = store.worker(workerID) {
                WorkerDetailView(contractor: contractor, workerID: worker.id)
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isPresentingAddWorker = true
                } label: {
                    Label("Add Worker", systemImage: "person.badge.plus")
                }
            }
        }
        .sheet(isPresented: $isPresentingAddWorker) {
            NavigationStack {
                WorkerFormView(contractor: contractor, mode: .add)
            }
        }
    }
}

struct WorkerRosterRow: View {
    let worker: Worker
    let association: ContractorWorkerAssociation

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(worker.fullName)
                    .font(VeriforceTypography.subtitle1)
                Text("\(worker.jobTitle ?? "—") · #\(association.employeeID)")
                    .font(VeriforceTypography.caption)
                    .foregroundStyle(VeriforceColor.textSecondary)
            }
            Spacer()
            StatusBadge(association.status)
        }
    }
}
