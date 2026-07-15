import XCTest
@testable import SafeContractorApp

@MainActor
final class AppStoreTests: XCTestCase {
    func testSeededStoreHasContentForEveryScreen() {
        let store = AppStore.seeded()

        XCTAssertFalse(store.tasks.isEmpty)
        XCTAssertFalse(store.gateAccess.isEmpty)
        XCTAssertFalse(store.courses.isEmpty)
        XCTAssertFalse(store.fileRecords.isEmpty)
        XCTAssertFalse(store.notifications.isEmpty)
        XCTAssertFalse(store.isSignedIn)
    }

    func testTaskFilterMatchesOnlyItsOwnStatus() {
        let compliant = TaskItem(siteName: "A", dateRange: "-", referenceCode: "-", status: .compliant, completionPercent: 100)
        let expiring = TaskItem(siteName: "B", dateRange: "-", referenceCode: "-", status: .expiring, completionPercent: 80)

        XCTAssertTrue(TaskFilter.all.matches(compliant))
        XCTAssertTrue(TaskFilter.compliant.matches(compliant))
        XCTAssertFalse(TaskFilter.compliant.matches(expiring))
        XCTAssertTrue(TaskFilter.expiring.matches(expiring))
    }

    func testMarkNotificationReadUpdatesOnlyThatNotification() {
        let store = AppStore.seeded()
        let first = store.notifications[0]
        let second = store.notifications[1]

        store.markNotificationRead(first.id)

        XCTAssertTrue(store.notifications[0].isRead)
        XCTAssertEqual(store.notifications[1].isRead, second.isRead)
    }

    func testMyFileViewFiltersByCategoryRawValue() {
        let store = AppStore.seeded()
        let qualifications = store.fileRecords.filter { $0.category == MyFileCategory.qualifications.rawValue }
        let training = store.fileRecords.filter { $0.category == MyFileCategory.training.rawValue }

        XCTAssertFalse(qualifications.isEmpty)
        XCTAssertFalse(training.isEmpty)
        XCTAssertEqual(qualifications.count + training.count, store.fileRecords.count)
    }
}
