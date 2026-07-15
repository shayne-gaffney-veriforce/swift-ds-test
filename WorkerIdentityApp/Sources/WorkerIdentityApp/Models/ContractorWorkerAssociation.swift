import Foundation

public enum AssociationStatus: String, Codable, CaseIterable {
    case active
    case inactive
}

/// The association between a worker and a contractor. A worker can have multiple active
/// associations at once (multi-contractor is a confirmed current reality, per the spec's
/// resolved Open Questions). Deactivating an association does not delete the worker record.
public struct ContractorWorkerAssociation: Identifiable, Hashable, Codable {
    public let id: UUID
    public let workerID: UUID
    public let contractorID: UUID

    /// Contractor-assigned, scoped per relationship (per the spec's field table note).
    public var employeeID: String

    public var status: AssociationStatus
    public let effectiveDate: Date

    public init(
        id: UUID = UUID(),
        workerID: UUID,
        contractorID: UUID,
        employeeID: String,
        status: AssociationStatus = .active,
        effectiveDate: Date = Date()
    ) {
        self.id = id
        self.workerID = workerID
        self.contractorID = contractorID
        self.employeeID = employeeID
        self.status = status
        self.effectiveDate = effectiveDate
    }
}
