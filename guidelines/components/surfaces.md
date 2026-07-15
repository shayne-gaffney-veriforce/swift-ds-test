# Surfaces

Components that provide visual containers and structure for content.

---

## Quick Reference

| Component | Use For |
|-----------|---------|
| `Card` | Discrete content units (products, users, articles) |
| `Paper` | Section containers, elevated surfaces |
| `Accordion` | Progressive disclosure, FAQs, collapsible sections |
| `AppBar` | Top navigation bar |
| `Toolbar` | Container for AppBar content |

---

## Imports

```tsx
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import CardActions from '@mui/material/CardActions';
import CardMedia from '@mui/material/CardMedia';
import CardHeader from '@mui/material/CardHeader';
import CardActionArea from '@mui/material/CardActionArea';
import Paper from '@mui/material/Paper';
import Accordion from '@mui/material/Accordion';
import AccordionSummary from '@mui/material/AccordionSummary';
import AccordionDetails from '@mui/material/AccordionDetails';
import AppBar from '@mui/material/AppBar';
import Toolbar from '@mui/material/Toolbar';
```

---

## Card Patterns

Cards group related content and actions.

### Content Card

```tsx
<Card>
  <CardContent>
    <Typography variant="h6" gutterBottom>Card title</Typography>
    <Typography variant="body2" color="text.secondary">
      Card description goes here.
    </Typography>
  </CardContent>
</Card>
```

### Card with Actions

```tsx
<Card>
  <CardContent>
    <Typography variant="h6">Card title</Typography>
    <Typography variant="body2" color="text.secondary">
      Description text.
    </Typography>
  </CardContent>
  <CardActions>
    <Button variant="text" size="small">Learn more</Button>
    <Button variant="contained" size="small">Action</Button>
  </CardActions>
</Card>
```

### Media Card

```tsx
<Card>
  <CardMedia
    component="img"
    height="140"
    image="/image.jpg"
    alt="Description"
  />
  <CardContent>
    <Typography variant="h6">Media card</Typography>
    <Typography variant="body2" color="text.secondary">
      Card with image.
    </Typography>
  </CardContent>
</Card>
```

### Card with Header

```tsx
<Card>
  <CardHeader
    avatar={<Avatar>JD</Avatar>}
    action={
      <IconButton aria-label="options">
        <FontAwesomeIcon icon={faEllipsisVertical} />
      </IconButton>
    }
    title="John Doe"
    subheader="Posted 2 hours ago"
  />
  <CardContent>
    <Typography variant="body2">Post content here...</Typography>
  </CardContent>
</Card>
```

### Clickable Card

```tsx
<Card>
  <CardActionArea onClick={handleClick}>
    <CardMedia component="img" height="140" image="/image.jpg" alt="..." />
    <CardContent>
      <Typography variant="h6">Clickable card</Typography>
    </CardContent>
  </CardActionArea>
</Card>
```

### Card Variants

```tsx
// Elevated (default)
<Card>...</Card>

// Outlined — lighter, no shadow
<Card variant="outlined">...</Card>
```

---

## Paper Patterns

Paper provides elevated surfaces for grouping content.

### Section Container

```tsx
<Paper sx={{ p: 3 }}>
  <Typography variant="h6" gutterBottom>Section title</Typography>
  <Typography>Section content...</Typography>
</Paper>
```

### Form Container

```tsx
<Paper sx={{ p: 4, maxWidth: 400, mx: 'auto' }}>
  <Typography variant="h5" gutterBottom>Sign in</Typography>
  <Stack spacing={2}>
    <TextField label="Email" fullWidth />
    <TextField label="Password" type="password" fullWidth />
    <Button variant="contained" fullWidth>Sign in</Button>
  </Stack>
</Paper>
```

### Table Container

```tsx
<Paper>
  <Table>
    <TableHead>...</TableHead>
    <TableBody>...</TableBody>
  </Table>
</Paper>
```

### Paper Variants

```tsx
// Elevated (default)
<Paper>...</Paper>

// Outlined — border instead of shadow
<Paper variant="outlined">...</Paper>

// Custom elevation (0-24)
<Paper elevation={0}>Flat</Paper>
<Paper elevation={3}>More shadow</Paper>
```

---

## Accordion Patterns

Accordions show/hide content progressively.

### Basic Accordion

```tsx
<Accordion>
  <AccordionSummary expandIcon={<FontAwesomeIcon icon={faChevronDown} />}>
    <Typography>Section title</Typography>
  </AccordionSummary>
  <AccordionDetails>
    <Typography>Section content...</Typography>
  </AccordionDetails>
</Accordion>
```

### FAQ List

```tsx
{faqs.map((faq, index) => (
  <Accordion key={index}>
    <AccordionSummary expandIcon={<FontAwesomeIcon icon={faChevronDown} />}>
      <Typography fontWeight={500}>{faq.question}</Typography>
    </AccordionSummary>
    <AccordionDetails>
      <Typography color="text.secondary">{faq.answer}</Typography>
    </AccordionDetails>
  </Accordion>
))}
```

### Controlled (Single Open)

Only one accordion open at a time:

```tsx
const [expanded, setExpanded] = useState<string | false>(false);

const handleChange = (panel: string) => (event: any, isExpanded: boolean) => {
  setExpanded(isExpanded ? panel : false);
};

<Accordion expanded={expanded === 'panel1'} onChange={handleChange('panel1')}>
  <AccordionSummary expandIcon={<FontAwesomeIcon icon={faChevronDown} />}>
    <Typography>Panel 1</Typography>
  </AccordionSummary>
  <AccordionDetails>...</AccordionDetails>
</Accordion>

<Accordion expanded={expanded === 'panel2'} onChange={handleChange('panel2')}>
  <AccordionSummary expandIcon={<FontAwesomeIcon icon={faChevronDown} />}>
    <Typography>Panel 2</Typography>
  </AccordionSummary>
  <AccordionDetails>...</AccordionDetails>
</Accordion>
```

### Default Expanded

```tsx
<Accordion defaultExpanded>
  <AccordionSummary expandIcon={<FontAwesomeIcon icon={faChevronDown} />}>
    <Typography>Expanded by default</Typography>
  </AccordionSummary>
  <AccordionDetails>...</AccordionDetails>
</Accordion>
```

---

## AppBar Patterns

AppBar provides top navigation.

### Basic AppBar

```tsx
<AppBar position="static">
  <Toolbar>
    <Typography variant="h6" sx={{ flexGrow: 1 }}>
      App name
    </Typography>
    <Button color="inherit">Sign in</Button>
  </Toolbar>
</AppBar>
```

### With Menu Button

```tsx
<AppBar position="static">
  <Toolbar>
    <IconButton edge="start" color="inherit" aria-label="menu" sx={{ mr: 2 }}>
      <FontAwesomeIcon icon={faBars} />
    </IconButton>
    <Typography variant="h6" sx={{ flexGrow: 1 }}>
      App name
    </Typography>
    <IconButton color="inherit" aria-label="profile">
      <FontAwesomeIcon icon={faUser} />
    </IconButton>
  </Toolbar>
</AppBar>
```

### Fixed AppBar

```tsx
<AppBar position="fixed">
  <Toolbar>...</Toolbar>
</AppBar>
<Toolbar />  {/* Spacer to push content below */}
<main>Content</main>
```

### AppBar Colors

```tsx
<AppBar color="primary">...</AppBar>      // Default (blue)
<AppBar color="default">...</AppBar>      // White/paper
<AppBar color="transparent">...</AppBar>  // Transparent
```

---

## Toolbar Patterns

Toolbar structures AppBar content.

### Standard Layout

```tsx
<Toolbar>
  {/* Left: Menu button */}
  <IconButton edge="start" sx={{ mr: 2 }}>
    <FontAwesomeIcon icon={faBars} />
  </IconButton>
  
  {/* Center: Title (flexGrow pushes rest to right) */}
  <Typography variant="h6" sx={{ flexGrow: 1 }}>
    Page title
  </Typography>
  
  {/* Right: Actions */}
  <IconButton>
    <FontAwesomeIcon icon={faBell} />
  </IconButton>
  <IconButton edge="end">
    <FontAwesomeIcon icon={faUser} />
  </IconButton>
</Toolbar>
```

### Dense Toolbar

```tsx
<Toolbar variant="dense">
  ...
</Toolbar>
```

---

## Layout Patterns

### Dashboard Layout

```tsx
<Box sx={{ display: 'flex', flexDirection: 'column', minHeight: '100vh' }}>
  <AppBar position="static">
    <Toolbar>
      <Typography variant="h6">Dashboard</Typography>
    </Toolbar>
  </AppBar>
  
  <Box sx={{ display: 'flex', flex: 1 }}>
    <Drawer variant="permanent" sx={{ width: 240 }}>
      <Toolbar />
      <List>...</List>
    </Drawer>
    
    <Box component="main" sx={{ flexGrow: 1, p: 3 }}>
      <Grid container spacing={3}>
        <Grid size={{ xs: 12, md: 8 }}>
          <Paper sx={{ p: 2 }}>Main content</Paper>
        </Grid>
        <Grid size={{ xs: 12, md: 4 }}>
          <Paper sx={{ p: 2 }}>Sidebar</Paper>
        </Grid>
      </Grid>
    </Box>
  </Box>
</Box>
```

### Card Grid

```tsx
<Grid container spacing={3}>
  {items.map((item) => (
    <Grid size={{ xs: 12, sm: 6, md: 4 }} key={item.id}>
      <Card sx={{ height: '100%', display: 'flex', flexDirection: 'column' }}>
        <CardMedia component="img" height="140" image={item.image} alt={item.title} />
        <CardContent sx={{ flex: 1 }}>
          <Typography variant="h6">{item.title}</Typography>
          <Typography variant="body2" color="text.secondary">
            {item.description}
          </Typography>
        </CardContent>
        <CardActions>
          <Button variant="text" size="small">View</Button>
        </CardActions>
      </Card>
    </Grid>
  ))}
</Grid>
```

---

## Best Practices

### Cards vs Paper

| Use Card | Use Paper |
|----------|-----------|
| Product listings | Section containers |
| User profiles | Form wrappers |
| Article previews | Table containers |
| Discrete, repeatable units | Grouped content |

### Card Guidelines

- **One primary action per card** — Don't overload with buttons
- **Use CardActionArea for clickable cards** — Better accessibility
- **Consistent card heights** — Use `height: '100%'` and flex in grids
- **Don't nest cards** — Use Paper for nested sections
- **No icons before card titles** — Keep titles clean; icons belong in CardHeader avatar or action slots only

```tsx
// ❌ Don't add icons before card titles
<Card>
  <CardContent>
    <Typography variant="h6">
      <FontAwesomeIcon icon={faFile} /> Document title
    </Typography>
  </CardContent>
</Card>

// ✅ Clean card titles without leading icons
<Card>
  <CardContent>
    <Typography variant="h6">Document title</Typography>
  </CardContent>
</Card>

// ✅ If you need an icon, use CardHeader properly
<Card>
  <CardHeader
    avatar={<Avatar><FontAwesomeIcon icon={faFile} /></Avatar>}
    title="Document title"
  />
  <CardContent>...</CardContent>
</Card>
```

```tsx
// ❌ Nested cards
<Card>
  <CardContent>
    <Card>...</Card>
  </CardContent>
</Card>

// ✅ Card with Paper section
<Card>
  <CardContent>
    <Paper variant="outlined" sx={{ p: 2 }}>
      Nested section
    </Paper>
  </CardContent>
</Card>
```

### Accordion Guidelines

- **Use for optional content** — FAQs, advanced settings, details
- **Don't hide critical information** — Users might miss it
- **Keep summaries concise** — Should fit on one line
- **Consider defaultExpanded** — For important sections

### AppBar Guidelines

- **Fixed for apps, static for pages** — Fixed keeps nav accessible
- **Add spacer for fixed AppBar** — `<Toolbar />` below AppBar
- **Keep actions minimal** — 2-4 icons maximum

### Elevation Guidelines

- **Consistent elevation** — Same elevation for similar elements
- **Lower is calmer** — Use `elevation={0}` or `variant="outlined"` for subtle surfaces
- **Reserve high elevation** — For modals and overlays
