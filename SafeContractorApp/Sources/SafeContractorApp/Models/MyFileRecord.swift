import Foundation

public enum MyFileCategory: String, CaseIterable, Identifiable {
    case qualifications = "Qualifications"
    case training = "Training"

    public var id: String { rawValue }
}

/// A qualification or training record on the worker's professional file ("My File").
public struct MyFileRecord: Identifiable, Hashable, Codable {
    public let id: UUID
    public var category: MyFileCategory.RawValue
    public var title: String
    public var clientName: String
    public var status: ComplianceStatus
    public var expiresOn: String?

    public init(
        id: UUID = UUID(),
        category: MyFileCategory,
        title: String,
        clientName: String,
        status: ComplianceStatus,
        expiresOn: String? = nil
    ) {
        self.id = id
        self.category = category.rawValue
        self.title = title
        self.clientName = clientName
        self.status = status
        self.expiresOn = expiresOn
    }
}
