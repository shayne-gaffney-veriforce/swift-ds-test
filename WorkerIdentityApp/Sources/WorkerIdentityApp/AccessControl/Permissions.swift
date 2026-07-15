import Foundation

public enum WorkerField: String, CaseIterable {
    case firstName = "First Name"
    case lastName = "Last Name"
    case primaryEmail = "Primary Email"
    case dateOfBirth = "Date of Birth"
    case phone = "Phone"
    case alternateEmail = "Alternate Email"
    case address = "Address"
    case jobTitle = "Job Title"
    case hireDate = "Hire Date"
    case last4SSN = "Last 4 SSN"
    case candidateID = "Candidate ID"

    public var owner: FieldOwner {
        switch self {
        case .firstName, .lastName, .last4SSN:
            return .contractorAndWorker
        case .primaryEmail:
            return .worker
        case .dateOfBirth, .jobTitle, .hireDate:
            return .contractor
        case .phone, .alternateEmail, .address:
            return .worker
        case .candidateID:
            return .systemAndWorker
        }
    }
}

/// Encodes the spec's Access Control Model table, plus the more specific per-field constraints
/// called out in individual requirements (which win where they're more precise than the general
/// ownership column — e.g. the Access Control table scopes Contractor Admin edits to
/// "contractor-owned fields", which excludes worker-owned phone/alternate email/address even
/// though the general Edit Worker requirement says "all non-immutable fields").
@MainActor
public enum Permissions {
    public static func canEditIdentityField(_ field: WorkerField, on worker: Worker, as actor: CurrentActor) -> Bool {
        switch actor {
        case .platformAdmin:
            // Access Control Model: Platform Admin can edit "All fields (support use case)" —
            // this is a deliberate override of the immutability rules below, not an oversight.
            // (`primaryEmail` is a `let` on `Worker`, so this grant has no code path to act on yet.)
            return true

        case .contractorAdmin:
            switch field {
            case .firstName, .lastName, .dateOfBirth, .jobTitle, .hireDate, .last4SSN:
                return true
            case .candidateID:
                return worker.candidateID == nil
            case .primaryEmail, .phone, .alternateEmail, .address:
                return false
            }

        case .worker(let self_):
            guard self_.id == worker.id else { return false }
            switch field {
            case .phone, .alternateEmail, .address:
                return true
            case .firstName, .lastName, .primaryEmail, .dateOfBirth, .jobTitle, .hireDate, .last4SSN, .candidateID:
                return false
            }
        }
    }

    public static func canEditAssociation(_ association: ContractorWorkerAssociation, as actor: CurrentActor) -> Bool {
        switch actor {
        case .platformAdmin:
            return true
        case .contractorAdmin(let contractor):
            return contractor.id == association.contractorID
        case .worker:
            return false
        }
    }

    /// Workers visible to `actor` — a Contractor Admin only sees workers with an active-or-inactive
    /// association to their own contractor; a Worker only sees themselves; Platform Admin sees all.
    public static func visibleWorkers(in store: WorkerDirectoryStore, for actor: CurrentActor) -> [Worker] {
        switch actor {
        case .platformAdmin:
            return store.workers
        case .contractorAdmin(let contractor):
            let workerIDs = Set(store.associations(forContractor: contractor.id).map(\.workerID))
            return store.workers.filter { workerIDs.contains($0.id) }
        case .worker(let worker):
            return store.workers.filter { $0.id == worker.id }
        }
    }

    /// Associations visible to `actor` for a given worker — a Contractor Admin never sees another
    /// contractor's association to a shared worker, and a Worker only ever sees their own.
    public static func visibleAssociations(for worker: Worker, as actor: CurrentActor, in store: WorkerDirectoryStore) -> [ContractorWorkerAssociation] {
        let all = store.associations(forWorker: worker.id)
        switch actor {
        case .platformAdmin:
            return all
        case .worker(let self_):
            return self_.id == worker.id ? all : []
        case .contractorAdmin(let contractor):
            return all.filter { $0.contractorID == contractor.id }
        }
    }
}
