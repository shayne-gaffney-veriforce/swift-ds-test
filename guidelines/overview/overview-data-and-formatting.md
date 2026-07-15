# Data & Formatting

Formatting rules for all data displayed in the UI. Follow these when generating sample data.

---

## Dates

**Default:** `MMM DD, YYYY` (e.g. Jun 10, 2026)

| Context | Format | Example |
|---------|--------|---------|
| Current year | MMM DD | Jun 10 |
| Different year | MMM DD, YYYY | Jun 10, 2025 |
| Compact / tables | MM/DD/YY | 06/10/26 |
| Ranges (same month) | MMM DD–DD, YYYY | Jun 10–12, 2026 |
| Ranges (cross month) | MMM DD – MMM DD, YYYY | Jun 28 – Jul 3, 2026 |
| Relative (< 24h) | Relative | 3 hours ago, Just now |
| Relative (< 7 days) | Day name | Tuesday |

US date ordering (month first) is the default.

## Time

**Default:** 12-hour with AM/PM (e.g. 3:45 PM)

| Context | Format | Example |
|---------|--------|---------|
| General | h:mm AM/PM | 3:45 PM |
| With timezone | Abbreviation | 3:45 PM CST |
| Ranges | En-dash | 9:00 AM – 5:00 PM |
| Duration | Spelled units | 2h 30m |

## Numbers

**Default:** US English (commas for thousands, period for decimals)

| Context | Format | Example |
|---------|--------|---------|
| Large numbers | Thousands separator | 12,450 |
| Percentages | No space before % | 87.5% |
| Counts (exact) | Full number | 1,248 contractors |
| Counts (approximate) | Abbreviated | 12.4K, 1.2M |
| Ranges | En-dash | 10–50 |

## Currency

**Default:** USD with symbol prefix (e.g. $12,450)

| Context | Format | Example |
|---------|--------|---------|
| Whole amounts | No decimals | $12,450 |
| Exact amounts | Two decimals | $12,450.75 |
| Abbreviated | Symbol + short | $1.2M |
| Non-USD | ISO code | 12,450 EUR |

## Phone Numbers

| Context | Format | Example |
|---------|--------|---------|
| US/Canada | (XXX) XXX-XXXX | (512) 555-0147 |
| International | +CC format | +44 20 7946 0958 |

## Addresses

US default: Street, City, State ZIP. Use two-letter state codes. In compact/table views show City, State only.

## Names

| Context | Format | Example |
|---------|--------|---------|
| Full display | First Last | Maria Garcia |
| Avatar fallback | Initials | MG |
| Compact / table | Last, F. | Garcia, M. |

## Status Values

| Type | Display |
|------|---------|
| Active/inactive | Chip with color (success / default) |
| Compliance | Chip with severity (success / error / warning) |
| Empty/null | Em-dash (—) |

Never display raw booleans, `null`, or `undefined`. Use color semantically: green = good, red = problem, yellow = needs attention.

---

## Sample Data

- Diverse, realistic names (not "John Doe")
- 555-prefixed US phone numbers
- `@example.com` email domains
- Dates relative to the current date
- Plausible currency amounts for the context
