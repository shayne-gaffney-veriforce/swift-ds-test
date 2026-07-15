import SwiftUI

/// Transcribed from the "Task / All", "Task / Compliant", "Task / Compliant (Expiring)", and
/// "Task / Not compliant" frames — one screen with a segmented filter rather than four separate
/// screens, since they're state variants of the same list.
public struct TasksView: View {
    @EnvironmentObject private var store: AppStore
    @State private var filter: TaskFilter = .all
    @State private var searchText = ""

    public init() {}

    private var filteredTasks: [TaskItem] {
        store.tasks
            .filter(filter.matches)
            .filter { searchText.isEmpty || $0.siteName.localizedCaseInsensitiveContains(searchText) }
    }

    public var body: some View {
        VStack(spacing: SCSpacing.standard) {
            Picker("Filter", selection: $filter) {
                ForEach(TaskFilter.allCases) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, SCSpacing.standard)
            .padding(.top, SCSpacing.small)

            if filteredTasks.isEmpty {
                EmptyStateView("You don't currently have any tasks of this type")
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: SCSpacing.standard) {
                        ForEach(filteredTasks) { task in
                            SiteRecordCard(title: task.siteName, dateRange: task.dateRange, referenceCode: task.referenceCode, status: task.status, trailingText: "\(task.completionPercent)%")
                        }
                    }
                    .padding(SCSpacing.standard)
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search tasks")
        .background(SCColor.surfaceDefault)
        .navigationTitle("Tasks")
    }
}
