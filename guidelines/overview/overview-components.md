# Components Overview

Quick reference for MUI components. Detailed guidance for each category is in `../components/`.

## Import Pattern

```tsx
// Always use direct imports
import Button from '@mui/material/Button';
```

---

## Component Index

| Category | File | Components |
|----------|------|------------|
| **Buttons** | `buttons.md` | Button, IconButton, ButtonGroup, ToggleButton, Fab |
| **Inputs** | `inputs.md` | TextField, Select, Autocomplete, Checkbox, Radio, Switch, Slider, Rating |
| **Data Display** | `data-display.md` | Chip, Table, List, Avatar, Badge, Tooltip, Divider |
| **Feedback** | `feedback.md` | Alert, Dialog, Snackbar, Progress, Skeleton, Backdrop |
| **Navigation** | `navigation.md` | Tabs, Menu, Breadcrumbs, Link, Drawer, Stepper, Pagination |
| **Surfaces** | `surfaces.md` | Card, Paper, Accordion, AppBar, Toolbar |
| **Layout** | `layouts.md` | Box, Container, Grid, Stack, ImageList |

---

## Most Used

| Component | Purpose | Example |
|-----------|---------|---------|
| `Box` | Layout primitive with `sx` | `<Box sx={{ p: 2 }}>` |
| `Stack` | Flexbox helper | `<Stack spacing={2}>` |
| `Grid` | 12-column grid | `<Grid container spacing={2}>` |
| `Typography` | Themed text | `<Typography variant="h4">` |
| `Card` | Content container | `<Card><CardContent>` |
| `Button` | Primary action | `<Button variant="contained">` |
| `IconButton` | Icon-only action | `<IconButton><FontAwesomeIcon icon={faPen} /></IconButton>` |
| `TextField` | Text input | `<TextField label="Email" />` |
| `Chip` | Status/tag | `<Chip label="Active" color="success" size="small" variant="outlined" />` |
| `Dialog` | Modal | `<Dialog open={open}>` |
| `Table` | Data table | `<Table>` with `TableHead`, `TableBody`, `TableRow`, `TableCell` |
