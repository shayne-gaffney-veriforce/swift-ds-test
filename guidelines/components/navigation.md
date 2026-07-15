# Navigation

Components for moving between views, pages, and content sections.

---

## Quick Reference

| Component | Use For |
|-----------|---------|
| `Tabs` | Switching between related views in the same context |
| `Menu` | Dropdown actions and options |
| `Breadcrumbs` | Showing location in hierarchy |
| `Link` | Navigation between pages |
| `Drawer` | Side panel navigation |
| `Stepper` | Multi-step flows and wizards |
| `Pagination` | Navigating through pages of content |
| `BottomNavigation` | Mobile app-style navigation |

---

## Imports

```tsx
import Tabs from '@mui/material/Tabs';
import Tab from '@mui/material/Tab';
import Menu from '@mui/material/Menu';
import MenuItem from '@mui/material/MenuItem';
import Breadcrumbs from '@mui/material/Breadcrumbs';
import Link from '@mui/material/Link';
import Drawer from '@mui/material/Drawer';
import Stepper from '@mui/material/Stepper';
import Step from '@mui/material/Step';
import StepLabel from '@mui/material/StepLabel';
import Pagination from '@mui/material/Pagination';
import BottomNavigation from '@mui/material/BottomNavigation';
import BottomNavigationAction from '@mui/material/BottomNavigationAction';
```

---

## Tabs Patterns

Tabs switch between related views. Content should be at the same hierarchy level.

### Basic Tabs

```tsx
const [tab, setTab] = useState(0);

<Tabs value={tab} onChange={(e, newValue) => setTab(newValue)}>
  <Tab label="Overview" />
  <Tab label="Activity" />
  <Tab label="Settings" />
</Tabs>

<Box sx={{ py: 3 }}>
  {tab === 0 && <Overview />}
  {tab === 1 && <Activity />}
  {tab === 2 && <Settings />}
</Box>
```

### Tabs with Icons

```tsx
<Tabs value={tab} onChange={(e, v) => setTab(v)}>
  <Tab icon={<FontAwesomeIcon icon={faHome} />} label="Home" />
  <Tab icon={<FontAwesomeIcon icon={faUser} />} label="Profile" />
  <Tab icon={<FontAwesomeIcon icon={faGear} />} label="Settings" />
</Tabs>
```

### Scrollable Tabs

For many tabs:

```tsx
<Tabs
  value={tab}
  onChange={(e, v) => setTab(v)}
  variant="scrollable"
  scrollButtons="auto"
>
  {categories.map((cat) => (
    <Tab key={cat.id} label={cat.name} />
  ))}
</Tabs>
```

### Vertical Tabs

For sidebar navigation:

```tsx
<Box sx={{ display: 'flex' }}>
  <Tabs
    orientation="vertical"
    value={tab}
    onChange={(e, v) => setTab(v)}
    sx={{ borderRight: 1, borderColor: 'divider' }}
  >
    <Tab label="General" />
    <Tab label="Security" />
    <Tab label="Notifications" />
  </Tabs>
  <Box sx={{ p: 3, flex: 1 }}>
    {/* Tab content */}
  </Box>
</Box>
```

---

## Menu Patterns

Menus show actions and options on click.

### Action Menu

```tsx
const [anchorEl, setAnchorEl] = useState(null);

<IconButton onClick={(e) => setAnchorEl(e.currentTarget)} aria-label="options">
  <FontAwesomeIcon icon={faEllipsisVertical} />
</IconButton>

<Menu anchorEl={anchorEl} open={Boolean(anchorEl)} onClose={() => setAnchorEl(null)}>
  <MenuItem onClick={handleEdit}>
    <ListItemIcon><FontAwesomeIcon icon={faEdit} /></ListItemIcon>
    <ListItemText>Edit</ListItemText>
  </MenuItem>
  <MenuItem onClick={handleDuplicate}>
    <ListItemIcon><FontAwesomeIcon icon={faCopy} /></ListItemIcon>
    <ListItemText>Duplicate</ListItemText>
  </MenuItem>
  <Divider />
  <MenuItem onClick={handleRemove} sx={{ color: 'error.main' }}>
    <ListItemIcon><FontAwesomeIcon icon={faTrash} /></ListItemIcon>
    <ListItemText>Remove</ListItemText>
  </MenuItem>
</Menu>
```

### Context Menu

Position relative to click:

```tsx
<Menu
  anchorEl={anchorEl}
  open={Boolean(anchorEl)}
  onClose={handleClose}
  anchorOrigin={{ vertical: 'bottom', horizontal: 'right' }}
  transformOrigin={{ vertical: 'top', horizontal: 'right' }}
>
  ...
</Menu>
```

---

## Breadcrumbs Patterns

Show location in the navigation hierarchy.

### Basic Breadcrumbs

```tsx
<Breadcrumbs>
  <Link href="/" color="inherit">Home</Link>
  <Link href="/products" color="inherit">Products</Link>
  <Typography color="text.primary">Product name</Typography>
</Breadcrumbs>
```

### With React Router

```tsx
import { Link as RouterLink } from 'react-router';

<Breadcrumbs>
  <Link component={RouterLink} to="/" color="inherit">Home</Link>
  <Link component={RouterLink} to="/products" color="inherit">Products</Link>
  <Typography color="text.primary">Product name</Typography>
</Breadcrumbs>
```

### Collapsed (Long Paths)

```tsx
<Breadcrumbs maxItems={3}>
  <Link href="/">Home</Link>
  <Link href="/category">Category</Link>
  <Link href="/category/subcategory">Subcategory</Link>
  <Link href="/category/subcategory/item">Item</Link>
  <Typography color="text.primary">Current page</Typography>
</Breadcrumbs>
// Shows: Home > ... > Current page
```

---

## Link Patterns

### Internal Link

```tsx
import { Link as RouterLink } from 'react-router';

<Link component={RouterLink} to="/dashboard">
  Go to dashboard
</Link>
```

### External Link

```tsx
<Link href="https://example.com" target="_blank" rel="noopener">
  External site
</Link>
```

### Link Styles

```tsx
<Link underline="hover">Default — underline on hover</Link>
<Link underline="always">Always underlined</Link>
<Link underline="none">No underline</Link>
```

---

## Drawer Patterns

### Mobile Drawer (Temporary)

```tsx
<Drawer anchor="left" open={open} onClose={() => setOpen(false)}>
  <Box sx={{ width: 280 }}>
    <List>
      <ListItemButton onClick={() => navigate('/home')}>
        <ListItemIcon><FontAwesomeIcon icon={faHome} /></ListItemIcon>
        <ListItemText primary="Home" />
      </ListItemButton>
      <ListItemButton onClick={() => navigate('/settings')}>
        <ListItemIcon><FontAwesomeIcon icon={faGear} /></ListItemIcon>
        <ListItemText primary="Settings" />
      </ListItemButton>
    </List>
  </Box>
</Drawer>
```

### Desktop Drawer (Permanent)

```tsx
<Drawer
  variant="permanent"
  sx={{
    width: 240,
    flexShrink: 0,
    '& .MuiDrawer-paper': { width: 240, boxSizing: 'border-box' },
  }}
>
  <Toolbar />
  <List>
    <ListItemButton selected={location === '/home'}>
      <ListItemIcon><FontAwesomeIcon icon={faHome} /></ListItemIcon>
      <ListItemText primary="Home" />
    </ListItemButton>
  </List>
</Drawer>
```

### Collapsible Drawer

```tsx
<Drawer
  variant="permanent"
  sx={{
    width: expanded ? 240 : 64,
    '& .MuiDrawer-paper': {
      width: expanded ? 240 : 64,
      transition: 'width 0.2s',
      overflowX: 'hidden',
    },
  }}
>
  <IconButton onClick={() => setExpanded(!expanded)}>
    <FontAwesomeIcon icon={expanded ? faChevronLeft : faChevronRight} />
  </IconButton>
  <List>
    <ListItemButton>
      <ListItemIcon><FontAwesomeIcon icon={faHome} /></ListItemIcon>
      {expanded && <ListItemText primary="Home" />}
    </ListItemButton>
  </List>
</Drawer>
```

---

## Stepper Patterns

### Horizontal Stepper

```tsx
const steps = ['Account', 'Profile', 'Review'];

<Stepper activeStep={activeStep}>
  {steps.map((label) => (
    <Step key={label}>
      <StepLabel>{label}</StepLabel>
    </Step>
  ))}
</Stepper>

<Box sx={{ mt: 4 }}>
  {activeStep === 0 && <AccountForm />}
  {activeStep === 1 && <ProfileForm />}
  {activeStep === 2 && <Review />}
  
  <Stack direction="row" spacing={2} sx={{ mt: 3 }}>
    <Button variant="text" disabled={activeStep === 0} onClick={handleBack}>
      Back
    </Button>
    <Button variant="contained" onClick={handleNext}>
      {activeStep === steps.length - 1 ? 'Finish' : 'Continue'}
    </Button>
  </Stack>
</Box>
```

### Vertical Stepper

```tsx
<Stepper activeStep={activeStep} orientation="vertical">
  {steps.map((step, index) => (
    <Step key={step.label}>
      <StepLabel>{step.label}</StepLabel>
      <StepContent>
        <Typography>{step.description}</Typography>
        <Stack direction="row" spacing={2} sx={{ mt: 2 }}>
          <Button variant="text" disabled={index === 0} onClick={handleBack}>
            Back
          </Button>
          <Button variant="contained" onClick={handleNext}>
            {index === steps.length - 1 ? 'Finish' : 'Continue'}
          </Button>
        </Stack>
      </StepContent>
    </Step>
  ))}
</Stepper>
```

---

## Pagination Patterns

### Basic Pagination

```tsx
<Pagination
  count={totalPages}
  page={page}
  onChange={(e, value) => setPage(value)}
/>
```

### With Page Size

```tsx
<Stack direction="row" spacing={2} alignItems="center">
  <Typography variant="body2">Rows per page:</Typography>
  <Select size="small" value={pageSize} onChange={(e) => setPageSize(e.target.value)}>
    <MenuItem value={10}>10</MenuItem>
    <MenuItem value={25}>25</MenuItem>
    <MenuItem value={50}>50</MenuItem>
  </Select>
  <Pagination count={totalPages} page={page} onChange={(e, v) => setPage(v)} />
</Stack>
```

---

## Bottom Navigation (Mobile)

```tsx
<BottomNavigation
  value={tab}
  onChange={(e, newValue) => setTab(newValue)}
  showLabels
  sx={{ position: 'fixed', bottom: 0, left: 0, right: 0 }}
>
  <BottomNavigationAction label="Home" icon={<FontAwesomeIcon icon={faHome} />} />
  <BottomNavigationAction label="Search" icon={<FontAwesomeIcon icon={faSearch} />} />
  <BottomNavigationAction label="Profile" icon={<FontAwesomeIcon icon={faUser} />} />
</BottomNavigation>
```

---

## App Shell Pattern

Complete navigation structure:

```tsx
<Box sx={{ display: 'flex' }}>
  <AppBar position="fixed" sx={{ zIndex: (theme) => theme.zIndex.drawer + 1 }}>
    <Toolbar>
      <IconButton edge="start" onClick={toggleDrawer} sx={{ mr: 2 }}>
        <FontAwesomeIcon icon={faBars} />
      </IconButton>
      <Typography variant="h6" sx={{ flexGrow: 1 }}>App name</Typography>
      <IconButton>
        <FontAwesomeIcon icon={faUser} />
      </IconButton>
    </Toolbar>
  </AppBar>
  
  <Drawer variant="permanent" sx={{ width: 240 }}>
    <Toolbar />
    <List>
      <ListItemButton selected={location === '/'}>
        <ListItemIcon><FontAwesomeIcon icon={faHome} /></ListItemIcon>
        <ListItemText primary="Dashboard" />
      </ListItemButton>
    </List>
  </Drawer>
  
  <Box component="main" sx={{ flexGrow: 1, p: 3 }}>
    <Toolbar />
    {/* Page content */}
  </Box>
</Box>
```

---

## Best Practices

### Tabs

- **Use for related content** — Same hierarchy level, same context
- **Don't use for site navigation** — That's what Drawer/AppBar are for
- **Keep labels short** — "Overview" not "Product Overview"
- **Each tab = separate component** — Extract tab content into its own component file, don't inline

```tsx
// ❌ Inline tab content
{tab === 0 && (
  <Box>
    {/* 200 lines of JSX */}
  </Box>
)}

// ✅ Separate component per tab
{tab === 0 && <OverviewTab />}
{tab === 1 && <ActivityTab />}
{tab === 2 && <SettingsTab />}
```

### Menus

- **Group with dividers** — Separate destructive actions
- **Color destructive actions** — Use `sx={{ color: 'error.main' }}` with a trash icon; the icon and text inherit the error color
- See `buttons.md` for label conventions

### Navigation State

- **Show current location** — Use `selected` prop on list items
- **Consistent behavior** — Permanent drawer on desktop, temporary on mobile
- **Remember position** — Restore scroll position when navigating back

### Breadcrumbs

- **Use for deep hierarchies** — 3+ levels
- **Current page is not a link** — Use Typography for the last item
- **Collapse long paths** — Use `maxItems` prop

### Steppers

- **Use for multi-step flows** — Checkout, onboarding, wizards
- **Allow going back** — Don't trap users
- **Validate before advancing** — Don't let users skip required steps