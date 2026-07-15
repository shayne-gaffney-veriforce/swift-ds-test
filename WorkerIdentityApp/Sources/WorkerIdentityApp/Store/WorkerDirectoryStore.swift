import Foundation
import Combine

public enum WorkerDirectoryError: Error, LocalizedError {
    /// A worker with this email already exists in GWN under a different (or no) contractor —
    /// this contractor has now been linked to that existing identity record.
    case existingWorkerLinked(existingWorker: Worker, contractorName: String)
    /// A worker with this email is already on this contractor's roster — no-op, not a new link.
    case existingWorkerAlreadyOnRoster(existingWorker: Worker)
    case fieldNotEditable(String)
    case candidateIDAlreadySet

    public var errorDescription: String? {
        switch self {
        case .existingWorkerLinked(let worker, let contractorName):
            return "\(worker.fullName) already exists in GWN. We linked them to \(contractorName) instead of creating a duplicate."
        case .existingWorkerAlreadyOnRoster(let worker):
            return "\(worker.fullName) is already on your roster with this email."
        case .fieldNotEditable(let field):
            return "\(field) can't be edited."
        case .candidateIDAlreadySet:
            return "Candidate ID can't be changed once it's set."
        }
    }
}

/// Stands in for the GWN backend: an in-memory, seeded source of truth for worker identity,
/// contractor-worker associations, invitations, and the change log. Nothing here persists across
/// launches (that trade-off was a deliberate scope decision, not an oversight).
@MainActor
public final class WorkerDirectoryStore: ObservableObject {
    @Published public private(set) var workers: [Worker]
    @Published public private(set) var contractors: [Contractor]
    @Published public private(set) var associations: [ContractorWorkerAssociation]
    @Published public private(set) var invitations: [WorkerInvitation]
    @Published public private(set) var changeLog: [ChangeLogEntry]

    public init(
        workers: [Worker] = [],
        contractors: [Contractor] = [],
        associations: [ContractorWorkerAssociation] = [],
        invitations: [WorkerInvitation] = [],
        changeLog: [ChangeLogEntry] = []
    ) {
        self.workers = workers
        self.contractors = contractors
        self.associations = associations
        self.invitations = invitations
        self.changeLog = changeLog
    }

    // MARK: - Lookups

    public func worker(_ id: UUID) -> Worker? {
        workers.first { $0.id == id }
    }

    public func contractor(_ id: UUID) -> Contractor? {
        contractors.first { $0.id == id }
    }

    public func existingWorker(withEmail email: String) -> Worker? {
        workers.first { $0.primaryEmail.caseInsensitiveCompare(email) == .orderedSame }
    }

    public func associations(forContractor contractorID: UUID) -> [ContractorWorkerAssociation] {
        associations.filter { $0.contractorID == contractorID }
    }

    public func associations(forWorker workerID: UUID) -> [ContractorWorkerAssociation] {
        associations.filter { $0.workerID == workerID }
    }

    public func changeLog(forWorker workerID: UUID) -> [ChangeLogEntry] {
        changeLog.filter { $0.workerID == workerID }.sorted { $0.changedAt > $1.changedAt }
    }

    // MARK: - Add worker

    /// Creates a new worker + association, or — if a worker with this email already exists
    /// anywhere in GWN — links the existing worker to this contractor instead (per the resolved
    /// dedup Open Question: "link them, don't merge").
    @discardableResult
    public func addWorker(
        firstName: String,
        lastName: String,
        primaryEmail: String,
        dateOfBirth: Date,
        employeeID: String,
        contractorID: UUID,
        jobTitle: String? = nil,
        hireDate: Date? = nil,
        last4SSN: String? = nil,
        candidateID: String? = nil,
        actorDescription: String
    ) throws -> Worker {
        if let existing = existingWorker(withEmail: primaryEmail) {
            if let existingAssociation = associations.first(where: { $0.workerID == existing.id && $0.contractorID == contractorID }) {
                if existingAssociation.employeeID != employeeID {
                    updateAssociationEmployeeID(existingAssociation.id, employeeID: employeeID, actorDescription: actorDescription)
                }
                throw WorkerDirectoryError.existingWorkerAlreadyOnRoster(existingWorker: existing)
            }

            let association = ContractorWorkerAssociation(
                workerID: existing.id,
                contractorID: contractorID,
                employeeID: employeeID
            )
            associations.append(association)
            let contractorName = contractor(contractorID)?.name ?? "contractor"
            log(workerID: existing.id, field: "association", oldValue: "none", newValue: "linked to \(contractorName)", actor: actorDescription)
            throw WorkerDirectoryError.existingWorkerLinked(existingWorker: existing, contractorName: contractorName)
        }

        let worker = Worker(
            firstName: firstName,
            lastName: lastName,
            primaryEmail: primaryEmail,
            dateOfBirth: dateOfBirth,
            jobTitle: jobTitle,
            hireDate: hireDate,
            last4SSN: last4SSN,
            candidateID: candidateID
        )
        workers.append(worker)
        associations.append(
            ContractorWorkerAssociation(workerID: worker.id, contractorID: contractorID, employeeID: employeeID)
        )
        log(workerID: worker.id, field: "record", oldValue: "—", newValue: "created", actor: actorDescription)
        return worker
    }

    // MARK: - Edit worker

    public func updateWorker(_ updated: Worker, actorDescription: String) {
        guard let index = workers.firstIndex(where: { $0.id == updated.id }) else { return }
        let original = workers[index]

        for (field, oldValue, newValue) in Self.diff(original, updated) {
            log(workerID: updated.id, field: field, oldValue: oldValue, newValue: newValue, actor: actorDescription)
        }

        var revised = updated
        revised.updatedAt = Date()
        workers[index] = revised
    }

    private static func diff(_ old: Worker, _ new: Worker) -> [(field: String, old: String, new: String)] {
        var changes: [(String, String, String)] = []
        func note(_ field: String, _ oldValue: String?, _ newValue: String?) {
            let o = oldValue ?? ""
            let n = newValue ?? ""
            if o != n { changes.append((field, o, n)) }
        }
        note("First name", old.firstName, new.firstName)
        note("Last name", old.lastName, new.lastName)
        note("Date of birth", old.dateOfBirth.formatted(date: .abbreviated, time: .omitted), new.dateOfBirth.formatted(date: .abbreviated, time: .omitted))
        note("Phone", old.phone, new.phone)
        note("Alternate email", old.alternateEmail, new.alternateEmail)
        note("Address", old.address, new.address)
        note("Job title", old.jobTitle, new.jobTitle)
        note("Hire date", old.hireDate?.formatted(date: .abbreviated, time: .omitted), new.hireDate?.formatted(date: .abbreviated, time: .omitted))
        note("Last 4 SSN", old.last4SSN, new.last4SSN)
        note("Candidate ID", old.candidateID, new.candidateID)
        return changes
    }

    // MARK: - Deactivate / reactivate association

    public func setAssociationStatus(_ associationID: UUID, status: AssociationStatus, actorDescription: String) {
        guard let index = associations.firstIndex(where: { $0.id == associationID }) else { return }
        let old = associations[index].status
        associations[index].status = status
        log(
            workerID: associations[index].workerID,
            field: "Association status (\(contractor(associations[index].contractorID)?.name ?? ""))",
            oldValue: old.rawValue,
            newValue: status.rawValue,
            actor: actorDescription
        )
    }

    public func updateAssociationEmployeeID(_ associationID: UUID, employeeID: String, actorDescription: String) {
        guard let index = associations.firstIndex(where: { $0.id == associationID }) else { return }
        let old = associations[index].employeeID
        guard old != employeeID else { return }
        associations[index].employeeID = employeeID
        log(
            workerID: associations[index].workerID,
            field: "Employee ID (\(contractor(associations[index].contractorID)?.name ?? ""))",
            oldValue: old,
            newValue: employeeID,
            actor: actorDescription
        )
    }

    // MARK: - Platform admin link/unlink

    @discardableResult
    public func linkWorker(_ workerID: UUID, toContractor contractorID: UUID, employeeID: String, actorDescription: String) -> ContractorWorkerAssociation {
        let association = ContractorWorkerAssociation(workerID: workerID, contractorID: contractorID, employeeID: employeeID)
        associations.append(association)
        log(workerID: workerID, field: "association", oldValue: "none", newValue: "linked to \(contractor(contractorID)?.name ?? "contractor")", actor: actorDescription)
        return association
    }

    public func unlinkAssociation(_ associationID: UUID, actorDescription: String) {
        guard let association = associations.first(where: { $0.id == associationID }) else { return }
        associations.removeAll { $0.id == associationID }
        log(workerID: association.workerID, field: "association", oldValue: "linked to \(contractor(association.contractorID)?.name ?? "contractor")", newValue: "unlinked", actor: actorDescription)
    }

    // MARK: - Invitations

    @discardableResult
    public func inviteWorker(_ workerID: UUID, contractorID: UUID, actorDescription: String) -> WorkerInvitation {
        let invitation = WorkerInvitation(workerID: workerID, contractorID: contractorID)
        invitations.append(invitation)
        log(workerID: workerID, field: "invitation", oldValue: "none", newValue: "sent", actor: actorDescription)
        return invitation
    }

    public func resendInvitation(_ invitationID: UUID, actorDescription: String) {
        guard let index = invitations.firstIndex(where: { $0.id == invitationID }) else { return }
        let now = Date()
        invitations[index].sentAt = now
        invitations[index].expiresAt = now.addingTimeInterval(7 * 24 * 60 * 60)
        invitations[index].status = .pending
        invitations[index].resendCount += 1
        log(workerID: invitations[index].workerID, field: "invitation", oldValue: "pending", newValue: "resent", actor: actorDescription)
    }

    public func pendingInvitation(forWorker workerID: UUID, contractorID: UUID) -> WorkerInvitation? {
        invitations
            .filter { $0.workerID == workerID && $0.contractorID == contractorID }
            .sorted { $0.sentAt > $1.sentAt }
            .first
    }

    // MARK: - Private

    private func log(workerID: UUID, field: String, oldValue: String, newValue: String, actor: String) {
        changeLog.append(
            ChangeLogEntry(workerID: workerID, field: field, oldValue: oldValue, newValue: newValue, actorDescription: actor)
        )
    }
}
