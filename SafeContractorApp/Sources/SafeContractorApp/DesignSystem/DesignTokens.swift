import SwiftUI
import SwiftUIX

// Synced from /guidelines/design-tokens/ and cross-checked against the resolved fill colors in
// "New app layout (MUi version).fig" (✨ New Design (MUI version) page) — the two agree on every
// color sampled, confirming this app and WorkerIdentityApp share one underlying palette.
//
// Uses SwiftUIX's existing Color(hexadecimal:) and Color.adaptable(light:dark:) rather than
// reimplementing hex parsing / light-dark color bridging here.

private func hex(_ hex: String) -> Color {
    Color(hexadecimal: hex)
}

public enum SCGray {
    public static let _50 = hex("#fafafa")
    public static let _100 = hex("#f4f4f5")
    public static let _200 = hex("#e4e4e7")
    public static let _300 = hex("#d4d4d8")
    public static let _400 = hex("#a1a1aa")
    public static let _500 = hex("#71717a")
    public static let _600 = hex("#52525b")
    public static let _700 = hex("#3f3f46")
    public static let _800 = hex("#27272a")
    public static let _900 = hex("#18181b")
}

public enum SCBlue {
    public static let _50 = hex("#eff5ff")
    public static let _100 = hex("#dbe8fd")
    public static let _400 = hex("#719ef9")
    public static let _600 = hex("#215bea")
    public static let _700 = hex("#134bdc") // primary main
    public static let _800 = hex("#123eb0") // primary dark
    public static let _900 = hex("#0d3086") // used for full-bleed brand surfaces (sign-in, onboarding)
}

public enum SCRed {
    public static let _50 = hex("#fef2f2")
    public static let _300 = hex("#fca5a5")
    public static let _700 = hex("#b91c1c")
    public static let _900 = hex("#7f1d1d")
}

public enum SCGreen {
    public static let _50 = hex("#ecfdf5")
    public static let _300 = hex("#6ee7b7")
    public static let _600 = hex("#059669")
    public static let _900 = hex("#064e3b")
}

public enum SCAmber {
    public static let _50 = hex("#fffbeb")
    public static let _300 = hex("#fcd34d")
    public static let _600 = hex("#d97706")
    public static let _900 = hex("#78350f")
}

/// Semantic colors, mode-adaptive, built on the scales above.
public enum SCColor {
    public static let textPrimary = Color.adaptable(light: SCGray._900, dark: SCGray._50)
    public static let textSecondary = Color.adaptable(light: SCGray._600, dark: SCGray._300)
    public static let textTertiary = Color.adaptable(light: SCGray._500, dark: SCGray._400)
    public static let textInverse = Color.adaptable(light: hex("#ffffff"), dark: SCGray._900)

    public static let borderDefault = Color.adaptable(light: SCGray._300, dark: SCGray._600)
    public static let borderSubtle = Color.adaptable(light: SCGray._200, dark: SCGray._700)

    public static let surfaceDefault = Color.adaptable(light: SCGray._50, dark: SCGray._900)
    public static let surfaceElevated = Color.adaptable(light: hex("#ffffff"), dark: SCGray._800)

    /// The primary brand/action color (blue.700).
    public static let primary = SCBlue._700
    /// Full-bleed brand navy used behind onboarding/sign-in art (blue.900).
    public static let brandNavy = SCBlue._900

    public static let successBg = Color.adaptable(light: SCGreen._50, dark: SCGreen._900)
    public static let successText = Color.adaptable(light: SCGreen._600, dark: SCGreen._300)
    public static let successBorder = SCGreen._300

    public static let criticalBg = Color.adaptable(light: SCRed._50, dark: SCRed._900)
    public static let criticalText = Color.adaptable(light: SCRed._700, dark: SCRed._300)
    public static let criticalBorder = SCRed._300

    public static let warningBg = Color.adaptable(light: SCAmber._50, dark: SCAmber._900)
    public static let warningText = Color.adaptable(light: SCAmber._600, dark: SCAmber._300)
    public static let warningBorder = SCAmber._300

    public static let neutralBg = Color.adaptable(light: SCGray._50, dark: SCGray._800)
    public static let neutralText = Color.adaptable(light: SCGray._700, dark: SCGray._300)
    public static let neutralBorder = Color.adaptable(light: SCGray._300, dark: SCGray._700)
}

/// Spacing scale — MUI's 8px base unit, matching `guidelines/design-tokens/spacing.md`.
public enum SCSpacing {
    public static func unit(_ n: CGFloat) -> CGFloat { n * 8 }

    public static let tight: CGFloat = unit(0.5)      // 4pt
    public static let small: CGFloat = unit(1)        // 8pt
    public static let standard: CGFloat = unit(2)     // 16pt
    public static let medium: CGFloat = unit(3)       // 24pt
    public static let large: CGFloat = unit(4)        // 32pt
    public static let section: CGFloat = unit(5)      // 40pt
    public static let largeSection: CGFloat = unit(6) // 48pt
    public static let page: CGFloat = unit(8)         // 64pt
}

public enum SCRadius {
    public static let sm: CGFloat = 4
    public static let button: CGFloat = 6
    public static let card: CGFloat = 8
    public static let input: CGFloat = 8
    public static let full: CGFloat = 9999
}

/// Type scale per `guidelines/design-tokens/typography.md`, cross-checked against the glyph-level
/// font size/weight recorded on text nodes in the Figma file (e.g. the "Sign in" title renders at
/// 32px/500, matching `h2` here exactly). Falls back to the system font at the documented
/// sizes/weights since "Instrument Sans" isn't bundled in this package.
public enum SCTypography {
    public static let h1 = Font.system(size: 48, weight: .medium)
    public static let h2 = Font.system(size: 32, weight: .medium)
    public static let h3 = Font.system(size: 24, weight: .medium)
    public static let h4 = Font.system(size: 20, weight: .medium)
    public static let h5 = Font.system(size: 16, weight: .medium)
    public static let h6 = Font.system(size: 14, weight: .medium)

    public static let body1 = Font.system(size: 16, weight: .regular)
    public static let body2 = Font.system(size: 14, weight: .regular)
    public static let subtitle1 = Font.system(size: 16, weight: .medium)
    public static let subtitle2 = Font.system(size: 14, weight: .medium)
    public static let button = Font.system(size: 14, weight: .medium)
    public static let caption = Font.system(size: 12, weight: .regular)
    public static let overline = Font.system(size: 12, weight: .medium)
}
