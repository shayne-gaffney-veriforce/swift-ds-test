import Foundation

/// Records who changed what on a worker record, per the Edit Worker / Worker Self-Edit
/// requirements ("Changes are logged with timestamp and actor").
public struct ChangeLogEntry: Identifiable, Hashable, Codable {
    public let id: UUID
    public let workerID: UUID
    public let field: String
    public let oldValue: String
    public let newValue: String
    public let changedAt: Date
    public let actorDescription: String

    public init(
        id: UUID = UUID(),
        workerID: UUID,
        field: String,
        oldValue: String,
        newValue: String,
        changedAt: Date = Date(),
        actorDescription: String
    ) {
        self.id = id
        self.workerID = workerID
        self.field = field
        self.oldValue = oldValue
        self.newValue = newValue
        self.changedAt = changedAt
        self.actorDescription = actorDescription
    }
}
