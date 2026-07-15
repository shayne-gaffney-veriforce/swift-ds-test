import Foundation

/// Who "owns" (is the source of) a given field's value — used purely to label fields in the UI
/// (e.g. "set by contractor"). Editability rules live in `Permissions`, since a few fields
/// (like primary email or candidate ID) become read-only under conditions that ownership alone
/// doesn't capture.
public enum FieldOwner: String {
    case contractor = "Contractor"
    case worker = "Worker"
    case contractorAndWorker = "Contractor / Worker"
    case system = "System"
    case systemAndWorker = "System / Worker"
}
