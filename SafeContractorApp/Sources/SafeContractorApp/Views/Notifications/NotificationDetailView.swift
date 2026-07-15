import SwiftUI

/// Transcribed from "Notifications / View": title, client, timestamp, subtitle, body,
/// attachments, and (when required) a read-receipt acknowledgement control.
public struct NotificationDetailView: View {
    @EnvironmentObject private var store: AppStore
    public let notification: AppNotification

    @State private var hasAcknowledged = false

    public init(notification: AppNotification) {
        self.notification = notification
    }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: SCSpacing.medium) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(notification.title)
                        .font(SCTypography.h2)
                    Text(notification.clientName)
                        .font(SCTypography.h5)
                        .foregroundStyle(SCColor.textSecondary)
                    Text(notification.timeAgo)
                        .font(SCTypography.caption)
                        .foregroundStyle(SCColor.textSecondary)
                }

                Text(notification.subtitle)
                    .font(SCTypography.h6)

                Text(notification.body)
                    .font(SCTypography.body1)
                    .foregroundStyle(SCColor.textPrimary)

                if !notification.attachmentNames.isEmpty {
                    VStack(alignment: .leading, spacing: SCSpacing.small) {
                        Text("Attachment")
                            .font(SCTypography.subtitle2)
                        ForEach(notification.attachmentNames, id: \.self) { name in
                            Label(name, systemImage: "paperclip")
                                .font(SCTypography.body1)
                                .foregroundStyle(SCBlue._600)
                        }
                    }
                }

                if notification.requiresAcknowledgement {
                    VStack(alignment: .leading, spacing: SCSpacing.standard) {
                        Toggle("I confirm I have read this announcement", isOn: $hasAcknowledged)
                        Button("Acknowledge") {
                            store.markNotificationRead(notification.id)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(SCColor.primary)
                        .frame(maxWidth: .infinity)
                        .disabled(!hasAcknowledged)
                    }
                    .padding(SCSpacing.standard)
                    .background(SCBlue._50)
                    .clipShape(RoundedRectangle(cornerRadius: SCRadius.card))
                }
            }
            .padding(SCSpacing.standard)
        }
        .navigationTitle("Announcement")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .onAppear {
            store.markNotificationRead(notification.id)
        }
    }
}
