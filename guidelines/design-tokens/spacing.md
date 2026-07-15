# Spacing Tokens

## MUI Spacing System

MUI uses a spacing scale where `1 unit = 8px` by default.

| Units | Pixels | Usage |
|-------|--------|-------|
| 0.5 | 4px | Tight spacing |
| 1 | 8px | Small gaps |
| 2 | 16px | Standard spacing |
| 3 | 24px | Medium spacing |
| 4 | 32px | Large spacing |
| 5 | 40px | Section spacing |
| 6 | 48px | Large sections |
| 8 | 64px | Page-level spacing |

## Usage in sx Prop

```tsx
<Box sx={{ 
  p: 2,      // padding: 16px (all sides)
  px: 3,     // padding-left & right: 24px
  py: 1,     // padding-top & bottom: 8px
  pt: 2,     // padding-top: 16px
  m: 1,      // margin: 8px
  gap: 2,    // gap: 16px (for flex/grid)
}}>
```

## Spacing Shorthand

- `p` - padding (all)
- `pt`, `pr`, `pb`, `pl` - padding top/right/bottom/left
- `px` - padding horizontal (left + right)
- `py` - padding vertical (top + bottom)
- `m` - margin (all)
- `mt`, `mr`, `mb`, `ml` - margin top/right/bottom/left
- `mx` - margin horizontal
- `my` - margin vertical

## Stack Spacing

```tsx
<Stack spacing={2}>  {/* 16px gap between children */}
  <Item />
  <Item />
</Stack>
```

## Grid Spacing

```tsx
<Grid container spacing={3}>  {/* 24px gap */}
  <Grid item xs={6}>...</Grid>
  <Grid item xs={6}>...</Grid>
</Grid>
```

## Custom Spacing Function

```tsx
// In styled components
const StyledBox = styled('div')(({ theme }) => ({
  padding: theme.spacing(2),        // 16px
  margin: theme.spacing(1, 2),      // 8px 16px
  gap: theme.spacing(3),            // 24px
}));
```
