import Foundation

public enum CourseStatus: String, CaseIterable, Codable {
    case created
    case ongoing
    case ongoingFailed
    case succeeded
    case failed
    case expired

    public var label: String {
        switch self {
        case .created: return "Not started"
        case .ongoing: return "In progress"
        case .ongoingFailed: return "In progress (failed attempt)"
        case .succeeded: return "Completed"
        case .failed: return "Failed"
        case .expired: return "Expired"
        }
    }
}

/// An e-learning course assigned to the worker — the "E-Learning Employee row" / "Content type"
/// card in the Figma file.
public struct Course: Identifiable, Hashable, Codable {
    public let id: UUID
    public var title: String
    public var provider: String
    public var durationText: String
    public var expiresOn: String
    public var attemptsRemaining: Int
    public var status: CourseStatus
    public var summary: String

    public init(
        id: UUID = UUID(),
        title: String,
        provider: String,
        durationText: String,
        expiresOn: String,
        attemptsRemaining: Int,
        status: CourseStatus,
        summary: String
    ) {
        self.id = id
        self.title = title
        self.provider = provider
        self.durationText = durationText
        self.expiresOn = expiresOn
        self.attemptsRemaining = attemptsRemaining
        self.status = status
        self.summary = summary
    }
}
