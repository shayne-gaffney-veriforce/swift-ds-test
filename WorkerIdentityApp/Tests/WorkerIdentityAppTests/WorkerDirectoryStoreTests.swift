import XCTest
@testable import WorkerIdentityApp

@MainActor
final class WorkerDirectoryStoreTests: XCTestCase {
    private func makeStore() -> (store: WorkerDirectoryStore, contractorA: Contractor, contractorB: Contractor) {
        let contractorA = Contractor(name: "Contractor A")
        let contractorB = Contractor(name: "Contractor B")
        let store = WorkerDirectoryStore(contractors: [contractorA, contractorB])
        return (store, contractorA, contractorB)
    }

    func testAddWorkerCreatesRecordAndAssociation() throws {
        let (store, contractorA, _) = makeStore()

        let worker = try store.addWorker(
            firstName: "Jamie",
            lastName: "Lee",
            primaryEmail: "jamie.lee@example.com",
            dateOfBirth: Date(),
            employeeID: "A-001",
            contractorID: contractorA.id,
            actorDescription: "Contractor A Admin"
        )

        XCTAssertEqual(store.workers.count, 1)
        XCTAssertEqual(store.associations(forWorker: worker.id).count, 1)
        XCTAssertEqual(store.associations(forWorker: worker.id).first?.contractorID, contractorA.id)
    }

    func testAddingDuplicateEmailLinksExistingWorkerInsteadOfCreatingSecondRecord() throws {
        let (store, contractorA, contractorB) = makeStore()

        let original = try store.addWorker(
            firstName: "Jamie",
            lastName: "Lee",
            primaryEmail: "jamie.lee@example.com",
            dateOfBirth: Date(),
            employeeID: "A-001",
            contractorID: contractorA.id,
            actorDescription: "Contractor A Admin"
        )

        XCTAssertThrowsError(
            try store.addWorker(
                firstName: "Jamie",
                lastName: "Lee",
                primaryEmail: "jamie.lee@example.com",
                dateOfBirth: Date(),
                employeeID: "B-777",
                contractorID: contractorB.id,
                actorDescription: "Contractor B Admin"
            )
        ) { error in
            guard case WorkerDirectoryError.existingWorkerLinked(let existing, _) = error else {
                return XCTFail("expected existingWorkerLinked, got \(error)")
            }
            XCTAssertEqual(existing.id, original.id)
        }

        // Still one identity record — linked, not merged/duplicated.
        XCTAssertEqual(store.workers.count, 1)
        XCTAssertEqual(store.associations(forWorker: original.id).count, 2)
        XCTAssertTrue(store.associations(forWorker: original.id).contains { $0.contractorID == contractorB.id })
    }

    func testUpdateWorkerLogsEachChangedField() throws {
        let (store, contractorA, _) = makeStore()
        let worker = try store.addWorker(
            firstName: "Jamie",
            lastName: "Lee",
            primaryEmail: "jamie.lee@example.com",
            dateOfBirth: Date(),
            employeeID: "A-001",
            contractorID: contractorA.id,
            actorDescription: "Contractor A Admin"
        )

        var updated = worker
        updated.jobTitle = "Foreman"
        updated.lastName = "Lee-Martinez"
        updated.hireDate = Date(timeIntervalSince1970: 1_700_000_000)
        store.updateWorker(updated, actorDescription: "Contractor A Admin")

        let log = store.changeLog(forWorker: worker.id)
        XCTAssertTrue(log.contains { $0.field == "Last name" && $0.newValue == "Lee-Martinez" })
        XCTAssertTrue(log.contains { $0.field == "Hire date" })
        XCTAssertEqual(store.worker(worker.id)?.jobTitle, "Foreman")
    }

    func testAddWorkerPersistsLast4SSNAndCandidateID() throws {
        let (store, contractorA, _) = makeStore()

        let worker = try store.addWorker(
            firstName: "Jamie",
            lastName: "Lee",
            primaryEmail: "jamie.lee@example.com",
            dateOfBirth: Date(),
            employeeID: "A-001",
            contractorID: contractorA.id,
            last4SSN: "1234",
            candidateID: "VS-999",
            actorDescription: "Contractor A Admin"
        )

        XCTAssertEqual(store.worker(worker.id)?.last4SSN, "1234")
        XCTAssertEqual(store.worker(worker.id)?.candidateID, "VS-999")
    }

    func testAddingEmailAlreadyOnRosterIsNoOpButUpdatesEmployeeID() throws {
        let (store, contractorA, _) = makeStore()

        let original = try store.addWorker(
            firstName: "Jamie",
            lastName: "Lee",
            primaryEmail: "jamie.lee@example.com",
            dateOfBirth: Date(),
            employeeID: "A-001",
            contractorID: contractorA.id,
            actorDescription: "Contractor A Admin"
        )

        XCTAssertThrowsError(
            try store.addWorker(
                firstName: "Jamie",
                lastName: "Lee",
                primaryEmail: "jamie.lee@example.com",
                dateOfBirth: Date(),
                employeeID: "A-001-CORRECTED",
                contractorID: contractorA.id,
                actorDescription: "Contractor A Admin"
            )
        ) { error in
            guard case WorkerDirectoryError.existingWorkerAlreadyOnRoster(let existing) = error else {
                return XCTFail("expected existingWorkerAlreadyOnRoster, got \(error)")
            }
            XCTAssertEqual(existing.id, original.id)
        }

        // No duplicate association was created, but the employee ID correction was applied.
        XCTAssertEqual(store.associations(forWorker: original.id).count, 1)
        XCTAssertEqual(store.associations(forWorker: original.id).first?.employeeID, "A-001-CORRECTED")
    }

    func testDeactivateIsReversibleAndRetainsData() throws {
        let (store, contractorA, _) = makeStore()
        let worker = try store.addWorker(
            firstName: "Jamie",
            lastName: "Lee",
            primaryEmail: "jamie.lee@example.com",
            dateOfBirth: Date(),
            employeeID: "A-001",
            contractorID: contractorA.id,
            actorDescription: "Contractor A Admin"
        )
        let association = store.associations(forWorker: worker.id)[0]

        store.setAssociationStatus(association.id, status: .inactive, actorDescription: "Contractor A Admin")
        XCTAssertEqual(store.associations(forWorker: worker.id).first?.status, .inactive)
        XCTAssertNotNil(store.worker(worker.id)) // data retained

        store.setAssociationStatus(association.id, status: .active, actorDescription: "Contractor A Admin")
        XCTAssertEqual(store.associations(forWorker: worker.id).first?.status, .active)
    }

    func testInvitationExpiresAfterSevenDaysAndResendResetsExpiry() throws {
        let (store, contractorA, _) = makeStore()
        let worker = try store.addWorker(
            firstName: "Jamie",
            lastName: "Lee",
            primaryEmail: "jamie.lee@example.com",
            dateOfBirth: Date(),
            employeeID: "A-001",
            contractorID: contractorA.id,
            actorDescription: "Contractor A Admin"
        )

        let invitation = store.inviteWorker(worker.id, contractorID: contractorA.id, actorDescription: "Contractor A Admin")
        XCTAssertFalse(invitation.isExpired(asOf: invitation.sentAt.addingTimeInterval(6 * 24 * 60 * 60)))
        XCTAssertTrue(invitation.isExpired(asOf: invitation.sentAt.addingTimeInterval(8 * 24 * 60 * 60)))

        store.resendInvitation(invitation.id, actorDescription: "Contractor A Admin")
        let resent = store.pendingInvitation(forWorker: worker.id, contractorID: contractorA.id)
        XCTAssertEqual(resent?.resendCount, 1)
        XCTAssertFalse(resent?.isExpired(asOf: Date()) ?? true)
    }

    func testPlatformAdminCanLinkAndUnlinkAssociations() throws {
        let (store, contractorA, contractorB) = makeStore()
        let worker = try store.addWorker(
            firstName: "Jamie",
            lastName: "Lee",
            primaryEmail: "jamie.lee@example.com",
            dateOfBirth: Date(),
            employeeID: "A-001",
            contractorID: contractorA.id,
            actorDescription: "Contractor A Admin"
        )

        let newAssociation = store.linkWorker(worker.id, toContractor: contractorB.id, employeeID: "B-500", actorDescription: "Platform Admin")
        XCTAssertEqual(store.associations(forWorker: worker.id).count, 2)

        store.unlinkAssociation(newAssociation.id, actorDescription: "Platform Admin")
        XCTAssertEqual(store.associations(forWorker: worker.id).count, 1)
    }
}
