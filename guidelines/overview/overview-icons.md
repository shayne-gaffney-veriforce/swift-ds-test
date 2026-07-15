# Icons

**FontAwesome (Free) only.** Do not use MUI icons.

```tsx
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faPlus } from "@fortawesome/free-solid-svg-icons";

<FontAwesomeIcon icon={faPlus} />
```

---

## Common Icons

| Use Case | Icon |
|----------|------|
| Add | `faPlus` |
| Edit | `faPen` |
| Delete | `faTrash` |
| View | `faEye` |
| Search | `faMagnifyingGlass` |
| Close | `faXmark` |
| Back | `faChevronLeft` |
| Dropdown | `faChevronDown` |
| Copy | `faCopy` |
| Menu | `faBars` |
| Settings | `faGear` |
| User | `faUser` |
| Notifications | `faBell` |
| Check | `faCheck` |
| Warning | `faTriangleExclamation` |
| Info | `faCircleInfo` |
| Error | `faCircleXmark` |

All from `@fortawesome/free-solid-svg-icons`. Use `@fortawesome/free-regular-svg-icons` for outlined variants.

---

## With MUI Components

```tsx
// Inside a Button
<Button startIcon={<FontAwesomeIcon icon={faPlus} />}>Add Item</Button>

// Icon-only button
<IconButton aria-label="Edit"><FontAwesomeIcon icon={faPen} /></IconButton>
```

---

## Sizing

| Prop | Size |
|------|------|
| `xs` | 0.75em |
| `sm` | 0.875em |
| (default) | 1em |
| `lg` | 1.25em |
| `xl` | 1.5em |

Icons inherit color from their parent by default.
