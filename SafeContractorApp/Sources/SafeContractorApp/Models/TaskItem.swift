import Foundation

/// A compliance task assigned to the current worker for a client site — the "Content type/Task"
/// card in the Figma file (e.g. "Alcoa", "2025 Q2 United Rentals Pellet Plant").
public struct TaskItem: Identifiable, Hashable, Codable {
    public let id: UUID
    public var siteName: String
    public var dateRange: String
    public var referenceCode: String
    public var status: ComplianceStatus
    public var completionPercent: Int
    public var assignedCount: Int

    public init(
        id: UUID = UUID(),
        siteName: String,
        dateRange: String,
        referenceCode: String,
        status: ComplianceStatus,
        completionPercent: Int,
        assignedCount: Int = 0
    ) {
        self.id = id
        self.siteName = siteName
        self.dateRange = dateRange
        self.referenceCode = referenceCode
        self.status = status
        self.completionPercent = completionPercent
        self.assignedCount = assignedCount
    }
}

public enum TaskFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case compliant = "Compliant"
    case expiring = "Expiring"
    case notCompliant = "Not compliant"

    public var id: String { rawValue }

    public func matches(_ task: TaskItem) -> Bool {
        switch self {
        case .all: return true
        case .compliant: return task.status == .compliant
        case .expiring: return task.status == .expiring
        case .notCompliant: return task.status == .notCompliant
        }
    }
}
