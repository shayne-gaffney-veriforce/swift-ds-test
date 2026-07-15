import Foundation

/// A client site the worker has (or is applying for) gate access to — the "Gate Access" cards.
public struct GateAccessRecord: Identifiable, Hashable, Codable {
    public let id: UUID
    public var siteName: String
    public var dateRange: String
    public var referenceCode: String
    public var status: ComplianceStatus
    public var requirements: [ComplianceRequirement]

    public init(
        id: UUID = UUID(),
        siteName: String,
        dateRange: String,
        referenceCode: String,
        status: ComplianceStatus,
        requirements: [ComplianceRequirement] = []
    ) {
        self.id = id
        self.siteName = siteName
        self.dateRange = dateRange
        self.referenceCode = referenceCode
        self.status = status
        self.requirements = requirements
    }
}

/// One line item on the Gate Access detail screen (e.g. "Site safety orientation — Compliant").
public struct ComplianceRequirement: Identifiable, Hashable, Codable {
    public let id: UUID
    public var title: String
    public var status: ComplianceStatus

    public init(id: UUID = UUID(), title: String, status: ComplianceStatus) {
        self.id = id
        self.title = title
        self.status = status
    }
}
