import Foundation

public struct UserProfile: Identifiable, Hashable, Codable {
    public let id: UUID
    public var firstName: String
    public var lastName: String
    public var jobTitle: String
    public var dateOfBirth: String
    public var email: String
    public var username: String
    public var phone: String
    public var extensionNumber: String
    public var address: String
    public var city: String
    public var postalCode: String
    public var country: String
    public var workerCardID: String

    public var fullName: String { "\(firstName) \(lastName)" }

    public init(
        id: UUID = UUID(),
        firstName: String,
        lastName: String,
        jobTitle: String,
        dateOfBirth: String,
        email: String,
        username: String,
        phone: String,
        extensionNumber: String,
        address: String,
        city: String,
        postalCode: String,
        country: String,
        workerCardID: String
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.jobTitle = jobTitle
        self.dateOfBirth = dateOfBirth
        self.email = email
        self.username = username
        self.phone = phone
        self.extensionNumber = extensionNumber
        self.address = address
        self.city = city
        self.postalCode = postalCode
        self.country = country
        self.workerCardID = workerCardID
    }
}
