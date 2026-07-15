# Data Display

Components for presenting data, content, and information to users.

---

## Quick Reference

| Component | Use For |
|-----------|---------|
| `Chip` | Status indicators, tags, filters, removable selections |
| `Table` | Structured data with rows and columns |
| `List` | Navigation menus, settings, sequential items |
| `Avatar` | User/entity representation |
| `Badge` | Notification counts, status dots |
| `Tooltip` | Additional context on hover |
| `Divider` | Separating content sections |

---

## Imports

```tsx
import Chip from '@mui/material/Chip';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import Avatar from '@mui/material/Avatar';
import AvatarGroup from '@mui/material/AvatarGroup';
import Badge from '@mui/material/Badge';
import Tooltip from '@mui/material/Tooltip';
import Divider from '@mui/material/Divider';
```

---

## Chip Patterns

Chips are compact elements for status, tags, and selections. **Prefer `outlined` variant** — it's lighter and works better in dense UIs.

### Semantic Colors

Use color to convey meaning:

| Color | Meaning | Use For |
|-------|---------|---------|
| `success` (green) | Positive | Active, Complete, Approved, Online |
| `error` (red) | Negative | Failed, Rejected, Offline, Overdue |
| `warning` (yellow/orange) | Caution | Pending, Expiring, Needs attention |
| `info` / `primary` (blue) | Informational | New, Updated, Selected, Default highlight |
| `default` (gray) | Neutral | Draft, Inactive, Archived, Unassigned |

### Status Indicators

```tsx
<Chip label="Active" color="success" variant="outlined" size="small" />
<Chip label="Pending" color="warning" variant="outlined" size="small" />
<Chip label="Failed" color="error" variant="outlined" size="small" />
<Chip label="Draft" variant="outlined" size="small" />
```

### Filter Chips

For toggleable filters, use `onClick`:

```tsx
<Chip
  label="In stock"
  variant={filter.inStock ? "filled" : "outlined"}
  color={filter.inStock ? "primary" : "default"}
  onClick={() => toggleFilter('inStock')}
/>
```

### Tag Chips

For categories and labels:

```tsx
<Stack direction="row" spacing={1}>
  <Chip label="React" variant="outlined" size="small" />
  <Chip label="TypeScript" variant="outlined" size="small" />
  <Chip label="Frontend" variant="outlined" size="small" />
</Stack>
```

### Removable Chips (Selections)

For user selections that can be removed:

```tsx
<Chip
  label="john@example.com"
  onDelete={() => removeEmail('john@example.com')}
  variant="outlined"
/>
```

### User Chips

With avatar for people:

```tsx
<Chip
  avatar={<Avatar src="/user.jpg" />}
  label="Sarah Connor"
  variant="outlined"
  onDelete={onRemove}
/>
```

---

## Table Patterns

Tables display structured data. Always include headers for accessibility.

### Basic Data Table

```tsx
<TableContainer component={Paper}>
  <Table>
    <TableHead>
      <TableRow>
        <TableCell>Name</TableCell>
        <TableCell>Status</TableCell>
        <TableCell align="right"></TableCell>
      </TableRow>
    </TableHead>
    <TableBody>
      {rows.map((row) => (
        <TableRow 
          key={row.id} 
          hover 
          onClick={() => handleView(row)}
          sx={{ cursor: 'pointer' }}
        >
          <TableCell>{row.name}</TableCell>
          <TableCell>
            <Chip label={row.status} color="success" variant="outlined" size="small" />
          </TableCell>
          <TableCell align="right" onClick={(e) => e.stopPropagation()}>
            <RowActionsMenu row={row} />
          </TableCell>
        </TableRow>
      ))}
    </TableBody>
  </Table>
</TableContainer>
```

### Row Actions Menu

Use an ellipsis menu for row actions instead of multiple inline icons.

```tsx
function RowActionsMenu({ row }: { row: RowData }) {
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  const open = Boolean(anchorEl);

  return (
    <>
      <IconButton
        color="secondary"
        size="small"
        onClick={(e) => setAnchorEl(e.currentTarget)}
        aria-label="Row actions"
      >
        <FontAwesomeIcon icon={faEllipsis} />
      </IconButton>
      <Menu anchorEl={anchorEl} open={open} onClose={() => setAnchorEl(null)}>
        <MenuItem onClick={() => handleView(row)}>
          <ListItemIcon><FontAwesomeIcon icon={faEye} /></ListItemIcon>
          View
        </MenuItem>
        <MenuItem onClick={() => handleEdit(row)}>
          <ListItemIcon><FontAwesomeIcon icon={faPen} /></ListItemIcon>
          Edit
        </MenuItem>
        <MenuItem onClick={() => handleDuplicate(row)}>
          <ListItemIcon><FontAwesomeIcon icon={faCopy} /></ListItemIcon>
          Duplicate
        </MenuItem>
        <Divider />
        <MenuItem onClick={() => handleDelete(row)} sx={{ color: 'error.main' }}>
          <ListItemIcon><FontAwesomeIcon icon={faTrash} /></ListItemIcon>
          Remove
        </MenuItem>
      </Menu>
    </>
  );
}
```

**Important**: The first menu item (typically View or Edit) should match the row click action.

### Sortable Table

```tsx
import TableSortLabel from '@mui/material/TableSortLabel';

<TableCell>
  <TableSortLabel
    active={orderBy === 'name'}
    direction={orderBy === 'name' ? order : 'asc'}
    onClick={() => handleSort('name')}
  >
    Name
  </TableSortLabel>
</TableCell>
```

### Selectable Rows

```tsx
<TableRow
  hover
  onClick={() => toggleSelect(row.id)}
  selected={selected.includes(row.id)}
  sx={{ cursor: 'pointer' }}
>
  <TableCell padding="checkbox">
    <Checkbox checked={selected.includes(row.id)} />
  </TableCell>
  <TableCell>{row.name}</TableCell>
</TableRow>
```

### Dense Table

For data-heavy views:

```tsx
<Table size="small">
  ...
</Table>
```

### Empty State

Always handle empty tables:

```tsx
{rows.length === 0 ? (
  <TableRow>
    <TableCell colSpan={3} align="center">
      <Typography color="text.secondary">No results found</Typography>
    </TableCell>
  </TableRow>
) : (
  rows.map((row) => ...)
)}
```

---

## List Patterns

Lists display sequential items, navigation menus, or settings.

### Navigation List

```tsx
<List>
  <ListItemButton selected={current === 'inbox'} onClick={() => navigate('inbox')}>
    <ListItemIcon>
      <FontAwesomeIcon icon={faInbox} />
    </ListItemIcon>
    <ListItemText primary="Inbox" />
  </ListItemButton>
  <ListItemButton selected={current === 'sent'} onClick={() => navigate('sent')}>
    <ListItemIcon>
      <FontAwesomeIcon icon={faPaperPlane} />
    </ListItemIcon>
    <ListItemText primary="Sent" />
  </ListItemButton>
</List>
```

### Settings List

With secondary text for descriptions:

```tsx
<List>
  <ListItem>
    <ListItemText
      primary="Notifications"
      secondary="Receive email notifications for updates"
    />
    <Switch checked={notifications} onChange={toggleNotifications} />
  </ListItem>
  <ListItem>
    <ListItemText
      primary="Dark mode"
      secondary="Use dark theme across the app"
    />
    <Switch checked={darkMode} onChange={toggleDarkMode} />
  </ListItem>
</List>
```

### Grouped List

With subheaders:

```tsx
import ListSubheader from '@mui/material/ListSubheader';

<List>
  <ListSubheader>Account</ListSubheader>
  <ListItemButton>
    <ListItemText primary="Profile" />
  </ListItemButton>
  <ListItemButton>
    <ListItemText primary="Security" />
  </ListItemButton>
  
  <ListSubheader>Preferences</ListSubheader>
  <ListItemButton>
    <ListItemText primary="Notifications" />
  </ListItemButton>
</List>
```

---

## Avatar Patterns

Avatars represent users or entities.

### User Avatar (with fallback)

```tsx
<Avatar
  alt="Sarah Connor"
  src="/sarah.jpg"
  sx={{ bgcolor: 'primary.main' }}  // Fallback color if image fails
>
  SC
</Avatar>
```

### Avatar Sizes

```tsx
// Small (inline with text)
<Avatar sx={{ width: 24, height: 24 }}>S</Avatar>

// Medium (default, lists and cards)
<Avatar sx={{ width: 40, height: 40 }}>M</Avatar>

// Large (profile headers)
<Avatar sx={{ width: 56, height: 56 }}>L</Avatar>
```

### Avatar Group

Show multiple users with overflow:

```tsx
<AvatarGroup max={4}>
  <Avatar alt="User 1" src="/user1.jpg" />
  <Avatar alt="User 2" src="/user2.jpg" />
  <Avatar alt="User 3" src="/user3.jpg" />
  <Avatar alt="User 4" src="/user4.jpg" />
  <Avatar alt="User 5" src="/user5.jpg" />
</AvatarGroup>
// Displays: 4 avatars + "+1"
```

### Icon Avatar

For non-user entities:

```tsx
<Avatar sx={{ bgcolor: 'grey.200' }}>
  <FontAwesomeIcon icon={faBuilding} />
</Avatar>
```

---

## Badge Patterns

Badges show counts or status indicators.

### Notification Count

```tsx
<Badge badgeContent={4} color="error">
  <FontAwesomeIcon icon={faBell} />
</Badge>
```

### With Max Value

Cap large numbers:

```tsx
<Badge badgeContent={150} max={99} color="error">
  <FontAwesomeIcon icon={faEnvelope} />
</Badge>
// Displays "99+"
```

### Status Dot

For online/offline or unread indicators:

```tsx
<Badge variant="dot" color="success">
  <Avatar src="/user.jpg" />
</Badge>
```

### Conditional Badge

Only show when there's content:

```tsx
{unreadCount > 0 && (
  <Badge badgeContent={unreadCount} color="error">
    <FontAwesomeIcon icon={faBell} />
  </Badge>
)}
```

---

## Tooltip Patterns

Tooltips provide additional context on hover.

### Icon Button Tooltip

Always add tooltips to icon-only actions:

```tsx
<Tooltip title="Remove">
  <IconButton aria-label="remove">
    <FontAwesomeIcon icon={faTrash} />
  </IconButton>
</Tooltip>
```

### Inline Text Tooltip

For terms or values that need explanation, use a **dotted underline** to indicate hover:

```tsx
<Tooltip title="Annual Recurring Revenue">
  <Typography
    component="span"
    sx={{
      textDecoration: 'underline',
      textDecorationStyle: 'dotted',
      cursor: 'help',
    }}
  >
    ARR
  </Typography>
</Tooltip>
```

### Keyboard Shortcut Tooltip

```tsx
<Tooltip title="Save (⌘S)">
  <Button variant="contained">Save</Button>
</Tooltip>
```

### Rich Tooltip

For more complex content:

```tsx
<Tooltip
  title={
    <Stack spacing={0.5}>
      <Typography variant="subtitle2">Total revenue</Typography>
      <Typography variant="caption">Last 30 days</Typography>
    </Stack>
  }
>
  <Typography variant="h4">$12,450</Typography>
</Tooltip>
```

---

## Divider Patterns

Dividers separate content sections.

### Section Divider

```tsx
<Stack spacing={3}>
  <Section1 />
  <Divider />
  <Section2 />
</Stack>
```

### Divider with Label

```tsx
<Divider>or</Divider>
```

### Vertical Divider

In horizontal layouts:

```tsx
<Stack direction="row" spacing={2} divider={<Divider orientation="vertical" flexItem />}>
  <Stat label="Users" value={1234} />
  <Stat label="Revenue" value="$45k" />
  <Stat label="Orders" value={89} />
</Stack>
```

---

## Color Semantics Summary

| Color | Meaning | Components |
|-------|---------|------------|
| Green (`success`) | Positive, complete, active | Chip, Badge dot |
| Red (`error`) | Negative, failed, urgent | Chip, Badge count |
| Yellow/Orange (`warning`) | Caution, pending, attention | Chip |
| Blue (`primary`/`info`) | Informational, selected, neutral-positive | Chip, Badge |
| Gray (`default`) | Neutral, inactive, draft | Chip |

---

## Best Practices

### Chip

- **Prefer `outlined` variant** — cleaner in dense UIs, reserve `filled` for high emphasis
- **Use semantic colors consistently** — green = positive, red = negative, etc.
- **Size `small` for inline use** — in tables, lists, or alongside text
- **Don't use Chips as buttons** — if it triggers navigation, use a Button or Link

```tsx
// ❌ Chip as button
<Chip label="View details" onClick={navigateToDetails} />

// ✅ Use Button for navigation actions
<Button variant="text">View details</Button>
```

### Table

- **Always include `TableHead`** — required for screen readers
- **Handle empty states** — never show an empty table body
- **Right-align numeric columns** — and their headers
- **Use `hover` on rows** — for interactive tables
- **No "Actions" column header** — leave the header cell empty for action columns
- **Ellipsis menu for actions** — don't render multiple icons side by side; use a single `IconButton` with an ellipsis icon and a Menu
- **Clickable rows trigger primary action** — row click should open the same view/edit as the first menu item
- **Consistent text color** — use `text.primary` for the primary identifier column (e.g., name) and `text.secondary` for all other text columns; apply via `sx={{ color: 'text.secondary' }}` on the `TableCell` itself, not with a `Typography` wrapper inside the cell

```tsx
// ❌ Multiple action icons side by side
<TableCell align="right">
  <IconButton><FontAwesomeIcon icon={faEye} /></IconButton>
  <IconButton><FontAwesomeIcon icon={faEdit} /></IconButton>
  <IconButton><FontAwesomeIcon icon={faCopy} /></IconButton>
  <IconButton><FontAwesomeIcon icon={faTrash} /></IconButton>
</TableCell>

// ✅ Single ellipsis menu
<TableCell align="right">
  <IconButton color="secondary" size="small" aria-label="Row actions">
    <FontAwesomeIcon icon={faEllipsis} />
  </IconButton>
</TableCell>

// ❌ Inconsistent text colors
<TableCell>{row.name}</TableCell>
<TableCell sx={{ color: 'grey.600' }}>{row.email}</TableCell>  {/* random gray */}
<TableCell sx={{ color: '#888' }}>{row.date}</TableCell>  {/* hardcoded gray */}

// ✅ Consistent semantic colors — use sx on the cell, not Typography inside it
<TableCell>{row.name}</TableCell>  {/* inherits text.primary */}
<TableCell sx={{ color: 'text.secondary' }}>{row.email}</TableCell>
```

### List

- **Use `ListItemButton` for clickable items** — not `ListItem` with `onClick`
- **Show selected state** — use `selected` prop for current location
- **Group related items** — with `ListSubheader`

### Avatar

- **Always provide `alt` text** — for accessibility
- **Include letter fallback** — in case image fails to load
- **Use consistent sizes** — don't mix sizes in the same context

### Badge

- **Only show when meaningful** — don't badge everything
- **Hide zero counts** — conditionally render the badge
- **Use dot for binary states** — online/offline, read/unread

### Tooltip

- **Required for icon-only actions** — always pair IconButton with Tooltip
- **Use dotted underline for text tooltips** — indicates hoverable term
- **Keep content brief** — tooltips are for hints, not documentation
- **Don't tooltip obvious things** — "Save" button doesn't need a "Save" tooltip

```tsx
// ❌ Redundant tooltip
<Tooltip title="Save">
  <Button>Save</Button>
</Tooltip>

// ✅ Helpful tooltip (adds keyboard shortcut)
<Tooltip title="Save (⌘S)">
  <Button>Save</Button>
</Tooltip>
```
