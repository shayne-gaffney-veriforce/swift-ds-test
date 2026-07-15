import SwiftUI

public enum WorkerFormMode {
    case add
    case edit(workerID: UUID)
}

/// Shared add/edit form for the Contractor Admin. Field enablement is driven by `Permissions`
/// rather than hardcoded here, so the rules stay in one place.
public struct WorkerFormView: View {
    @EnvironmentObject private var store: WorkerDirectoryStore
    @Environment(\.dismiss) private var dismiss

    public let contractor: Contractor
    public let mode: WorkerFormMode

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var primaryEmail = ""
    @State private var dateOfBirth = Date()
    @State private var employeeID = ""
    @State private var jobTitle = ""
    @State private var hasHireDate = false
    @State private var hireDate = Date()
    @State private var last4SSN = ""
    @State private var candidateID = ""
    @State private var infoMessage: String?

    public init(contractor: Contractor, mode: WorkerFormMode) {
        self.contractor = contractor
        self.mode = mode
    }

    private var existingWorker: Worker? {
        if case .edit(let id) = mode { return store.worker(id) }
        return nil
    }

    private var associationForEdit: ContractorWorkerAssociation? {
        guard let existingWorker else { return nil }
        return store.associations(forWorker: existingWorker.id).first { $0.contractorID == contractor.id }
    }

    private var isValid: Bool {
        !firstName.isEmpty && !lastName.isEmpty && !primaryEmail.isEmpty && !employeeID.isEmpty
    }

    /// New records have nothing to restrict yet; editing an existing one defers to `Permissions`
    /// so the rule lives in one place rather than being re-derived per field.
    private func isEditable(_ field: WorkerField) -> Bool {
        guard let existingWorker else { return true }
        return Permissions.canEditIdentityField(field, on: existingWorker, as: .contractorAdmin(contractor))
    }

    public var body: some View {
        Form {
            Section("Identity") {
                TextField("First name", text: $firstName)
                    .disabled(!isEditable(.firstName))
                TextField("Last name", text: $lastName)
                    .disabled(!isEditable(.lastName))

                if existingWorker == nil {
                    TextField("Primary email", text: $primaryEmail)
                        #if os(iOS)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        #endif
                } else {
                    FieldRow("Primary email", value: primaryEmail, owner: .worker)
                }

                DatePicker("Date of birth", selection: $dateOfBirth, displayedComponents: .date)
                    .disabled(!isEditable(.dateOfBirth))
            }

            Section("Employment (\(contractor.name))") {
                TextField("Employee ID", text: $employeeID)
                TextField("Job title", text: $jobTitle)
                    .disabled(!isEditable(.jobTitle))
                Toggle("Set hire date", isOn: $hasHireDate)
                    .disabled(!isEditable(.hireDate))
                if hasHireDate {
                    DatePicker("Hire date", selection: $hireDate, displayedComponents: .date)
                        .disabled(!isEditable(.hireDate))
                }
            }

            Section("Additional") {
                TextField("Last 4 SSN", text: $last4SSN)
                    .disabled(!isEditable(.last4SSN))
                if isEditable(.candidateID) {
                    TextField("Candidate ID (VS)", text: $candidateID)
                } else {
                    FieldRow("Candidate ID", value: candidateID, owner: WorkerField.candidateID.owner)
                }
            }

            if existingWorker == nil {
                Section {
                    Text("Adding a worker whose email already exists in GWN will link this contractor to their existing identity record instead of creating a duplicate.")
                        .font(VeriforceTypography.caption)
                        .foregroundStyle(VeriforceColor.textSecondary)
                }
            }
        }
        .navigationTitle(existingWorker == nil ? "Add worker" : "Edit worker")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button(existingWorker == nil ? "Add Worker" : "Save Changes", action: save).disabled(!isValid)
            }
        }
        .onAppear(perform: loadExistingIfNeeded)
        .alert("Existing worker found", isPresented: .constant(infoMessage != nil), presenting: infoMessage) { _ in
            Button("Done") { infoMessage = nil; dismiss() }
        } message: { message in
            Text(message)
        }
    }

    private func loadExistingIfNeeded() {
        guard let existingWorker else { return }
        firstName = existingWorker.firstName
        lastName = existingWorker.lastName
        primaryEmail = existingWorker.primaryEmail
        dateOfBirth = existingWorker.dateOfBirth
        jobTitle = existingWorker.jobTitle ?? ""
        if let hireDateValue = existingWorker.hireDate {
            hasHireDate = true
            hireDate = hireDateValue
        }
        last4SSN = existingWorker.last4SSN ?? ""
        candidateID = existingWorker.candidateID ?? ""
        employeeID = associationForEdit?.employeeID ?? ""
    }

    private func save() {
        let actorDescription = "\(contractor.name) Admin"

        switch mode {
        case .add:
            do {
                try store.addWorker(
                    firstName: firstName,
                    lastName: lastName,
                    primaryEmail: primaryEmail,
                    dateOfBirth: dateOfBirth,
                    employeeID: employeeID,
                    contractorID: contractor.id,
                    jobTitle: jobTitle.isEmpty ? nil : jobTitle,
                    hireDate: hasHireDate ? hireDate : nil,
                    last4SSN: last4SSN.isEmpty ? nil : last4SSN,
                    candidateID: candidateID.isEmpty ? nil : candidateID,
                    actorDescription: actorDescription
                )
                dismiss()
            } catch let error as WorkerDirectoryError {
                infoMessage = error.errorDescription
            } catch {
                infoMessage = error.localizedDescription
            }

        case .edit(let workerID):
            guard var worker = store.worker(workerID) else { return }
            worker.firstName = firstName
            worker.lastName = lastName
            worker.dateOfBirth = dateOfBirth
            worker.jobTitle = jobTitle.isEmpty ? nil : jobTitle
            worker.hireDate = hasHireDate ? hireDate : nil
            worker.last4SSN = last4SSN.isEmpty ? nil : last4SSN
            if worker.candidateID == nil, !candidateID.isEmpty {
                worker.candidateID = candidateID
            }
            store.updateWorker(worker, actorDescription: actorDescription)

            if let association = associationForEdit, association.employeeID != employeeID {
                store.updateAssociationEmployeeID(association.id, employeeID: employeeID, actorDescription: actorDescription)
            }
            dismiss()
        }
    }
}
