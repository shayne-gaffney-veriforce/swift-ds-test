import SwiftUI

/// Transcribed from "Notifications / All" and "Notifications / Unread" — one screen with a
/// segmented filter rather than two separate screens.
public struct NotificationsView: View {
    @EnvironmentObject private var store: AppStore
    @State private var showUnreadOnly = false

    public init() {}

    private var filtered: [AppNotification] {
        showUnreadOnly ? store.notifications.filter { !$0.isRead } : store.notifications
    }

    public var body: some View {
        VStack(spacing: SCSpacing.standard) {
            Picker("Filter", selection: $showUnreadOnly) {
                Text("All").tag(false)
                Text("Unread").tag(true)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, SCSpacing.standard)
            .padding(.top, SCSpacing.small)

            if filtered.isEmpty {
                EmptyStateView("You're all caught up.")
                Spacer()
            } else {
                List(filtered) { notification in
                    NavigationLink(value: notification.id) {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(notification.title)
                                    .font(notification.isRead ? SCTypography.body1 : SCTypography.subtitle1)
                                Spacer()
                                if !notification.isRead {
                                    Circle().fill(SCColor.primary).frame(width: 8, height: 8)
                                }
                            }
                            Text("\(notification.clientName) \u{00B7} \(notification.timeAgo)")
                                .font(SCTypography.caption)
                                .foregroundStyle(SCColor.textSecondary)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .background(SCColor.surfaceDefault)
        .navigationTitle("Notifications")
        .navigationDestination(for: UUID.self) { id in
            if let notification = store.notifications.first(where: { $0.id == id }) {
                NotificationDetailView(notification: notification)
            }
        }
    }
}
