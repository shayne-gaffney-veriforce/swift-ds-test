# Page Patterns

Rough layouts for the two main page types. Content beneath headers and tabs is variable — these patterns define the consistent outer shell only.

---

## List Page

A page title with an optional action, an optional search/filter toolbar, followed by a data table.

```
┌──────────────────────────────────────────────────┐
│  Page Title (h4)                    [Add Button]  │
├──────────────────────────────────────────────────┤
│  [🔍 Search...]               [Filter] [Filter]  │
├──────────────────────────────────────────────────┤
│  ┌──────────────────────────────────────────────┐ │
│  │  Table header                                 │ │
│  │  ────────────────────────────────────────────  │ │
│  │  Row                                          │ │
│  │  Row                                          │ │
│  │  Row                                          │ │
│  └──────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────┘
```

### Header

```tsx
<Stack direction="row" justifyContent="space-between" alignItems="center" sx={{ mb: 3 }}>
  <Typography variant="h4">Page Title</Typography>
  <Button variant="contained" startIcon={<FontAwesomeIcon icon={faPlus} />}>
    Add Item
  </Button>
</Stack>
```

- Title on the left, `h4` variant
- One primary `contained` button on the right (optional)
- `mb: 3` below the header

### Toolbar (optional)

Sits between the header and the table. Search on the left, filters on the right.

```tsx
<Stack direction="row" justifyContent="space-between" alignItems="center" sx={{ mb: 2 }}>
  <TextField
    size="small"
    placeholder="Search contractors..."
    value={search}
    onChange={(e) => setSearch(e.target.value)}
    slotProps={{
      input: {
        startAdornment: (
          <InputAdornment position="start">
            <FontAwesomeIcon icon={faMagnifyingGlass} />
          </InputAdornment>
        ),
      },
    }}
    sx={{ width: 300 }}
  />
  <Stack direction="row" spacing={1}>
    {/* Optional filters — chips, selects, toggle buttons, etc. */}
  </Stack>
</Stack>
```

- Search field: `size="small"`, fixed width (~300px), magnifying glass adornment
- Filters are optional — use whatever control fits (chip toggles, selects, etc.)
- `mb: 2` below the toolbar

---

## Detail Page

Use when viewing a single entity. A back button and title row, followed by tabs. Content under tabs is entirely variable.

```
┌──────────────────────────────────────────────────┐
│  [←]  Entity Name (h4)  [Chip]    [Edit Button]  │
├──────────────────────────────────────────────────┤
│  Overview  │  Certificates  │  Activity           │
│ ─────────────────────────────────────────────────  │
│                                                    │
│  (variable tab content — cards, tables, etc.)      │
│                                                    │
└──────────────────────────────────────────────────┘
```

### DetailLayout Component

Use `DetailLayout` from `~/components/detail-layout`:

```tsx
<DetailLayout
  title="Entity Name"
  backTo="/list"
  backLabel="Back to list"
  chip={<Chip label="Active" color="success" size="small" variant="outlined" />}
  action={<Button variant="contained">Edit</Button>}
  tabs={[
    { label: "Overview", content: <OverviewTab /> },
    { label: "Certificates", content: <CertificatesTab /> },
    { label: "Activity", content: <ActivityTab /> },
  ]}
/>
```

| Prop | Required | Description |
|------|----------|-------------|
| `title` | Yes | Entity name, rendered as `h4` |
| `backTo` | Yes | Path for the back chevron |
| `backLabel` | Yes | `aria-label` for the back button |
| `chip` | No | Status chip next to the title |
| `action` | No | Primary action button on the right |
| `tabs` | Yes | Array of `{ label, content }` |

### Guidelines

- Back chevron always navigates to the parent list page
- Tab labels: one or two words max
- Handle not-found state with a back button and a message — not a blank page
- Content under each tab is variable — cards, tables, forms, whatever the entity needs
