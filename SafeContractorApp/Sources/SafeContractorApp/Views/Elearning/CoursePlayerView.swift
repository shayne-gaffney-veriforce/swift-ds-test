import SwiftUI

/// The Figma frame for this screen ("Elearning / Course / Player") was left empty in the source
/// file — this is a minimal stub, not a transcription.
public struct CoursePlayerView: View {
    public let course: Course
    @Environment(\.dismiss) private var dismiss

    public init(course: Course) {
        self.course = course
    }

    public var body: some View {
        NavigationStack {
            VStack(spacing: SCSpacing.standard) {
                Spacer()
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(SCColor.primary)
                Text(course.title)
                    .font(SCTypography.h4)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding(SCSpacing.standard)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }
}
