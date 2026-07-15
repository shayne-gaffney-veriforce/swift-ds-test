import SwiftUI

/// Transcribed from "Elearning / list".
public struct ElearningListView: View {
    @EnvironmentObject private var store: AppStore
    @State private var searchText = ""

    public init() {}

    private var filteredCourses: [Course] {
        store.courses.filter { searchText.isEmpty || $0.title.localizedCaseInsensitiveContains(searchText) }
    }

    public var body: some View {
        Group {
            if filteredCourses.isEmpty {
                EmptyStateView("No results for \u{201C}\(searchText)\u{201D}. Try adjusting your search.")
            } else {
                List(filteredCourses) { course in
                    NavigationLink(value: course.id) {
                        CourseCard(course: course)
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: SCSpacing.tight, leading: SCSpacing.standard, bottom: SCSpacing.tight, trailing: SCSpacing.standard))
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
        }
        .searchable(text: $searchText, prompt: "Search courses")
        .background(SCColor.surfaceDefault)
        .navigationTitle("Elearning")
        .navigationDestination(for: UUID.self) { id in
            if let course = store.courses.first(where: { $0.id == id }) {
                CourseDetailView(course: course)
            }
        }
    }
}
