import Foundation

/// The canonical GWN worker identity record.
///
/// `employeeId` and `status` are intentionally NOT here — the spec calls them out as scoped
/// per contractor relationship, so they live on `ContractorWorkerAssociation` instead.
public struct Worker: Identifiable, Hashable, Codable {
    /// gwn_worker_id — globally unique, immutable, used as the FK Phase 2 (EMM) training records join on.
    public let id: UUID

    public var firstName: String
    public var lastName: String

    /// Used for platform login; unique within GWN. Worker-owned and immutable after creation
    /// (per the resolved Open Question: "Identity email is immutable and controlled by the worker
    /// exclusively") — enforced here as a `let`, so even `Permissions.canEditIdentityField`'s
    /// blanket Platform Admin grant (support use case, see `Permissions`) has nothing to act on:
    /// there is no code path that reassigns this property today.
    public let primaryEmail: String

    public var dateOfBirth: Date
    public var phone: String?

    /// Not in the spec's field table, but the Worker Self-Edit requirement explicitly lists
    /// "alternate email" and "address" as worker-editable — added here to satisfy that P0
    /// acceptance criteria.
    public var alternateEmail: String?
    public var address: String?

    public var jobTitle: String?
    public var hireDate: Date?
    public var profilePhotoURL: String?
    public var last4SSN: String?

    /// Required for migration. Once set, it becomes read-only to Contractor Admins and Workers;
    /// Platform Admin retains edit access for support, per the Access Control Model's blanket
    /// "All fields" grant (see `Permissions`).
    public var candidateID: String?

    public let createdAt: Date
    public var updatedAt: Date

    public var fullName: String {
        "\(firstName) \(lastName)"
    }

    public init(
        id: UUID = UUID(),
        firstName: String,
        lastName: String,
        primaryEmail: String,
        dateOfBirth: Date,
        phone: String? = nil,
        alternateEmail: String? = nil,
        address: String? = nil,
        jobTitle: String? = nil,
        hireDate: Date? = nil,
        profilePhotoURL: String? = nil,
        last4SSN: String? = nil,
        candidateID: String? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.primaryEmail = primaryEmail
        self.dateOfBirth = dateOfBirth
        self.phone = phone
        self.alternateEmail = alternateEmail
        self.address = address
        self.jobTitle = jobTitle
        self.hireDate = hireDate
        self.profilePhotoURL = profilePhotoURL
        self.last4SSN = last4SSN
        self.candidateID = candidateID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
