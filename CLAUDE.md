# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

SwiftUIX is a Swift package that fills gaps in the SwiftUI standard library by porting missing UIKit/AppKit
functionality (and adding original components/utilities) in a SwiftUI-idiomatic way. It targets iOS 13+,
macOS 11+, Mac Catalyst 13+, tvOS 13+, watchOS 6+, and visionOS 1+, built with Swift tools version 5.10
(Swift 5.10 is the minimum required; Xcode 15.4+ minimum, CI-verified against Xcode 16.x and 26.x).

## Common commands

Build and test via Swift Package Manager:

```bash
swift build
swift test
swift test --filter UserStorageTests          # run a single test class
swift test --filter UserStorageTests/testSimpleValue   # run a single test method
```

Generate an Xcode project or run the full CI-style build via fastlane (per README; requires the `fastlane`
gem, not vendored in this repo):

```bash
bundle install; bundle exec fastlane generate_xcodeproj
bundle install; bundle exec fastlane build
```

CI (`.github/workflows/build.yml`) builds the `SwiftUIX` scheme with `xcodebuild` across six destinations:
iOS, macOS, Mac Catalyst, tvOS, watchOS, and visionOS, on both Xcode 16 and Xcode 26. When validating a
change is safe across platforms, prefer checking it against multiple `#if os(...)` branches rather than
just compiling for the host platform.

## Architecture

### Two-target split: `_SwiftUIX` and `SwiftUIX`

The package exposes a single product (`SwiftUIX`) backed by two targets:

- **`_SwiftUIX`** (Sources/_SwiftUIX) — the internal/foundational layer. Defines cross-platform primitives,
  most importantly the `AppKitOrUIKit*` typealiases (see
  `Sources/_SwiftUIX/Intermodular/Helpers/AppKit or UIKit/AppKitOrUIKit.swift`) that unify UIKit and AppKit
  types (e.g. `AppKitOrUIKitView` = `UIView` on iOS/tvOS/visionOS, `NSView` on macOS). This is where
  platform-bridging happens once so the rest of the codebase can be written against a single abstraction.
- **`SwiftUIX`** (Sources/SwiftUIX) — the public-facing layer. Re-exports `_SwiftUIX` and `SwiftUI`
  (`@_exported import`), and contains the actual components, view modifiers, and extensions that consumers
  use.

Both targets mirror the same internal folder structure:

- **Intramodular/** — self-contained features, one subfolder per feature area (e.g. `Activity Indicator`,
  `Collection View`, `Search Bar`, `Pagination`, `Text`, `Window`, `Keyboard`, `Gestures`, `Drag & Drop`).
  Each folder holds the SwiftUI view/type plus its platform-specific backing representable
  (UIViewRepresentable/NSViewRepresentable) where relevant.
- **Intermodular/** — cross-cutting glue: `Extensions/` (extensions on Swift/SwiftUI/Foundation/UIKit/AppKit
  types), `Helpers/` (shared infrastructure like `AppKitOrUIKit`, `LinkPresentation`), and (in `SwiftUIX`
  only) `Protocol Conformances/`.

When adding a new component, follow this existing convention: put the SwiftUI-facing type under
`Sources/SwiftUIX/Intramodular/<Feature Name>/`, and if it needs a UIKit/AppKit backing view, use the
`AppKitOrUIKit*` typealiases from `_SwiftUIX` rather than writing separate `#if os(iOS)`/`#if os(macOS)`
implementations from scratch.

### Platform conditionals

Availability is gated heavily with `#if os(iOS) || os(tvOS) || os(visionOS)`, `#if os(macOS)`,
`#if os(watchOS)`, and `targetEnvironment(macCatalyst)`, often per-property or per-type within the same file
rather than per-file. Some APIs are also marked `@available(*, unavailable, ...)` for platforms where no
equivalent exists — check existing files in the same feature folder for the platform-support pattern before
adding new APIs.

### Tests

`Tests/` is a flat XCTest target (`SwiftUIXTests`) depending on the full `SwiftUIX` product — there's no
target/source split mirrored in tests. `Tests/module.swift` defines a shared `UserDefaults.SwiftUIX` test
suite used to isolate `@UserStorage`/`@AppStorage`-style persistence tests from the app's real defaults.

### Documentation

DocC content lives at `Sources/SwiftUIX/SwiftUIX.docc/`. Long-form docs are tracked as work-in-progress
separately from the DocC catalog — the published docs are at
https://swiftuix.github.io/SwiftUIX/documentation/swiftuix/, with additional material in the GitHub wiki.

## WorkerIdentityApp (nested package)

`WorkerIdentityApp/` is a separate SwiftPM package nested inside this repo — a prototype Veriforce iOS app
(worker/contractor identity management) built as a consumer of this SwiftUIX fork, not part of the SwiftUIX
library itself. It depends on the parent package via a local path (`.package(path: "..")`) and is **not**
built by `.github/workflows/build.yml`, which only builds the root `SwiftUIX` scheme.

The product requirements it implements are in `Phase 1 – Worker Profile & Identity.md` (repo root) — read
this first when working in `WorkerIdentityApp/`, since the code (especially `Permissions.swift` and
`WorkerDirectoryStore.swift`) implements specific access-control and dedup rules called out there (e.g. the
"link, don't merge" duplicate-worker resolution, and per-field ownership that's more granular than the
spec's top-level Access Control table).

Build and test it from inside the nested package directory:

```bash
cd WorkerIdentityApp
swift build
swift test
swift run WorkerIdentityAppRunner   # macOS-only entry point; real target is iOS via Xcode/Simulator
```

### Structure

- **Models/** — plain value types (`Worker`, `Contractor`, `ContractorWorkerAssociation`,
  `WorkerInvitation`, `ChangeLogEntry`) plus two small enums that drive access control:
  `FieldOwner` (who a field's value logically belongs to, for UI labeling only) and `CurrentActor`
  (`.contractorAdmin`, `.worker`, `.platformAdmin` — stands in for auth, since OKTA/VF1 isn't live yet;
  swapped via `RoleSwitcherView`).
- **AccessControl/Permissions.swift** — the single source of truth for who can see/edit what
  (`canEditIdentityField`, `canEditAssociation`, `visibleWorkers`, `visibleAssociations`). Field-level
  editability is more granular than the spec's Access Control table and is documented inline where the two
  diverge — check this file, not just the spec, before changing edit rules.
- **Store/WorkerDirectoryStore.swift** — an in-memory `ObservableObject` standing in for the GWN backend.
  Owns workers, contractors, associations, invitations, and an append-only change log; nothing persists
  across launches (deliberate scope decision). `MockData.swift` seeds it (`WorkerDirectoryStore.seeded()`).
- **Views/** — grouped by actor/role (`ContractorAdmin/`, `WorkerSelfService/`, `PlatformAdmin/`,
  `RoleSwitcher/`), with `Shared/` for cross-role components (`FieldRow`, `StatusBadge`).
- **DesignSystem/VeriforceDesignTokens.swift** — colors/radii/spacing hand-transcribed from the Veriforce
  design-tokens package (`@alcumus/design-tokens`, built with Style Dictionary — no Swift output exists), so
  re-sync manually if source tokens change. Built on `SwiftUIX`'s `Color(hexadecimal:)` and
  `Color.adaptable(light:dark:)` rather than reimplementing hex/light-dark handling.

## SafeContractorApp (nested package)

`SafeContractorApp/` is another separate SwiftPM package nested in this repo (sibling to `WorkerIdentityApp`,
same local-path-dependency setup, also **not** built by CI) — a from-scratch SwiftUI recreation of the
"SafeContractor" mobile app (a Veriforce product) transcribed from a Figma file, `New app layout (MUi
version).fig`, that isn't checked into this repo. It covers the Employee-role flows only: onboarding,
sign-in, Home, Tasks, Gate Access, Elearning, My File, Notifications, Settings, and Menu. The
Contractor/Client admin flows in that Figma file (Manage Tasks, Manage E-Learning, etc.) were out of scope
and are not implemented here.

Since `.fig` files are a proprietary binary ("Kiwi") format, this was decoded with Figma's own open-sourced
parser (`sketch-hq/fig2sketch` on GitHub — a community fork of Figma's `fig2sketch`) rather than guessed from
the thumbnail; screen content (copy, colors, layout, component structure) was extracted per-screen before
writing any Swift. If the source `.fig` changes, re-run that decode rather than hand-editing views to match
new screenshots.

Build, test, and run it the same way as `WorkerIdentityApp`:

```bash
cd SafeContractorApp
swift build
swift test
swift run SafeContractorAppRunner   # macOS-only entry point; real target is iOS via Xcode/Simulator
```

### Structure

- **Models/** — `UserProfile`, `TaskItem` (+ `TaskFilter`), `GateAccessRecord` (+ `ComplianceRequirement`),
  `Course` (+ `CourseStatus`), `MyFileRecord` (+ `MyFileCategory`), `AppNotification`, and the shared
  `ComplianceStatus` enum (compliant/expiring/notCompliant/pending/blocked) that drives `StatusChip` color and
  icon everywhere.
- **Store/AppStore.swift** — an in-memory `ObservableObject` seeded by `MockData.swift`
  (`AppStore.seeded()`), matching `WorkerDirectoryStore`'s conventions (nothing persists across launches).
- **Views/** — grouped by feature area (`Onboarding/`, `Auth/`, `Home/`, `Tasks/`, `GateAccess/`,
  `Elearning/`, `MyFile/`, `Notifications/`, `Settings/`, `Menu/`), with `Shared/` for cross-screen components
  (`SiteRecordCard`, `CourseCard`, `StatusChip`, `SectionHeader`, `EmptyStateView`, `ErrorView`).
  `AppRootView` drives the outer Loading → Onboarding → Sign In → `RootTabView` flow; `RootTabView` is a
  native 5-tab `TabView` (Home, Tasks, Gate Access, Elearning, Menu) — My File, Notifications, and Settings
  live under Menu rather than getting their own tab, since the source design's tab bar only has 5 slots.
  Several near-duplicate Figma frames that were just state variants of one screen (e.g. "Task / Compliant",
  "Task / Not compliant") were built as one screen with a segmented/status filter instead of separate views.
- **DesignSystem/DesignTokens.swift** — the same color scales/semantic tokens/spacing/typography approach as
  `VeriforceDesignTokens.swift`, independently defined (`SC`-prefixed) since this package doesn't depend on
  `WorkerIdentityApp`. The palette was cross-checked against resolved fill colors sampled directly from the
  decoded Figma file and matches `/guidelines/design-tokens/` exactly.
- **Resources/Images.xcassets** — real brand assets (SafeContractor logo in white/full-color, the 4 onboarding
  illustrations, the sign-in background photo) extracted from the Figma file's embedded image blobs via the
  fig2sketch decode, not placeholders.
