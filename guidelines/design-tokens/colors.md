# Color Tokens

## Token Architecture

Colors are defined in two places that **must stay in sync**:

1. **CSS Variables** (`app/styles/colors.css`) - For CSS-based styling
2. **TypeScript Constants** (`app/theme/colorConstants.ts`) - For MUI theme

---

## Color Scales

### Base Colors
| Token | CSS Variable | Value |
|-------|--------------|-------|
| `base.black` | `--color-base-black` | `#000000` |
| `base.white` | `--color-base-white` | `#ffffff` |

### Gray Scale
| Token | CSS Variable | Value | Usage |
|-------|--------------|-------|-------|
| `gray[50]` | `--color-gray-50` | `#fafafa` | Lightest backgrounds |
| `gray[100]` | `--color-gray-100` | `#f4f4f5` | Light backgrounds |
| `gray[200]` | `--color-gray-200` | `#e4e4e7` | Borders, dividers |
| `gray[300]` | `--color-gray-300` | `#d4d4d8` | Disabled states |
| `gray[400]` | `--color-gray-400` | `#a1a1aa` | Placeholder text |
| `gray[500]` | `--color-gray-500` | `#71717a` | Secondary text |
| `gray[600]` | `--color-gray-600` | `#52525b` | Icons |
| `gray[700]` | `--color-gray-700` | `#3f3f46` | Primary text (light mode) |
| `gray[800]` | `--color-gray-800` | `#27272a` | Headings |
| `gray[900]` | `--color-gray-900` | `#18181b` | Darkest text |

### Ink Scale (Blue-gray)
| Token | CSS Variable | Value |
|-------|--------------|-------|
| `ink[50]` | `--color-ink-50` | `#f5f9fc` |
| `ink[100]` | `--color-ink-100` | `#ecf3f8` |
| `ink[200]` | `--color-ink-200` | `#dee8ef` |
| `ink[300]` | `--color-ink-300` | `#c3d4e0` |
| `ink[400]` | `--color-ink-400` | `#8ba5b8` |
| `ink[500]` | `--color-ink-500` | `#54778f` |
| `ink[600]` | `--color-ink-600` | `#345872` |
| `ink[700]` | `--color-ink-700` | `#1f445c` |
| `ink[800]` | `--color-ink-800` | `#002a42` |
| `ink[900]` | `--color-ink-900` | `#051723` |

### Blue Scale (Primary)
| Token | CSS Variable | Value |
|-------|--------------|-------|
| `blue[50]` | `--color-blue-50` | `#eff5ff` |
| `blue[100]` | `--color-blue-100` | `#dbe8fd` |
| `blue[200]` | `--color-blue-200` | `#c2daff` |
| `blue[300]` | `--color-blue-300` | `#94bcff` |
| `blue[400]` | `--color-blue-400` | `#719ef9` |
| `blue[500]` | `--color-blue-500` | `#457cf9` |
| `blue[600]` | `--color-blue-600` | `#215bea` |
| `blue[700]` | `--color-blue-700` | `#134bdc` | **Primary main** |
| `blue[800]` | `--color-blue-800` | `#123eb0` | **Primary dark** |
| `blue[900]` | `--color-blue-900` | `#0d3086` |

### Red Scale (Error)
| Token | CSS Variable | Value |
|-------|--------------|-------|
| `red[50]` | `--color-red-50` | `#fef2f2` |
| `red[100]` | `--color-red-100` | `#fee2e2` |
| `red[200]` | `--color-red-200` | `#fecaca` |
| `red[300]` | `--color-red-300` | `#fca5a5` |
| `red[400]` | `--color-red-400` | `#f87171` | **Error light** |
| `red[500]` | `--color-red-500` | `#ef4444` |
| `red[600]` | `--color-red-600` | `#dc2626` |
| `red[700]` | `--color-red-700` | `#b91c1c` | **Error main** |
| `red[800]` | `--color-red-800` | `#991b1b` | **Error dark** |
| `red[900]` | `--color-red-900` | `#7f1d1d` |

### Green Scale (Success)
| Token | CSS Variable | Value |
|-------|--------------|-------|
| `green[50]` | `--color-green-50` | `#ecfdf5` |
| `green[100]` | `--color-green-100` | `#d1fae5` |
| `green[200]` | `--color-green-200` | `#a7f3d0` |
| `green[300]` | `--color-green-300` | `#6ee7b7` |
| `green[400]` | `--color-green-400` | `#34d399` |
| `green[500]` | `--color-green-500` | `#10b981` | **Success light** |
| `green[600]` | `--color-green-600` | `#059669` |
| `green[700]` | `--color-green-700` | `#047857` | **Success main** |
| `green[800]` | `--color-green-800` | `#065f46` | **Success dark** |
| `green[900]` | `--color-green-900` | `#064e3b` |

### Orange Scale (Warning)
| Token | CSS Variable | Value |
|-------|--------------|-------|
| `orange[50]` | `--color-orange-50` | `#fff7ed` |
| `orange[100]` | `--color-orange-100` | `#ffedd5` |
| `orange[200]` | `--color-orange-200` | `#fed7aa` |
| `orange[300]` | `--color-orange-300` | `#fdba74` |
| `orange[400]` | `--color-orange-400` | `#fb923c` | **Warning light** |
| `orange[500]` | `--color-orange-500` | `#f97316` | **Warning main** |
| `orange[600]` | `--color-orange-600` | `#ea580c` | **Warning dark** |
| `orange[700]` | `--color-orange-700` | `#c2410c` |
| `orange[800]` | `--color-orange-800` | `#9a3412` |
| `orange[900]` | `--color-orange-900` | `#7c2d12` |

### Amber Scale
| Token | CSS Variable | Value |
|-------|--------------|-------|
| `amber[50]` | `--color-amber-50` | `#fffbeb` |
| `amber[100]` | `--color-amber-100` | `#fef3c7` |
| `amber[200]` | `--color-amber-200` | `#fde68a` |
| `amber[300]` | `--color-amber-300` | `#fcd34d` |
| `amber[400]` | `--color-amber-400` | `#fbbf24` |
| `amber[500]` | `--color-amber-500` | `#f59e0b` |
| `amber[600]` | `--color-amber-600` | `#d97706` |
| `amber[700]` | `--color-amber-700` | `#b45309` |
| `amber[800]` | `--color-amber-800` | `#92400e` |
| `amber[900]` | `--color-amber-900` | `#78350f` |

---

## Brand Colors (MUI Palette)

| Role | Light | Main | Dark |
|------|-------|------|------|
| **Primary** | `blue[400]` | `blue[700]` | `blue[800]` |
| **Secondary** | `gray[300]` | `gray[500]` | `gray[700]` |
| **Error** | `red[400]` | `red[700]` | `red[800]` |
| **Warning** | `orange[400]` | `orange[500]` | `orange[600]` |
| **Info** | `blue[500]` | `blue[700]` | `blue[900]` |
| **Success** | `green[500]` | `green[700]` | `green[800]` |

---

## State Colors (Opacity-based)

### Black States (Light Mode)
| Token | CSS Variable | Value | Usage |
|-------|--------------|-------|-------|
| `states.black.hover` | `--color-black-hover` | `rgba(0,0,0,0.04)` | Hover backgrounds |
| `states.black.selected` | `--color-black-selected` | `rgba(0,0,0,0.08)` | Selected state |
| `states.black.focus` | `--color-black-focus` | `rgba(0,0,0,0.12)` | Focus rings |
| `states.black.focusVisible` | `--color-black-focus-visible` | `rgba(0,0,0,0.3)` | Keyboard focus |
| `states.black.textSecondary` | `--color-black-text-secondary` | `rgba(0,0,0,0.6)` | Secondary text |
| `states.black.textPrimary` | `--color-black-text-primary` | `rgba(0,0,0,0.87)` | Primary text |

### Primary/Secondary/Semantic States
Each semantic color has hover, selected, and focusVisible states at consistent opacities.

---

## Usage

### In MUI Components (sx prop)
```tsx
<Box sx={{ 
  bgcolor: 'primary.main',
  color: 'primary.contrastText',
}} />
```

### In TypeScript (direct import)
```tsx
import { blue, gray, states } from '~/theme/theme';

<Box sx={{ 
  bgcolor: blue[100],
  borderColor: gray[300],
}} />
```

### In CSS
```css
.my-element {
  background-color: var(--color-blue-100);
  border-color: var(--color-gray-300);
}
```
