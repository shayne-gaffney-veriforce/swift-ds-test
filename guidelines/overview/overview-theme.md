# Theme

## Architecture

Dual-token approach:
1. **CSS Custom Properties** (`app/styles/`) — for global styles and non-MUI elements
2. **TypeScript Constants** (`app/theme/colorConstants.ts`) — for MUI `createTheme()`

Theme is provided at the root level via `<ThemeProvider>` + `<CssBaseline />` in `app/root.tsx`.

---

## Using Theme Values

Use the `sx` prop with palette and spacing tokens:

```tsx
<Box sx={{
  bgcolor: 'background.paper',
  color: 'text.primary',
  p: 2,              // theme.spacing(2) = 16px
  borderRadius: 1,   // theme.shape.borderRadius
}}>
```

---

## Key Overrides in This Project

These are already configured in `app/theme/theme.ts`:

- **Buttons** — no ripple, no uppercase, `disableElevation`
- **Paper** — `elevation: 0`, `variant: "outlined"` by default
- **Card** — `elevation: 0`, `variant: "outlined"` by default
- **Menu** — `elevation: 4`, rounded corners, `minWidth: 175`
- **MenuItem** — `text.secondary` color, `gap: 8`, icon inherits color
- **Dialog** — `elevation: 8` (floats above outlined surfaces)
- **TableCell** — `fontSize: 14px`, header gets `action.hover` background and `fontWeight: 500`
- **TableRow** — last row has no bottom border
- **Chips** — pill shape
- **Icons** — FontAwesome only (not Material Icons)
- **Typography** — Instrument Sans

---

## Color Modes

Light/dark mode is supported. Use semantic tokens (`text.primary`, `action.hover`, `background.paper`) instead of hardcoded values so colors adapt automatically.
