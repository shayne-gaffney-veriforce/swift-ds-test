import SwiftUI

public struct MyProfileView: View {
    @EnvironmentObject private var store: WorkerDirectoryStore
    public let workerID: UUID

    @State private var isPresentingEdit = false

    public init(workerID: UUID) {
        self.workerID = workerID
    }

    public var body: some View {
        if let worker = store.worker(workerID) {
            List {
                Section("My identity") {
                    FieldRow("First name", value: worker.firstName, owner: WorkerField.firstName.owner)
                    FieldRow("Last name", value: worker.lastName, owner: WorkerField.lastName.owner)
                    FieldRow("Primary email", value: worker.primaryEmail, owner: WorkerField.primaryEmail.owner)
                    FieldRow("Date of birth", value: worker.dateOfBirth.formatted(date: .abbreviated, time: .omitted), owner: WorkerField.dateOfBirth.owner)
                }

                Section("Contact info") {
                    FieldRow("Phone", value: worker.phone, owner: WorkerField.phone.owner)
                    FieldRow("Alternate email", value: worker.alternateEmail, owner: WorkerField.alternateEmail.owner)
                    FieldRow("Address", value: worker.address, owner: WorkerField.address.owner)
                    Button("Edit Contact Info") { isPresentingEdit = true }
                }

                Section("Employers") {
                    NavigationLink("My contractor associations") {
                        MyContractorAssociationsView(workerID: workerID)
                    }
                }

                Section("Training") {
                    Text("Training records will be available here in a future phase.")
                        .font(VeriforceTypography.body1)
                        .foregroundStyle(VeriforceColor.textSecondary)
                }
            }
            .navigationTitle("My profile")
            .sheet(isPresented: $isPresentingEdit) {
                NavigationStack {
                    EditContactInfoView(workerID: workerID)
                }
            }
        } else {
            Label("Profile not found", systemImage: "person.crop.circle.badge.exclamationmark")
                .foregroundStyle(VeriforceColor.textSecondary)
        }
    }
}
