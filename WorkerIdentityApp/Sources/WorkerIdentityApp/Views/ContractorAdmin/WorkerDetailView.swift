import SwiftUI

public struct WorkerDetailView: View {
    @EnvironmentObject private var store: WorkerDirectoryStore
    public let contractor: Contractor
    public let workerID: UUID

    @State private var isPresentingEdit = false
    @State private var isPresentingDeactivateConfirmation = false

    public init(contractor: Contractor, workerID: UUID) {
        self.contractor = contractor
        self.workerID = workerID
    }

    private var worker: Worker? { store.worker(workerID) }

    private var association: ContractorWorkerAssociation? {
        guard let worker else { return nil }
        return Permissions.visibleAssociations(for: worker, as: .contractorAdmin(contractor), in: store).first
    }

    public var body: some View {
        if let worker, let association {
            List {
                Section("Identity") {
                    FieldRow("First name", value: worker.firstName, owner: WorkerField.firstName.owner)
                    FieldRow("Last name", value: worker.lastName, owner: WorkerField.lastName.owner)
                    FieldRow("Primary email", value: worker.primaryEmail, owner: WorkerField.primaryEmail.owner)
                    FieldRow("Date of birth", value: worker.dateOfBirth.formatted(date: .abbreviated, time: .omitted), owner: WorkerField.dateOfBirth.owner)
                    FieldRow("Phone", value: worker.phone, owner: WorkerField.phone.owner)
                }

                Section("Employment at \(contractor.name)") {
                    FieldRow("Employee ID", value: association.employeeID, owner: .contractor)
                    FieldRow("Job title", value: worker.jobTitle, owner: WorkerField.jobTitle.owner)
                    HStack {
                        Text("Status")
                        Spacer()
                        StatusBadge(association.status)
                    }
                }

                Section("Additional") {
                    FieldRow("Last 4 SSN", value: worker.last4SSN, owner: WorkerField.last4SSN.owner)
                    FieldRow("Candidate ID", value: worker.candidateID, owner: WorkerField.candidateID.owner)
                }

                Section("Platform access") {
                    InviteControl(contractor: contractor, workerID: worker.id)
                }

                let history = store.changeLog(forWorker: worker.id)
                if !history.isEmpty {
                    Section("Recent changes") {
                        ForEach(history.prefix(10)) { entry in
                            VStack(alignment: .leading, spacing: 2) {
                                Text("\(entry.field): \(entry.oldValue) → \(entry.newValue)")
                                    .font(VeriforceTypography.caption)
                                Text("\(entry.actorDescription) · \(entry.changedAt.formatted(date: .abbreviated, time: .shortened))")
                                    .font(VeriforceTypography.caption)
                                    .foregroundStyle(VeriforceColor.textTertiary)
                            }
                        }
                    }
                }
            }
            .navigationTitle(worker.fullName)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Button("Edit Worker") { isPresentingEdit = true }
                        if association.status == .active {
                            Button("Deactivate", role: .destructive) {
                                isPresentingDeactivateConfirmation = true
                            }
                        } else {
                            Button("Reactivate") {
                                store.setAssociationStatus(association.id, status: .active, actorDescription: "\(contractor.name) Admin")
                            }
                        }
                    } label: {
                        Label("Actions", systemImage: "ellipsis.circle")
                    }
                }
            }
            .sheet(isPresented: $isPresentingEdit) {
                NavigationStack {
                    WorkerFormView(contractor: contractor, mode: .edit(workerID: worker.id))
                }
            }
            .confirmationDialog(
                "Deactivate \(worker.fullName)?",
                isPresented: $isPresentingDeactivateConfirmation,
                titleVisibility: .visible
            ) {
                Button("Deactivate", role: .destructive) {
                    store.setAssociationStatus(association.id, status: .inactive, actorDescription: "\(contractor.name) Admin")
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("They'll no longer appear on the active roster or client-facing views. This is reversible and their data is retained.")
            }
        } else {
            Label("Worker not found", systemImage: "person.crop.circle.badge.exclamationmark")
                .foregroundStyle(VeriforceColor.textSecondary)
        }
    }
}

private struct InviteControl: View {
    @EnvironmentObject private var store: WorkerDirectoryStore
    let contractor: Contractor
    let workerID: UUID

    private var invitation: WorkerInvitation? {
        store.pendingInvitation(forWorker: workerID, contractorID: contractor.id)
    }

    var body: some View {
        if let invitation {
            let expired = invitation.isExpired(asOf: Date())
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(expired ? "Invitation expired" : "Invitation sent")
                        .foregroundStyle(expired ? VeriforceColor.criticalText : VeriforceColor.successText)
                    Spacer()
                    Text(invitation.expiresAt.formatted(date: .abbreviated, time: .omitted))
                        .font(VeriforceTypography.caption)
                        .foregroundStyle(VeriforceColor.textSecondary)
                }
                Button("Resend Invitation") {
                    store.resendInvitation(invitation.id, actorDescription: "\(contractor.name) Admin")
                }
                .font(VeriforceTypography.caption)
            }
        } else {
            Button("Invite Worker to Platform") {
                store.inviteWorker(workerID, contractorID: contractor.id, actorDescription: "\(contractor.name) Admin")
            }
        }
    }
}
