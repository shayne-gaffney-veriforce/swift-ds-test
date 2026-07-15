import Foundation
import Combine

/// Stands in for the SafeContractor backend: an in-memory, seeded source of truth for the signed-in
/// worker's profile, tasks, gate access, e-learning, file records, and notifications. Nothing here
/// persists across launches (deliberate scope decision, matching WorkerIdentityApp's store).
@MainActor
public final class AppStore: ObservableObject {
    @Published public var profile: UserProfile
    @Published public var tasks: [TaskItem]
    @Published public var gateAccess: [GateAccessRecord]
    @Published public var courses: [Course]
    @Published public var fileRecords: [MyFileRecord]
    @Published public var notifications: [AppNotification]
    @Published public var isSignedIn = false

    public init(
        profile: UserProfile,
        tasks: [TaskItem] = [],
        gateAccess: [GateAccessRecord] = [],
        courses: [Course] = [],
        fileRecords: [MyFileRecord] = [],
        notifications: [AppNotification] = []
    ) {
        self.profile = profile
        self.tasks = tasks
        self.gateAccess = gateAccess
        self.courses = courses
        self.fileRecords = fileRecords
        self.notifications = notifications
    }

    public func markNotificationRead(_ id: UUID) {
        guard let index = notifications.firstIndex(where: { $0.id == id }) else { return }
        notifications[index].isRead = true
    }
}
