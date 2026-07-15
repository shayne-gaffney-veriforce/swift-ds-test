# Buttons

Buttons communicate actions users can take. This guide helps you choose the right button for each situation.

---

## Quick Reference

| Scenario | Component | Props |
|----------|-----------|-------|
| Primary page action | `Button` | `variant="contained" color="primary"` |
| Secondary action (Cancel, Back) | `Button` | `variant="text"` |
| Destructive action | `Button` | `variant="contained" color="error"` |
| Low-emphasis action (Learn more) | `Button` | `variant="text"` |
| Icon-only action | `IconButton` | + `aria-label="description"` |
| Grouped related actions | `ButtonGroup` | wraps multiple `Button` |
| Toggle between options | `ToggleButtonGroup` | + `ToggleButton` children |
| Primary floating action | `Fab` | `color="primary"` |

---

## Imports

```tsx
import Button from '@mui/material/Button';
import IconButton from '@mui/material/IconButton';
import ButtonGroup from '@mui/material/ButtonGroup';
import ToggleButton from '@mui/material/ToggleButton';
import ToggleButtonGroup from '@mui/material/ToggleButtonGroup';
import Fab from '@mui/material/Fab';
```

---

## Button Patterns

### Form Actions (Save / Cancel)

Pair `contained` with `text` — avoid `outlined` in most cases:

```tsx
<Stack direction="row" spacing={2} justifyContent="flex-end">
  <Button variant="text">Cancel</Button>
  <Button variant="contained" color="primary">Save</Button>
</Stack>
```

### Destructive Actions

Use `color="error"` and "Remove" terminology:

```tsx
<Button variant="contained" color="error">Remove Account</Button>

// In a confirmation dialog
<Stack direction="row" spacing={2}>
  <Button variant="text">Cancel</Button>
  <Button variant="contained" color="error">Remove</Button>
</Stack>
```

### Button with Icon

```tsx
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faPlus, faArrowRight } from '@fortawesome/free-solid-svg-icons';

<Button variant="contained" startIcon={<FontAwesomeIcon icon={faPlus} />}>
  Add Item
</Button>

<Button variant="text" endIcon={<FontAwesomeIcon icon={faArrowRight} />}>
  Continue
</Button>
```

### Low-Emphasis Actions

Use `variant="text"` for tertiary actions like links:

```tsx
<Button variant="text">Learn More</Button>
<Button variant="text" color="primary">View Details</Button>
```

---

## IconButton Patterns

Use IconButton for icon-only actions. **Always include `aria-label`.**

### Toolbar Actions

```tsx
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faGear, faBell, faUser } from '@fortawesome/free-solid-svg-icons';

<Stack direction="row" spacing={1}>
  <IconButton aria-label="notifications">
    <FontAwesomeIcon icon={faBell} />
  </IconButton>
  <IconButton aria-label="settings">
    <FontAwesomeIcon icon={faGear} />
  </IconButton>
  <IconButton aria-label="profile">
    <FontAwesomeIcon icon={faUser} />
  </IconButton>
</Stack>
```

### Close / Dismiss

```tsx
<IconButton aria-label="close" onClick={onClose}>
  <FontAwesomeIcon icon={faXmark} />
</IconButton>
```

### Destructive Icon Action

```tsx
<IconButton variant="text" color="error" aria-label="remove">
  <FontAwesomeIcon icon={faTrash} />
</IconButton>
```

### Table Row Actions

```tsx
<IconButton size="small" aria-label="edit">
  <FontAwesomeIcon icon={faEdit} />
</IconButton>
<IconButton size="small" aria-label="remove">
  <FontAwesomeIcon icon={faTrash} />
</IconButton>
```

---

## ButtonGroup Patterns

Group related actions that share context:

```tsx
<ButtonGroup variant="text">
  <Button>Copy</Button>
  <Button>Cut</Button>
  <Button>Paste</Button>
</ButtonGroup>
```

### Split Button (Action + Dropdown)

```tsx
<ButtonGroup variant="contained">
  <Button onClick={handleMainAction}>Save</Button>
  <Button size="small" onClick={handleMenuOpen}>
    <FontAwesomeIcon icon={faChevronDown} />
  </Button>
</ButtonGroup>
```

---

## ToggleButton Patterns

For mutually exclusive or multi-select options.

### View Switcher (Single Selection)

```tsx
const [view, setView] = useState('list');

<ToggleButtonGroup
  value={view}
  exclusive
  onChange={(e, newView) => newView && setView(newView)}
  aria-label="view mode"
>
  <ToggleButton value="list" aria-label="list view">
    <FontAwesomeIcon icon={faList} />
  </ToggleButton>
  <ToggleButton value="grid" aria-label="grid view">
    <FontAwesomeIcon icon={faTableCells} />
  </ToggleButton>
</ToggleButtonGroup>
```

### Text Formatting (Multi Selection)

```tsx
const [formats, setFormats] = useState<string[]>([]);

<ToggleButtonGroup
  value={formats}
  onChange={(e, newFormats) => setFormats(newFormats)}
  aria-label="text formatting"
>
  <ToggleButton value="bold" aria-label="bold">
    <FontAwesomeIcon icon={faBold} />
  </ToggleButton>
  <ToggleButton value="italic" aria-label="italic">
    <FontAwesomeIcon icon={faItalic} />
  </ToggleButton>
</ToggleButtonGroup>
```

---

## Fab Patterns

Use sparingly — one Fab per screen maximum for the primary action.

### Floating Add Button

```tsx
<Fab
  color="primary"
  aria-label="add"
  sx={{ position: 'fixed', bottom: 16, right: 16 }}
>
  <FontAwesomeIcon icon={faPlus} />
</Fab>
```

### Extended Fab with Label

```tsx
<Fab variant="extended" color="primary">
  <FontAwesomeIcon icon={faPlus} style={{ marginRight: 8 }} />
  Create New
</Fab>
```

---

## Accessibility Checklist

- [ ] IconButton has `aria-label` describing the action
- [ ] ToggleButton has `aria-label` for icon-only toggles
- [ ] ToggleButtonGroup has `aria-label` describing the control
- [ ] Destructive buttons have clear, specific labels ("Remove account" not "Remove")
- [ ] Disabled buttons have clear visual distinction (handled by theme)

---

## Common Mistakes

```tsx
// ❌ Icon-only using Button
<Button><FontAwesomeIcon icon={faGear} /></Button>

// ✅ Use IconButton with aria-label
<IconButton aria-label="settings">
  <FontAwesomeIcon icon={faGear} />
</IconButton>
```

```tsx
// ❌ Multiple contained buttons competing
<Button variant="contained">Save</Button>
<Button variant="contained">Save</Button>
<Button variant="contained">Cancel</Button>

// ✅ Clear hierarchy — contained + text
<Button variant="text">Cancel</Button>
<Button variant="text">Save</Button>
<Button variant="contained">Save</Button>
```

```tsx
// ❌ Vague destructive label
<Button color="error">Remove</Button>

// ✅ Specific destructive label
<Button color="error">Remove Account</Button>
```

```tsx
// ❌ ToggleButton without exclusive prop (when single-select intended)
<ToggleButtonGroup value={view} onChange={handleChange}>

// ✅ Add exclusive for single selection
<ToggleButtonGroup value={view} exclusive onChange={handleChange}>
```

---

## Button Hierarchy

When multiple buttons appear together, establish clear hierarchy:

| Priority | Variant | Example |
|----------|---------|---------|
| Primary | `contained` | Save, Submit, Confirm |
| Secondary | `text` | Cancel, Back, Reset |

**Rule:** One `contained` button per group. Pair it with `text` buttons. Use `outlined` sparingly.

---

## Button Labels

### Use Action-Oriented Labels

Labels should describe what happens when clicked. Start with a verb.

```tsx
// ❌ Vague
<Button>Next</Button>
<Button>OK</Button>
<Button>Yes</Button>

// ✅ Action-oriented
<Button>Continue To Checkout</Button>
<Button>Save</Button>
<Button>Add Item</Button>
```

### Use Title Case

Capitalize the first letter of each word.

```tsx
// ❌ ALL CAPS or lowercase
<Button>add new item</Button>
<Button>VIEW MORE</Button>

// ✅ Title Case
<Button>Add New Item</Button>
<Button>View More</Button>
```

### Preferred Terminology

| Instead of | Use |
|------------|-----|
| Delete | **Remove** |
| OK | **Confirm** or specific action |
| Yes / No | Specific actions (see below) |

### Avoid Yes/No in Modals

Yes/No buttons force users to re-read the question. Use specific action labels instead.

```tsx
// ❌ Yes/No pattern
<Dialog>
  <DialogTitle>Remove this item?</DialogTitle>
  <DialogActions>
    <Button>No</Button>
    <Button color="error">Yes</Button>
  </DialogActions>
</Dialog>

// ✅ Specific actions
<Dialog>
  <DialogTitle>Remove this item?</DialogTitle>
  <DialogActions>
    <Button variant="text">Cancel</Button>
    <Button variant="contained" color="error">Remove Item</Button>
  </DialogActions>
</Dialog>
```

### Label Patterns by Scenario

| Action | Label |
|--------|-------|
| Save data | Save |
| Cancel/dismiss | Cancel |
| Navigate forward | Continue, View More |
| Add something | Add Item, Add User |
| Remove something | Remove, Remove Item |
| Confirm destructive | Remove Account, Remove Permanently |
| Submit form | Submit, Send Message |
| Close without action | Cancel |
