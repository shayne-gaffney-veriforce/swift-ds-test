import Foundation

/// An announcement/notification from a hiring client — the "Notifications / View" article screen.
public struct AppNotification: Identifiable, Hashable, Codable {
    public let id: UUID
    public var title: String
    public var clientName: String
    public var timeAgo: String
    public var subtitle: String
    public var body: String
    public var attachmentNames: [String]
    public var requiresAcknowledgement: Bool
    public var isRead: Bool

    public init(
        id: UUID = UUID(),
        title: String,
        clientName: String,
        timeAgo: String,
        subtitle: String,
        body: String,
        attachmentNames: [String] = [],
        requiresAcknowledgement: Bool = false,
        isRead: Bool = false
    ) {
        self.id = id
        self.title = title
        self.clientName = clientName
        self.timeAgo = timeAgo
        self.subtitle = subtitle
        self.body = body
        self.attachmentNames = attachmentNames
        self.requiresAcknowledgement = requiresAcknowledgement
        self.isRead = isRead
    }
}
