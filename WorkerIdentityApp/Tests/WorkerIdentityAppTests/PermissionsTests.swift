import XCTest
@testable import WorkerIdentityApp

@MainActor
final class PermissionsTests: XCTestCase {
    private func makeWorker(candidateID: String? = nil) -> Worker {
        Worker(firstName: "Jamie", lastName: "Lee", primaryEmail: "jamie.lee@example.com", dateOfBirth: Date(), candidateID: candidateID)
    }

    func testContractorAdminCannotEditWorkerOwnedOrImmutableFields() {
        let contractor = Contractor(name: "Contractor A")
        let worker = makeWorker()
        let actor = CurrentActor.contractorAdmin(contractor)

        XCTAssertTrue(Permissions.canEditIdentityField(.firstName, on: worker, as: actor))
        XCTAssertTrue(Permissions.canEditIdentityField(.dateOfBirth, on: worker, as: actor))
        XCTAssertFalse(Permissions.canEditIdentityField(.primaryEmail, on: worker, as: actor))
        XCTAssertFalse(Permissions.canEditIdentityField(.phone, on: worker, as: actor))
        XCTAssertFalse(Permissions.canEditIdentityField(.address, on: worker, as: actor))
    }

    func testCandidateIDBecomesReadOnlyOnceSet() {
        let contractor = Contractor(name: "Contractor A")
        let actor = CurrentActor.contractorAdmin(contractor)

        XCTAssertTrue(Permissions.canEditIdentityField(.candidateID, on: makeWorker(candidateID: nil), as: actor))
        XCTAssertFalse(Permissions.canEditIdentityField(.candidateID, on: makeWorker(candidateID: "VS-1"), as: actor))
    }

    func testWorkerCanOnlyEditContactFieldsOnTheirOwnRecord() {
        let worker = makeWorker()
        let actor = CurrentActor.worker(worker)

        XCTAssertTrue(Permissions.canEditIdentityField(.phone, on: worker, as: actor))
        XCTAssertTrue(Permissions.canEditIdentityField(.alternateEmail, on: worker, as: actor))
        XCTAssertTrue(Permissions.canEditIdentityField(.address, on: worker, as: actor))
        XCTAssertFalse(Permissions.canEditIdentityField(.firstName, on: worker, as: actor))
        XCTAssertFalse(Permissions.canEditIdentityField(.dateOfBirth, on: worker, as: actor))
        XCTAssertFalse(Permissions.canEditIdentityField(.primaryEmail, on: worker, as: actor))
    }

    func testWorkerCannotEditAnotherWorkersRecord() {
        let worker = makeWorker()
        let someoneElse = makeWorker()
        let actor = CurrentActor.worker(someoneElse)

        XCTAssertFalse(Permissions.canEditIdentityField(.phone, on: worker, as: actor))
    }

    func testPlatformAdminCanEditEverything() {
        let worker = makeWorker(candidateID: "VS-1")
        let actor = CurrentActor.platformAdmin

        for field in WorkerField.allCases {
            XCTAssertTrue(Permissions.canEditIdentityField(field, on: worker, as: actor), "expected platform admin to edit \(field)")
        }
    }

    func testContractorAdminOnlySeesWorkersAssociatedWithTheirOwnContractor() {
        let contractorA = Contractor(name: "Contractor A")
        let contractorB = Contractor(name: "Contractor B")
        let store = WorkerDirectoryStore(contractors: [contractorA, contractorB])

        let shared = try! store.addWorker(
            firstName: "Riley", lastName: "Chen", primaryEmail: "riley@example.com",
            dateOfBirth: Date(), employeeID: "A-1", contractorID: contractorA.id, actorDescription: "test"
        )
        store.linkWorker(shared.id, toContractor: contractorB.id, employeeID: "B-1", actorDescription: "test")

        let onlyInA = try? store.addWorker(
            firstName: "Priya", lastName: "N", primaryEmail: "priya@example.com",
            dateOfBirth: Date(), employeeID: "A-2", contractorID: contractorA.id, actorDescription: "test"
        )

        let visibleToA = Permissions.visibleWorkers(in: store, for: .contractorAdmin(contractorA))
        let visibleToB = Permissions.visibleWorkers(in: store, for: .contractorAdmin(contractorB))

        XCTAssertTrue(visibleToA.contains { $0.id == shared.id })
        XCTAssertTrue(visibleToA.contains { $0.id == onlyInA?.id })
        XCTAssertTrue(visibleToB.contains { $0.id == shared.id })
        XCTAssertFalse(visibleToB.contains { $0.id == onlyInA?.id })
    }

    func testContractorAdminNeverSeesAnotherContractorsAssociationForASharedWorker() {
        let contractorA = Contractor(name: "Contractor A")
        let contractorB = Contractor(name: "Contractor B")
        let store = WorkerDirectoryStore(contractors: [contractorA, contractorB])

        let shared = try! store.addWorker(
            firstName: "Riley", lastName: "Chen", primaryEmail: "riley@example.com",
            dateOfBirth: Date(), employeeID: "A-1", contractorID: contractorA.id, actorDescription: "test"
        )
        store.linkWorker(shared.id, toContractor: contractorB.id, employeeID: "B-1", actorDescription: "test")

        let associationsVisibleToA = Permissions.visibleAssociations(for: shared, as: .contractorAdmin(contractorA), in: store)
        XCTAssertEqual(associationsVisibleToA.count, 1)
        XCTAssertEqual(associationsVisibleToA.first?.contractorID, contractorA.id)
    }

    func testWorkerActorCannotSeeAnotherWorkersAssociations() {
        let contractorA = Contractor(name: "Contractor A")
        let store = WorkerDirectoryStore(contractors: [contractorA])

        let worker = try! store.addWorker(
            firstName: "Riley", lastName: "Chen", primaryEmail: "riley@example.com",
            dateOfBirth: Date(), employeeID: "A-1", contractorID: contractorA.id, actorDescription: "test"
        )
        let someoneElse = try! store.addWorker(
            firstName: "Priya", lastName: "N", primaryEmail: "priya@example.com",
            dateOfBirth: Date(), employeeID: "A-2", contractorID: contractorA.id, actorDescription: "test"
        )

        // Someone else's worker session should see nothing when asked about Riley's associations.
        let visibleToSomeoneElse = Permissions.visibleAssociations(for: worker, as: .worker(someoneElse), in: store)
        XCTAssertTrue(visibleToSomeoneElse.isEmpty)

        // Riley's own session sees their own associations.
        let visibleToSelf = Permissions.visibleAssociations(for: worker, as: .worker(worker), in: store)
        XCTAssertEqual(visibleToSelf.count, 1)
    }
}
