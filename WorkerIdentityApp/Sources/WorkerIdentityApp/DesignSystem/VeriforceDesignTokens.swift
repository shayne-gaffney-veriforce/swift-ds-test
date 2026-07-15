import SwiftUI
import SwiftUIX

// Synced from /guidelines/design-tokens/ (the Veriforce product design system spec — written
// against MUI/React, but the token *values* are the cross-platform source of truth). That spec
// has no Swift output, so these are the documented values transcribed by hand. Re-sync manually
// if /guidelines/design-tokens/ changes.
//
// Uses SwiftUIX's existing Color(hexadecimal:) and Color.adaptable(light:dark:) rather than
// reimplementing hex parsing / light-dark color bridging here.

private func veriforceHex(_ hex: String) -> Color {
    Color(hexadecimal: hex)
}

/// Raw color scales, per `guidelines/design-tokens/colors.md`. Prefer `VeriforceColor` (semantic,
/// light/dark-adaptive) or `VeriforceBrand` (role-based) in views — reach for a scale directly
/// only when neither has what you need.
public enum VeriforceGray {
    public static let _50 = veriforceHex("#fafafa")
    public static let _100 = veriforceHex("#f4f4f5")
    public static let _200 = veriforceHex("#e4e4e7")
    public static let _300 = veriforceHex("#d4d4d8")
    public static let _400 = veriforceHex("#a1a1aa")
    public static let _500 = veriforceHex("#71717a")
    public static let _600 = veriforceHex("#52525b")
    public static let _700 = veriforceHex("#3f3f46")
    public static let _800 = veriforceHex("#27272a")
    public static let _900 = veriforceHex("#18181b")
}

public enum VeriforceInk {
    public static let _50 = veriforceHex("#f5f9fc")
    public static let _100 = veriforceHex("#ecf3f8")
    public static let _200 = veriforceHex("#dee8ef")
    public static let _300 = veriforceHex("#c3d4e0")
    public static let _400 = veriforceHex("#8ba5b8")
    public static let _500 = veriforceHex("#54778f")
    public static let _600 = veriforceHex("#345872")
    public static let _700 = veriforceHex("#1f445c")
    public static let _800 = veriforceHex("#002a42")
    public static let _900 = veriforceHex("#051723")
}

public enum VeriforceBlue {
    public static let _50 = veriforceHex("#eff5ff")
    public static let _100 = veriforceHex("#dbe8fd")
    public static let _200 = veriforceHex("#c2daff")
    public static let _300 = veriforceHex("#94bcff")
    public static let _400 = veriforceHex("#719ef9")
    public static let _500 = veriforceHex("#457cf9")
    public static let _600 = veriforceHex("#215bea")
    public static let _700 = veriforceHex("#134bdc") // primary main
    public static let _800 = veriforceHex("#123eb0") // primary dark
    public static let _900 = veriforceHex("#0d3086")
}

public enum VeriforceRed {
    public static let _50 = veriforceHex("#fef2f2")
    public static let _100 = veriforceHex("#fee2e2")
    public static let _200 = veriforceHex("#fecaca")
    public static let _300 = veriforceHex("#fca5a5")
    public static let _400 = veriforceHex("#f87171") // error light
    public static let _500 = veriforceHex("#ef4444")
    public static let _600 = veriforceHex("#dc2626")
    public static let _700 = veriforceHex("#b91c1c") // error main
    public static let _800 = veriforceHex("#991b1b") // error dark
    public static let _900 = veriforceHex("#7f1d1d")
}

public enum VeriforceGreen {
    public static let _50 = veriforceHex("#ecfdf5")
    public static let _100 = veriforceHex("#d1fae5")
    public static let _200 = veriforceHex("#a7f3d0")
    public static let _300 = veriforceHex("#6ee7b7")
    public static let _400 = veriforceHex("#34d399")
    public static let _500 = veriforceHex("#10b981") // success light
    public static let _600 = veriforceHex("#059669")
    public static let _700 = veriforceHex("#047857") // success main
    public static let _800 = veriforceHex("#065f46") // success dark
    public static let _900 = veriforceHex("#064e3b")
}

public enum VeriforceOrange {
    public static let _50 = veriforceHex("#fff7ed")
    public static let _100 = veriforceHex("#ffedd5")
    public static let _200 = veriforceHex("#fed7aa")
    public static let _300 = veriforceHex("#fdba74")
    public static let _400 = veriforceHex("#fb923c") // warning light
    public static let _500 = veriforceHex("#f97316") // warning main
    public static let _600 = veriforceHex("#ea580c") // warning dark
    public static let _700 = veriforceHex("#c2410c")
    public static let _800 = veriforceHex("#9a3412")
    public static let _900 = veriforceHex("#7c2d12")
}

public enum VeriforceAmber {
    public static let _50 = veriforceHex("#fffbeb")
    public static let _100 = veriforceHex("#fef3c7")
    public static let _200 = veriforceHex("#fde68a")
    public static let _300 = veriforceHex("#fcd34d")
    public static let _400 = veriforceHex("#fbbf24")
    public static let _500 = veriforceHex("#f59e0b")
    public static let _600 = veriforceHex("#d97706")
    public static let _700 = veriforceHex("#b45309")
    public static let _800 = veriforceHex("#92400e")
    public static let _900 = veriforceHex("#78350f")
}

/// Role-based brand palette (light/main/dark) per the "Brand Colors (MUI Palette)" table in
/// `guidelines/design-tokens/colors.md`. Not light/dark-*mode*-adaptive — these are the same
/// three tones regardless of color scheme, for cases that need the MUI light/main/dark triad
/// (e.g. hover/pressed states on a filled control) rather than `VeriforceColor`'s mode-adaptive
/// semantic tokens.
public enum VeriforceBrand {
    public enum Primary {
        public static let light = VeriforceBlue._400
        public static let main = VeriforceBlue._700
        public static let dark = VeriforceBlue._800
    }
    public enum Secondary {
        public static let light = VeriforceGray._300
        public static let main = VeriforceGray._500
        public static let dark = VeriforceGray._700
    }
    public enum Error {
        public static let light = VeriforceRed._400
        public static let main = VeriforceRed._700
        public static let dark = VeriforceRed._800
    }
    public enum Warning {
        public static let light = VeriforceOrange._400
        public static let main = VeriforceOrange._500
        public static let dark = VeriforceOrange._600
    }
    public enum Info {
        public static let light = VeriforceBlue._500
        public static let main = VeriforceBlue._700
        public static let dark = VeriforceBlue._900
    }
    public enum Success {
        public static let light = VeriforceGreen._500
        public static let main = VeriforceGreen._700
        public static let dark = VeriforceGreen._800
    }
}

/// Semantic colors from the Veriforce design system's light/dark themes — mode-adaptive, built on
/// the scales above.
public enum VeriforceColor {
    public static let textPrimary = Color.adaptable(light: VeriforceGray._900, dark: VeriforceGray._50)
    public static let textSecondary = Color.adaptable(light: VeriforceGray._600, dark: VeriforceGray._300)
    public static let textTertiary = Color.adaptable(light: VeriforceGray._500, dark: VeriforceGray._400)
    public static let textInverse = Color.adaptable(light: veriforceHex("#ffffff"), dark: VeriforceGray._900)
    public static let link = Color.adaptable(light: VeriforceBlue._600, dark: veriforceHex("#6da6f7"))

    public static let borderDefault = Color.adaptable(light: VeriforceGray._300, dark: VeriforceGray._600)
    public static let borderSubtle = Color.adaptable(light: VeriforceGray._200, dark: VeriforceGray._700)
    public static let borderActive = Color.adaptable(light: VeriforceBlue._600, dark: veriforceHex("#6da6f7"))

    public static let surfaceDefault = Color.adaptable(light: VeriforceGray._50, dark: VeriforceGray._900)
    public static let surfaceElevated = Color.adaptable(light: veriforceHex("#ffffff"), dark: VeriforceGray._800)

    /// The primary brand/action color (blue.700 — matches `VeriforceBrand.Primary.main`).
    public static let primary = VeriforceBrand.Primary.main

    public static let successBg = Color.adaptable(light: VeriforceGreen._50, dark: VeriforceGreen._900)
    public static let successText = Color.adaptable(light: VeriforceGreen._600, dark: VeriforceGreen._400)
    public static let successBorder = Color.adaptable(light: VeriforceGreen._300, dark: VeriforceGreen._700)

    public static let criticalBg = Color.adaptable(light: VeriforceRed._50, dark: VeriforceRed._900)
    public static let criticalText = Color.adaptable(light: VeriforceRed._700, dark: VeriforceRed._500)
    public static let criticalBorder = Color.adaptable(light: VeriforceRed._300, dark: VeriforceRed._700)

    // Warning banners use the Amber scale (not Orange, which backs `VeriforceBrand.Warning`) —
    // that's the pairing the Veriforce theme actually uses for warning surfaces.
    public static let warningBg = Color.adaptable(light: VeriforceAmber._50, dark: VeriforceAmber._900)
    public static let warningText = Color.adaptable(light: VeriforceAmber._600, dark: VeriforceAmber._400)
    public static let warningBorder = Color.adaptable(light: VeriforceAmber._300, dark: VeriforceAmber._700)

    public static let neutralBg = Color.adaptable(light: VeriforceGray._50, dark: VeriforceGray._800)
    public static let neutralText = Color.adaptable(light: VeriforceGray._700, dark: VeriforceGray._300)
    public static let neutralBorder = Color.adaptable(light: VeriforceGray._300, dark: VeriforceGray._700)

    public static let disabledBg = Color.adaptable(light: VeriforceGray._100, dark: VeriforceGray._800)
    public static let disabledText = Color.adaptable(light: VeriforceGray._500, dark: VeriforceGray._600)
}

/// Opacity-based state colors, per the "State Colors" table in `guidelines/design-tokens/colors.md`
/// (only the black/light-mode values are documented there).
public enum VeriforceState {
    public enum Black {
        public static let hover = Color.black.opacity(0.04)
        public static let selected = Color.black.opacity(0.08)
        public static let focus = Color.black.opacity(0.12)
        public static let focusVisible = Color.black.opacity(0.3)
        public static let textSecondary = Color.black.opacity(0.6)
        public static let textPrimary = Color.black.opacity(0.87)
    }
}

/// `border.radius.*` from core.json, plus a few component-level overrides from comp.json.
public enum VeriforceRadius {
    public static let xs: CGFloat = 2      // border.radius.050
    public static let sm: CGFloat = 4      // border.radius.100
    public static let button: CGFloat = 6  // comp.button.border-radius (radius.150)
    public static let card: CGFloat = 8    // comp.card.border-radius (radius.200)
    public static let input: CGFloat = 8   // comp.input.border-radius (radius.200)
    public static let menu: CGFloat = 12   // comp.menu.border-radius (radius.300)
    public static let full: CGFloat = 9999 // border.radius.full
}

/// Spacing scale per `guidelines/design-tokens/spacing.md` — MUI's spacing system, where
/// `theme.spacing(n) = n * 8pt`. Semantic names below match that doc's usage table; `unit(_:)` is
/// there for the rare case that needs a non-integer multiple (e.g. MUI's `spacing(0.5)`).
public enum VeriforceSpacing {
    public static func unit(_ n: CGFloat) -> CGFloat { n * 8 }

    public static let tight: CGFloat = unit(0.5)        // 4pt  — tight spacing
    public static let small: CGFloat = unit(1)          // 8pt  — small gaps
    public static let standard: CGFloat = unit(2)       // 16pt — standard spacing
    public static let medium: CGFloat = unit(3)         // 24pt — medium spacing
    public static let large: CGFloat = unit(4)          // 32pt — large spacing
    public static let section: CGFloat = unit(5)        // 40pt — section spacing
    public static let largeSection: CGFloat = unit(6)   // 48pt — large sections
    public static let page: CGFloat = unit(8)           // 64pt — page-level spacing
}

/// Type scale per `guidelines/design-tokens/typography.md`. SwiftUI has no direct equivalent of
/// MUI's per-variant line-height, so only size/weight are carried over; use the documented
/// line-heights (in `typography.md`) if a design needs exact vertical rhythm. The spec's
/// "Instrument Sans" typeface isn't bundled in this package, so these fall back to the system
/// font at the documented sizes/weights.
public enum VeriforceTypography {
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
