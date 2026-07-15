import SwiftUI

/// "Read-only view of contractor associations (names only, no contractor admin details)."
public struct MyContractorAssociationsView: View {
    @EnvironmentObject private var store: WorkerDirectoryStore
    public let workerID: UUID

    public init(workerID: UUID) {
        self.workerID = workerID
    }

    private var associations: [ContractorWorkerAssociation] {
        guard let worker = store.worker(workerID) else { return [] }
        return Permissions.visibleAssociations(for: worker, as: .worker(worker), in: store)
    }

    public var body: some View {
        List(associations) { association in
            HStack {
                Text(store.contractor(association.contractorID)?.name ?? "Unknown contractor")
                Spacer()
                StatusBadge(association.status)
            }
        }
        .navigationTitle("My employers")
    }
}
