import Foundation

/// Stands in for real auth (OKTA/VF1 is a separate, not-yet-live initiative per the spec).
/// The role switcher lets a user pick which identity they're "logged in" as.
public enum CurrentActor: Hashable {
    case contractorAdmin(Contractor)
    case worker(Worker)
    case platformAdmin

    public var displayName: String {
        switch self {
        case .contractorAdmin(let contractor):
            return "\(contractor.name) — Admin"
        case .worker(let worker):
            return worker.fullName
        case .platformAdmin:
            return "Platform Admin"
        }
    }
}
