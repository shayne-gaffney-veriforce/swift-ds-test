import Foundation

extension WorkerDirectoryStore {
    /// Seed data for demoing the app: three contractors, a handful of workers, one of whom
    /// (Riley Chen) is associated with two contractors at once to exercise the multi-contractor
    /// path and the "contractors can't see each other's association data" access rule.
    public static func seeded() -> WorkerDirectoryStore {
        func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
            Calendar.current.date(from: DateComponents(year: year, month: month, day: day)) ?? Date()
        }

        let acmePipeline = Contractor(name: "Acme Pipeline Services")
        let boreal = Contractor(name: "Boreal Field Solutions")
        let summit = Contractor(name: "Summit Energy Contractors")

        let ana = Worker(
            firstName: "Ana",
            lastName: "Reyes",
            primaryEmail: "ana.reyes@example.com",
            dateOfBirth: date(1990, 4, 12),
            phone: "555-0101",
            jobTitle: "Pipeline Technician",
            hireDate: date(2022, 6, 1),
            candidateID: "VS-10432"
        )

        let marcus = Worker(
            firstName: "Marcus",
            lastName: "Idowu",
            primaryEmail: "marcus.idowu@example.com",
            dateOfBirth: date(1985, 11, 3),
            phone: "555-0102",
            jobTitle: "Site Supervisor",
            hireDate: date(2019, 2, 15)
        )

        let riley = Worker(
            firstName: "Riley",
            lastName: "Chen",
            primaryEmail: "riley.chen@example.com",
            dateOfBirth: date(1993, 8, 21),
            phone: "555-0103",
            jobTitle: "Welding Inspector",
            hireDate: date(2021, 9, 10),
            last4SSN: "6821"
        )

        let priya = Worker(
            firstName: "Priya",
            lastName: "Natarajan",
            primaryEmail: "priya.n@example.com",
            dateOfBirth: date(1997, 1, 30),
            phone: "555-0104",
            jobTitle: "Equipment Operator",
            hireDate: date(2023, 3, 1)
        )

        let associations = [
            ContractorWorkerAssociation(workerID: ana.id, contractorID: acmePipeline.id, employeeID: "ACM-001"),
            ContractorWorkerAssociation(workerID: marcus.id, contractorID: acmePipeline.id, employeeID: "ACM-002"),
            ContractorWorkerAssociation(workerID: riley.id, contractorID: acmePipeline.id, employeeID: "ACM-003"),
            ContractorWorkerAssociation(workerID: riley.id, contractorID: boreal.id, employeeID: "BOR-118"),
            ContractorWorkerAssociation(workerID: priya.id, contractorID: summit.id, employeeID: "SUM-044", status: .inactive)
        ]

        return WorkerDirectoryStore(
            workers: [ana, marcus, riley, priya],
            contractors: [acmePipeline, boreal, summit],
            associations: associations,
            invitations: [],
            changeLog: []
        )
    }
}
