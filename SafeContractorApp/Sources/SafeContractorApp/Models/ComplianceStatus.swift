import SwiftUI

/// Shared compliance/status vocabulary reused across Tasks, Gate Access, and My File cards —
/// mirrors the "Content type" card variants and "Circle icons" status set in the Figma file's
/// component library (💠 Components page).
public enum ComplianceStatus: String, CaseIterable, Codable {
    case compliant
    case expiring
    case notCompliant
    case pending
    case blocked

    public var label: String {
        switch self {
        case .compliant: return "Compliant"
        case .expiring: return "Expiring"
        case .notCompliant: return "Not compliant"
        case .pending: return "Pending"
        case .blocked: return "Blocked"
        }
    }

    public var systemImage: String {
        switch self {
        case .compliant: return "checkmark.circle.fill"
        case .expiring: return "clock.fill"
        case .notCompliant: return "xmark.circle.fill"
        case .pending: return "hourglass"
        case .blocked: return "nosign"
        }
    }

    public var tint: Color {
        switch self {
        case .compliant: return SCColor.successText
        case .expiring: return SCColor.warningText
        case .notCompliant, .blocked: return SCColor.criticalText
        case .pending: return SCColor.textTertiary
        }
    }

    public var background: Color {
        switch self {
        case .compliant: return SCColor.successBg
        case .expiring: return SCColor.warningBg
        case .notCompliant, .blocked: return SCColor.criticalBg
        case .pending: return SCColor.neutralBg
        }
    }
}
