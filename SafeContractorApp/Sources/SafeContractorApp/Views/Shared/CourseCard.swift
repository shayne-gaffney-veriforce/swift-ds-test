import SwiftUI

/// Matches the "E-Learning Employee row" / "Content type" card: title, provider, duration, and a
/// status label.
public struct CourseCard: View {
    public let course: Course

    public init(course: Course) {
        self.course = course
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: SCSpacing.small) {
            HStack(spacing: SCSpacing.small) {
                Image(systemName: "clock")
                    .foregroundStyle(SCColor.textSecondary)
                Text(course.durationText)
                    .font(SCTypography.caption)
                    .foregroundStyle(SCColor.textSecondary)
                Spacer()
                Text(course.status.label)
                    .font(SCTypography.caption.weight(.semibold))
            }
            Text(course.title)
                .font(SCTypography.h5)
                .foregroundStyle(SCColor.textPrimary)
            Text(course.provider)
                .font(SCTypography.subtitle2)
                .foregroundStyle(SCColor.textSecondary)
        }
        .padding(SCSpacing.standard)
        .background(SCColor.surfaceElevated)
        .clipShape(RoundedRectangle(cornerRadius: SCRadius.card))
    }
}
