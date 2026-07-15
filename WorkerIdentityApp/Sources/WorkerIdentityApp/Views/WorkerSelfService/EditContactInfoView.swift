import SwiftUI

/// Worker Self-Edit: per the spec, workers may only edit phone, alternate email, and address.
public struct EditContactInfoView: View {
    @EnvironmentObject private var store: WorkerDirectoryStore
    @Environment(\.dismiss) private var dismiss

    public let workerID: UUID

    @State private var phone = ""
    @State private var alternateEmail = ""
    @State private var address = ""

    public init(workerID: UUID) {
        self.workerID = workerID
    }

    public var body: some View {
        Form {
            Section("Contact info") {
                TextField("Phone", text: $phone)
                TextField("Alternate email", text: $alternateEmail)
                TextField("Address", text: $address)
            }
            Section {
                Text("Your employer will be notified that you updated this information.")
                    .font(VeriforceTypography.caption)
                    .foregroundStyle(VeriforceColor.textSecondary)
            }
        }
        .navigationTitle("Edit contact info")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save Changes", action: save)
            }
        }
        .onAppear {
            guard let worker = store.worker(workerID) else { return }
            phone = worker.phone ?? ""
            alternateEmail = worker.alternateEmail ?? ""
            address = worker.address ?? ""
        }
    }

    private func save() {
        guard var worker = store.worker(workerID) else { return }
        worker.phone = phone.isEmpty ? nil : phone
        worker.alternateEmail = alternateEmail.isEmpty ? nil : alternateEmail
        worker.address = address.isEmpty ? nil : address
        store.updateWorker(worker, actorDescription: "\(worker.fullName) (self)")
        dismiss()
    }
}
