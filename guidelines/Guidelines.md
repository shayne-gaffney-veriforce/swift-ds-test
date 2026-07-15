# Design System Guidelines

MUI v7 component library with a custom theme built on design tokens. FontAwesome icons.

---

## Before Writing Code

1. **Read overview files** — all files in `overview/`
2. **Read design tokens** — all files in `design-tokens/`
3. **Read the relevant component guide** — e.g. using a table? read `components/data-display.md` first
4. **Use theme tokens** — via the `sx` prop. Never hardcode colors or spacing values
5. **Check consistency** — tokens, spacing, single primary action per section, accessible contrast

---

## File Structure

```
guidelines/
├── Guidelines.md                     # This file — start here
├── overview/
│   ├── overview-theme.md             # Theme setup and sx prop usage
│   ├── overview-typography.md        # Type system and text patterns
│   ├── overview-components.md        # Component inventory and quick reference
│   ├── overview-icons.md             # Icon library (FontAwesome)
│   ├── overview-data-and-formatting.md # Data formatting (dates, currency, etc.)
│   ├── overview-pattern.md           # Page layout patterns (list page, detail page)
│   └── overview-tone.md              # Voice, tone, and microcopy
├── design-tokens/
│   ├── colors.md                     # Color scales and brand palette
│   ├── typography.md                 # Font families and variant specs
│   └── spacing.md                    # Spacing scale and shorthand
└── components/
    ├── buttons.md                    # Button, IconButton, ButtonGroup, ToggleButton, Fab
    ├── inputs.md                     # TextField, Select, Autocomplete, Checkbox, Radio, Switch, Slider, Rating
    ├── data-display.md               # Chip, Table, List, Avatar, Badge, Tooltip, Divider
    ├── feedback.md                   # Alert, Dialog, Snackbar, Progress, Skeleton, Backdrop
    ├── navigation.md                 # Tabs, Menu, Breadcrumbs, Link, Drawer, Stepper, Pagination
    ├── surfaces.md                   # Card, Paper, Accordion, AppBar, Toolbar
    └── layouts.md                    # Box, Container, Grid, Stack, ImageList
```

## Theme Location

- `app/theme/theme.ts` — MUI theme with component overrides
- `app/theme/colorConstants.ts` — TypeScript color constants
- `app/styles/` — CSS custom properties (colors, typography, base styles)

## Key Conventions

- Always use MUI components over raw HTML (`<Button>` not `<button>`)
- Direct imports: `import Button from '@mui/material/Button'`
- FontAwesome icons only — never MUI icons
- Outlined/elevation-0 surfaces by default; elevation for floating elements (menus, dialogs)
- Title Case for buttons ("Add Contractor", "Save Changes")
- `h4` for page titles
- `IconButton` for icon-only actions
- `text.secondary` via `sx` on `TableCell`, not via `Typography` wrappers inside cells
