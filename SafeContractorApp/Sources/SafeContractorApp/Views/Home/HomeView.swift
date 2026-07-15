import SwiftUI

/// Transcribed from "Home / Employee (All content)": a brand-navy greeting header, two quick
/// action buttons, an announcement card, an e-learning section, and a tasks section.
public struct HomeView: View {
    @EnvironmentObject private var store: AppStore
    @State private var isPresentingQRCode = false

    public init() {}

    private var latestNotification: AppNotification? { store.notifications.first }
    private var topCourse: Course? { store.courses.first }
    private var topTask: TaskItem? { store.tasks.first }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: SCSpacing.large) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Hi, \(store.profile.firstName)")
                        .font(SCTypography.h3)
                    Text(store.profile.jobTitle)
                        .font(SCTypography.body1)
                }
                .foregroundStyle(SCColor.textInverse)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(SCSpacing.standard)
                .background(SCColor.brandNavy)

                HStack(spacing: SCSpacing.medium) {
                    Button {
                        isPresentingQRCode = true
                    } label: {
                        Label("My QR code", systemImage: "qrcode")
                            .frame(maxWidth: .infinity)
                    }
                    NavigationLink(value: HomeRoute.gateAccess) {
                        Label("Gate Access", systemImage: "lock.open.fill")
                            .frame(maxWidth: .infinity)
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(SCBlue._600)
                .padding(.horizontal, SCSpacing.standard)

                if let latestNotification {
                    VStack(alignment: .leading, spacing: SCSpacing.small) {
                        SectionHeader("Announcements", actionTitle: "See all") { }
                        NavigationLink(value: HomeRoute.notification(latestNotification.id)) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(latestNotification.title)
                                    .font(SCTypography.subtitle1)
                                    .foregroundStyle(SCColor.textPrimary)
                                Text(latestNotification.clientName)
                                    .font(SCTypography.caption)
                                    .foregroundStyle(SCColor.textSecondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(SCSpacing.standard)
                            .background(SCColor.surfaceElevated)
                            .clipShape(RoundedRectangle(cornerRadius: SCRadius.card))
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, SCSpacing.standard)
                }

                if let topCourse {
                    VStack(alignment: .leading, spacing: SCSpacing.small) {
                        SectionHeader("E-Learning", actionTitle: "See all") { }
                        NavigationLink(value: HomeRoute.course(topCourse.id)) {
                            CourseCard(course: topCourse)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, SCSpacing.standard)
                }

                if let topTask {
                    VStack(alignment: .leading, spacing: SCSpacing.small) {
                        SectionHeader("Tasks", actionTitle: "See all") { }
                        SiteRecordCard(title: topTask.siteName, dateRange: topTask.dateRange, referenceCode: topTask.referenceCode, status: topTask.status, trailingText: "\(topTask.completionPercent)%")
                    }
                    .padding(.horizontal, SCSpacing.standard)
                }
            }
            .padding(.bottom, SCSpacing.large)
        }
        .background(SCColor.surfaceDefault)
        .navigationTitle("Home")
        .navigationDestination(for: HomeRoute.self) { route in
            switch route {
            case .gateAccess:
                GateAccessView()
            case .course(let id):
                if let course = store.courses.first(where: { $0.id == id }) {
                    CourseDetailView(course: course)
                }
            case .notification(let id):
                if let notification = store.notifications.first(where: { $0.id == id }) {
                    NotificationDetailView(notification: notification)
                }
            }
        }
        .sheet(isPresented: $isPresentingQRCode) {
            MyQRCodeView()
        }
    }
}

enum HomeRoute: Hashable {
    case gateAccess
    case course(UUID)
    case notification(UUID)
}
