import SwiftUI

/// Transcribed from "Elearning / Course": duration + status row, title, provider, expiry +
/// attempts remaining, a "Start course" button, and the course body text.
public struct CourseDetailView: View {
    public let course: Course

    @State private var isPresentingPlayer = false

    public init(course: Course) {
        self.course = course
    }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: SCSpacing.medium) {
                HStack(spacing: SCSpacing.small) {
                    Label(course.durationText, systemImage: "clock")
                    Spacer()
                    Text(course.status.label)
                }
                .font(SCTypography.caption)
                .foregroundStyle(SCColor.textSecondary)

                Text(course.title)
                    .font(SCTypography.h2)
                Text(course.provider)
                    .font(SCTypography.h6)
                    .foregroundStyle(SCColor.textSecondary)

                HStack {
                    Label("Expires \(course.expiresOn)", systemImage: "calendar")
                    Spacer()
                    Text("\(course.attemptsRemaining) attempts remaining")
                }
                .font(SCTypography.caption)
                .foregroundStyle(SCColor.textPrimary)

                Divider()

                Button("Start course") { isPresentingPlayer = true }
                    .buttonStyle(.borderedProminent)
                    .tint(SCBlue._600)
                    .frame(maxWidth: .infinity)

                Text(course.summary)
                    .font(SCTypography.body1)
                    .foregroundStyle(SCColor.textPrimary)
            }
            .padding(SCSpacing.standard)
        }
        .navigationTitle(course.title)
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .sheet(isPresented: $isPresentingPlayer) {
            CoursePlayerView(course: course)
        }
    }
}
