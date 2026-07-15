# Typography

Always use the MUI `Typography` component for text. Never use raw HTML (`<h1>`, `<p>`, `<span>`).

```tsx
import Typography from '@mui/material/Typography';
```

**Typeface:** Instrument Sans (primary), Roboto Mono (code/monospace).

---

## Variants

### Headings

| Variant | Use For |
|---------|---------|
| `h1` | Main page title — one per page |
| `h2` | Major section breaks |
| `h3` | Subsections, card group headers |
| `h4` | Page titles, card titles, dialog headers |
| `h5` | List headers, form section labels |
| `h6` | Smallest headers |

### Body

| Variant | Use For |
|---------|---------|
| `body1` | Primary content, paragraphs |
| `body2` | Secondary descriptions, metadata |
| `subtitle1` | Emphasized body text (medium weight) |
| `subtitle2` | Emphasized secondary text (medium weight) |
| `caption` | Helper text, timestamps, footnotes |
| `overline` | Category labels (renders uppercase) |

---

## Text Colors

```tsx
<Typography color="text.primary">Main content</Typography>
<Typography color="text.secondary">Supporting content</Typography>
<Typography color="text.disabled">Unavailable</Typography>
<Typography color="error.main">Error</Typography>
<Typography color="success.main">Success</Typography>
```

---

## Common Patterns

### Page title

```tsx
<Typography variant="h4">Contractors</Typography>
```

### Card content

```tsx
<Typography variant="h5" gutterBottom>Card Title</Typography>
<Typography variant="body2" color="text.secondary">Description text.</Typography>
```

### Timestamp

```tsx
<Typography variant="caption" color="text.secondary">5 minutes ago</Typography>
```

### Detail field label

```tsx
<Typography variant="caption" color="text.secondary" sx={{ display: 'block', mb: 0.5 }}>
  Email
</Typography>
<Typography variant="body2">alex@example.com</Typography>
```

---

## Rules

- Maintain heading hierarchy — don't skip levels
- Use `text.primary` for body content, `text.secondary` for supporting text only
- Don't hardcode font styles — use variants
- Don't use `Typography` inside `TableCell` — the cell inherits 14px from the theme; use `sx={{ color: 'text.secondary' }}` on the cell instead
