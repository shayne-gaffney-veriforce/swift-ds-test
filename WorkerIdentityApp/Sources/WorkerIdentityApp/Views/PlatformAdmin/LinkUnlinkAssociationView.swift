import SwiftUI

/// Platform Admin: "manually link or unlink a worker from a contractor... without engineering intervention."
public struct LinkUnlinkAssociationView: View {
    @EnvironmentObject private var store: WorkerDirectoryStore
    public let workerID: UUID

    @State private var selectedContractorID: UUID?
    @State private var newEmployeeID = ""

    public init(workerID: UUID) {
        self.workerID = workerID
    }

    private var worker: Worker? { store.worker(workerID) }
    private var associations: [ContractorWorkerAssociation] {
        guard let worker else { return [] }
        return Permissions.visibleAssociations(for: worker, as: .platformAdmin, in: store)
    }

    private var unassociatedContractors: [Contractor] {
        let linkedIDs = Set(associations.map(\.contractorID))
        return store.contractors.filter { !linkedIDs.contains($0.id) }
    }

    public var body: some View {
        if let worker {
            List {
                Section("Identity") {
                    FieldRow("Name", value: worker.fullName, owner: WorkerField.firstName.owner)
                    FieldRow("Primary email", value: worker.primaryEmail, owner: WorkerField.primaryEmail.owner)
                    FieldRow("GWN worker ID", value: worker.id.uuidString, owner: .system)
                }

                Section("Current associations") {
                    if associations.isEmpty {
                        Text("Not linked to any contractors yet.").foregroundStyle(VeriforceColor.textSecondary)
                    }
                    ForEach(associations) { association in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(store.contractor(association.contractorID)?.name ?? "Unknown")
                                Text("Employee ID: \(association.employeeID)")
                                    .font(VeriforceTypography.caption)
                                    .foregroundStyle(VeriforceColor.textSecondary)
                            }
                            Spacer()
                            StatusBadge(association.status)
                            Button("Unlink", role: .destructive) {
                                store.unlinkAssociation(association.id, actorDescription: "Platform Admin")
                            }
                            .font(VeriforceTypography.caption)
                        }
                    }
                }

                if !unassociatedContractors.isEmpty {
                    Section("Link to a new contractor") {
                        Picker("Contractor", selection: $selectedContractorID) {
                            Text("Select…").tag(UUID?.none)
                            ForEach(unassociatedContractors) { contractor in
                                Text(contractor.name).tag(UUID?.some(contractor.id))
                            }
                        }
                        TextField("Employee ID", text: $newEmployeeID)
                        Button("Link Worker") {
                            guard let selectedContractorID, !newEmployeeID.isEmpty else { return }
                            store.linkWorker(workerID, toContractor: selectedContractorID, employeeID: newEmployeeID, actorDescription: "Platform Admin")
                            self.selectedContractorID = nil
                            newEmployeeID = ""
                        }
                        .disabled(selectedContractorID == nil || newEmployeeID.isEmpty)
                    }
                }
            }
            .navigationTitle(worker.fullName)
        } else {
            Label("Worker not found", systemImage: "person.crop.circle.badge.exclamationmark")
                .foregroundStyle(VeriforceColor.textSecondary)
        }
    }
}
