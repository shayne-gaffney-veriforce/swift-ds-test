import Foundation

public enum InvitationStatus: String, Codable {
    case pending
    case accepted
    case expired
}

/// A platform-login invitation sent to a worker's email on file. Links expire after 7 days.
public struct WorkerInvitation: Identifiable, Hashable, Codable {
    public let id: UUID
    public let workerID: UUID
    public let contractorID: UUID
    public var sentAt: Date
    public var expiresAt: Date
    public var status: InvitationStatus
    public var resendCount: Int

    public init(
        id: UUID = UUID(),
        workerID: UUID,
        contractorID: UUID,
        sentAt: Date = Date(),
        status: InvitationStatus = .pending,
        resendCount: Int = 0
    ) {
        self.id = id
        self.workerID = workerID
        self.contractorID = contractorID
        self.sentAt = sentAt
        self.expiresAt = sentAt.addingTimeInterval(7 * 24 * 60 * 60)
        self.status = status
        self.resendCount = resendCount
    }

    public func isExpired(asOf now: Date) -> Bool {
        now > expiresAt
    }
}
