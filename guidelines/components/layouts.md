# Layout

Components for structuring and organizing content on the page.

---

## Quick Reference

| Component | Use For |
|-----------|---------|
| `Box` | Generic container, flexbox layouts |
| `Stack` | One-dimensional layouts with consistent spacing |
| `Container` | Centered content with max-width |
| `Grid` | Two-dimensional responsive layouts |
| `ImageList` | Photo galleries, image grids |

---

## Imports

```tsx
import Box from '@mui/material/Box';
import Stack from '@mui/material/Stack';
import Container from '@mui/material/Container';
import Grid from '@mui/material/Grid';
import ImageList from '@mui/material/ImageList';
import ImageListItem from '@mui/material/ImageListItem';
```

---

## Box Patterns

Box is the fundamental building block. Use for custom layouts.

### Flexbox Row

```tsx
<Box sx={{ display: 'flex', alignItems: 'center', gap: 2 }}>
  <Avatar />
  <Typography>User name</Typography>
</Box>
```

### Centered Content

```tsx
<Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', minHeight: '100vh' }}>
  <LoginForm />
</Box>
```

### Positioned Element

```tsx
<Box sx={{ position: 'relative' }}>
  <Image />
  <Box sx={{ position: 'absolute', top: 8, right: 8 }}>
    <Chip label="New" color="primary" size="small" />
  </Box>
</Box>
```

### Semantic HTML

```tsx
<Box component="main">...</Box>
<Box component="section">...</Box>
<Box component="nav">...</Box>
<Box component="form" onSubmit={handleSubmit}>...</Box>
```

---

## Stack Patterns

Stack simplifies flexbox for lists and form layouts.

### Vertical (Default)

```tsx
<Stack spacing={2}>
  <TextField label="Name" />
  <TextField label="Email" />
  <Button variant="contained">Submit</Button>
</Stack>
```

### Horizontal

```tsx
<Stack direction="row" spacing={2}>
  <Button variant="text">Cancel</Button>
  <Button variant="contained">Save</Button>
</Stack>
```

### Responsive Direction

```tsx
<Stack direction={{ xs: 'column', sm: 'row' }} spacing={2}>
  <Card>Item 1</Card>
  <Card>Item 2</Card>
</Stack>
```

### Space Between

```tsx
<Stack direction="row" justifyContent="space-between" alignItems="center">
  <Typography variant="h6">Title</Typography>
  <Button>Action</Button>
</Stack>
```

### With Dividers

```tsx
<Stack divider={<Divider />} spacing={2}>
  <Section1 />
  <Section2 />
  <Section3 />
</Stack>
```

---

## Container Patterns

Container centers content with a max-width.

### Page Content

```tsx
<Container maxWidth="lg">
  <Box sx={{ py: 4 }}>
    <Typography variant="h3" gutterBottom>Page title</Typography>
    <Typography>Page content...</Typography>
  </Box>
</Container>
```

### Narrow Form

```tsx
<Container maxWidth="sm">
  <Paper sx={{ p: 4 }}>
    <Typography variant="h5" gutterBottom>Sign in</Typography>
    <Stack spacing={2}>
      <TextField label="Email" fullWidth />
      <TextField label="Password" type="password" fullWidth />
      <Button variant="contained" fullWidth>Sign in</Button>
    </Stack>
  </Paper>
</Container>
```

### Container Sizes

| Size | Max Width | Use For |
|------|-----------|---------|
| `xs` | 444px | Dialogs, narrow forms |
| `sm` | 600px | Login, signup, simple forms |
| `md` | 900px | Articles, documentation |
| `lg` | 1200px | Dashboards, default pages |
| `xl` | 1536px | Wide layouts, data tables |

---

## Grid Patterns

Grid provides a 12-column responsive layout system.

**IMPORTANT — MUI v7 Grid Syntax**: Use the `size` prop for column widths. Do NOT use legacy props like `xs`, `sm`, `md`, `lg`, `xl` directly on Grid items — these are deprecated in MUI v7.

```tsx
// ❌ Legacy syntax (MUI v5/v6) — DO NOT USE
<Grid container spacing={3}>
  <Grid item xs={12} md={6}>Content</Grid>
</Grid>

// ✅ MUI v7 syntax — USE THIS
<Grid container spacing={3}>
  <Grid size={{ xs: 12, md: 6 }}>Content</Grid>
</Grid>

// ✅ Fixed column width (no breakpoints)
<Grid container spacing={3}>
  <Grid size={6}>Half width</Grid>
</Grid>
```

### Two Columns

```tsx
<Grid container spacing={3}>
  <Grid size={6}>Left column</Grid>
  <Grid size={6}>Right column</Grid>
</Grid>
```

### Responsive Columns

```tsx
<Grid container spacing={3}>
  <Grid size={{ xs: 12, md: 8 }}>
    Main content
  </Grid>
  <Grid size={{ xs: 12, md: 4 }}>
    Sidebar
  </Grid>
</Grid>
```

### Card Grid

```tsx
<Grid container spacing={3}>
  {items.map((item) => (
    <Grid size={{ xs: 12, sm: 6, lg: 4 }} key={item.id}>
      <Card>
        <CardContent>
          <Typography variant="h6">{item.title}</Typography>
        </CardContent>
      </Card>
    </Grid>
  ))}
</Grid>
```

### Auto Width

```tsx
<Grid container spacing={2}>
  <Grid size="auto">
    <Avatar />
  </Grid>
  <Grid size="grow">
    <Typography>Takes remaining space</Typography>
  </Grid>
</Grid>
```

---

## Page Layout Patterns

### Basic Page

```tsx
<Box sx={{ minHeight: '100vh', display: 'flex', flexDirection: 'column' }}>
  <AppBar position="static">
    <Toolbar>
      <Typography variant="h6">App name</Typography>
    </Toolbar>
  </AppBar>
  
  <Container component="main" sx={{ flex: 1, py: 4 }}>
    {/* Page content */}
  </Container>
  
  <Box component="footer" sx={{ py: 2, bgcolor: 'grey.100' }}>
    <Container>
      <Typography variant="body2" color="text.secondary">Footer</Typography>
    </Container>
  </Box>
</Box>
```

### Sidebar Layout

```tsx
<Box sx={{ display: 'flex' }}>
  <Drawer variant="permanent" sx={{ width: 240, flexShrink: 0 }}>
    <Toolbar />
    <List>...</List>
  </Drawer>
  
  <Box component="main" sx={{ flexGrow: 1 }}>
    <Toolbar />
    <Container sx={{ py: 3 }}>
      {/* Content */}
    </Container>
  </Box>
</Box>
```

### Centered Form Page

```tsx
<Container maxWidth="sm">
  <Box sx={{ minHeight: '100vh', display: 'flex', alignItems: 'center' }}>
    <Paper sx={{ p: 4, width: '100%' }}>
      <Typography variant="h5" gutterBottom>Sign in</Typography>
      <Stack spacing={2}>
        <TextField label="Email" fullWidth />
        <TextField label="Password" type="password" fullWidth />
        <Button variant="contained" fullWidth>Sign in</Button>
      </Stack>
    </Paper>
  </Box>
</Container>
```

### Two-Column with Sticky Sidebar

```tsx
<Grid container spacing={4}>
  <Grid size={{ xs: 12, md: 8 }}>
    <Stack spacing={3}>
      <Paper sx={{ p: 3 }}>Content block 1</Paper>
      <Paper sx={{ p: 3 }}>Content block 2</Paper>
    </Stack>
  </Grid>
  <Grid size={{ xs: 12, md: 4 }}>
    <Paper sx={{ p: 3, position: 'sticky', top: 16 }}>
      Sticky sidebar
    </Paper>
  </Grid>
</Grid>
```

---

## Responsive Design

### Breakpoints

| Breakpoint | Min Width | Typical Devices |
|------------|-----------|-----------------|
| `xs` | 0px | Phones |
| `sm` | 600px | Large phones, small tablets |
| `md` | 900px | Tablets |
| `lg` | 1200px | Laptops, desktops |
| `xl` | 1536px | Large desktops |

### Responsive Values

```tsx
<Box
  sx={{
    // Different values per breakpoint
    p: { xs: 2, md: 4 },
    display: { xs: 'block', md: 'flex' },
    width: { xs: '100%', sm: '50%', md: '33%' },
  }}
/>

<Stack
  direction={{ xs: 'column', sm: 'row' }}
  spacing={{ xs: 1, sm: 2, md: 3 }}
/>

<Grid container spacing={{ xs: 2, md: 3 }}>
  <Grid size={{ xs: 12, sm: 6, md: 4 }}>...</Grid>
</Grid>
```

### Hide/Show by Breakpoint

```tsx
<Box sx={{ display: { xs: 'none', md: 'block' } }}>
  Desktop only
</Box>

<Box sx={{ display: { xs: 'block', md: 'none' } }}>
  Mobile only
</Box>
```

---

## Spacing

See `../design-tokens/spacing.md` for the spacing scale. Use theme spacing values (not pixels) for consistency.

---

## Best Practices

### Choose the Right Component

| Need | Use |
|------|-----|
| Simple vertical list | `Stack` |
| Simple horizontal list | `Stack direction="row"` |
| Responsive columns | `Grid` |
| Custom flex layout | `Box` with `display: flex` |
| Centered page content | `Container` |

### Avoid Over-Nesting

```tsx
// ❌ Too many wrappers
<Box>
  <Box>
    <Box>
      <Content />
    </Box>
  </Box>
</Box>

// ✅ Flat and purposeful
<Container maxWidth="md">
  <Stack spacing={3}>
    <Content />
  </Stack>
</Container>
```

### Mobile-First

Design for mobile first, then add complexity for larger screens:

```tsx
<Grid container spacing={{ xs: 2, md: 3 }}>
  <Grid size={{ xs: 12, md: 6 }}>  {/* Full width on mobile, half on desktop */}
    ...
  </Grid>
</Grid>
```

### Consistent Spacing

Use the same spacing values throughout a section:

```tsx
// ❌ Inconsistent
<Stack spacing={2}>
  <Box sx={{ mb: 3 }}>...</Box>  // Mixed spacing
</Stack>

// ✅ Consistent
<Stack spacing={3}>
  <Box>...</Box>
  <Box>...</Box>
</Stack>
```
