# Inputs

Form input components for capturing user data.

---

## Quick Reference

| Component | Use For |
|-----------|---------|
| `TextField` | Text, email, password, numbers, multiline |
| `Select` | Choosing from predefined options |
| `Autocomplete` | Searchable select, tagging |
| `Checkbox` | Boolean or multiple selections |
| `Radio` | Single selection from a group |
| `Switch` | Toggle binary settings |
| `Slider` | Selecting from a range |
| `Rating` | Star ratings, reviews |

---

## Imports

```tsx
import TextField from '@mui/material/TextField';
import Select from '@mui/material/Select';
import MenuItem from '@mui/material/MenuItem';
import Autocomplete from '@mui/material/Autocomplete';
import Checkbox from '@mui/material/Checkbox';
import Radio from '@mui/material/Radio';
import RadioGroup from '@mui/material/RadioGroup';
import Switch from '@mui/material/Switch';
import Slider from '@mui/material/Slider';
import Rating from '@mui/material/Rating';
import FormControl from '@mui/material/FormControl';
import FormControlLabel from '@mui/material/FormControlLabel';
import FormLabel from '@mui/material/FormLabel';
import InputLabel from '@mui/material/InputLabel';
import InputAdornment from '@mui/material/InputAdornment';
```

---

## TextField Patterns

### Basic Input

```tsx
<TextField label="Email" type="email" fullWidth />
<TextField label="Password" type="password" fullWidth />
```

### With Validation Error

```tsx
<TextField
  label="Email"
  error={!isValidEmail}
  helperText={!isValidEmail ? 'Please enter a valid email' : ''}
  fullWidth
/>
```

### Required Field

```tsx
<TextField label="Name" required fullWidth />
```

### With Helper Text

```tsx
<TextField
  label="Username"
  helperText="Letters, numbers, and underscores only"
  fullWidth
/>
```

### With Icon

```tsx
<TextField
  label="Search"
  InputProps={{
    startAdornment: (
      <InputAdornment position="start">
        <FontAwesomeIcon icon={faSearch} />
      </InputAdornment>
    ),
  }}
/>

<TextField
  label="Amount"
  InputProps={{
    startAdornment: <InputAdornment position="start">$</InputAdornment>,
  }}
/>
```

### Multiline / Textarea

```tsx
<TextField
  label="Description"
  multiline
  rows={4}
  fullWidth
/>

// Auto-growing
<TextField
  label="Notes"
  multiline
  minRows={2}
  maxRows={6}
  fullWidth
/>
```

### Size Variants

```tsx
<TextField size="medium" />  // Default, use for most forms
<TextField size="small" />   // Dense UIs, tables, toolbars
```

---

## Select Patterns

### Basic Select

```tsx
<FormControl fullWidth>
  <InputLabel>Status</InputLabel>
  <Select
    value={status}
    label="Status"
    onChange={(e) => setStatus(e.target.value)}
  >
    <MenuItem value="active">Active</MenuItem>
    <MenuItem value="pending">Pending</MenuItem>
    <MenuItem value="inactive">Inactive</MenuItem>
  </Select>
</FormControl>
```

### Multiple Selection

```tsx
<FormControl fullWidth>
  <InputLabel>Tags</InputLabel>
  <Select
    multiple
    value={selectedTags}
    label="Tags"
    onChange={(e) => setSelectedTags(e.target.value)}
    renderValue={(selected) => selected.join(', ')}
  >
    {tags.map((tag) => (
      <MenuItem key={tag} value={tag}>
        <Checkbox checked={selectedTags.includes(tag)} />
        <ListItemText primary={tag} />
      </MenuItem>
    ))}
  </Select>
</FormControl>
```

---

## Autocomplete Patterns

### Searchable Select

```tsx
<Autocomplete
  options={countries}
  renderInput={(params) => <TextField {...params} label="Country" />}
/>
```

### With Objects

```tsx
<Autocomplete
  options={users}
  getOptionLabel={(option) => option.name}
  renderInput={(params) => <TextField {...params} label="Assignee" />}
/>
```

### Multi-Select Tags

```tsx
<Autocomplete
  multiple
  options={availableTags}
  value={selectedTags}
  onChange={(e, newValue) => setSelectedTags(newValue)}
  renderInput={(params) => <TextField {...params} label="Tags" />}
/>
```

### Allow Custom Values

```tsx
<Autocomplete
  freeSolo
  options={suggestions}
  renderInput={(params) => <TextField {...params} label="Enter or select" />}
/>
```

---

## Checkbox Patterns

### Single Checkbox

```tsx
<FormControlLabel
  control={<Checkbox checked={agreed} onChange={(e) => setAgreed(e.target.checked)} />}
  label="I agree to the terms and conditions"
/>
```

### Checkbox Group

```tsx
<FormControl>
  <FormLabel>Notifications</FormLabel>
  {options.map((option) => (
    <FormControlLabel
      key={option.value}
      control={
        <Checkbox
          checked={selected.includes(option.value)}
          onChange={() => toggleOption(option.value)}
        />
      }
      label={option.label}
    />
  ))}
</FormControl>
```

### Select All Pattern

```tsx
<FormControlLabel
  control={
    <Checkbox
      checked={allSelected}
      indeterminate={someSelected && !allSelected}
      onChange={handleSelectAll}
    />
  }
  label="Select all"
/>
```

---

## Radio Patterns

### Radio Group

```tsx
<FormControl>
  <FormLabel>Plan</FormLabel>
  <RadioGroup value={plan} onChange={(e) => setPlan(e.target.value)}>
    <FormControlLabel value="free" control={<Radio />} label="Free" />
    <FormControlLabel value="pro" control={<Radio />} label="Pro — $10/month" />
    <FormControlLabel value="enterprise" control={<Radio />} label="Enterprise" />
  </RadioGroup>
</FormControl>
```

### Horizontal Layout

```tsx
<RadioGroup row value={alignment} onChange={(e) => setAlignment(e.target.value)}>
  <FormControlLabel value="left" control={<Radio />} label="Left" />
  <FormControlLabel value="center" control={<Radio />} label="Center" />
  <FormControlLabel value="right" control={<Radio />} label="Right" />
</RadioGroup>
```

---

## Switch Patterns

### Settings Toggle

```tsx
<FormControlLabel
  control={<Switch checked={enabled} onChange={(e) => setEnabled(e.target.checked)} />}
  label="Enable notifications"
/>
```

### With Label on Left

```tsx
<FormControlLabel
  control={<Switch checked={darkMode} onChange={toggleDarkMode} />}
  label="Dark mode"
  labelPlacement="start"
  sx={{ justifyContent: 'space-between', ml: 0 }}
/>
```

---

## Slider Patterns

### Basic Slider

```tsx
<Slider
  value={volume}
  onChange={(e, newValue) => setVolume(newValue)}
  aria-label="Volume"
/>
```

### With Value Label

```tsx
<Slider
  value={brightness}
  onChange={(e, newValue) => setBrightness(newValue)}
  valueLabelDisplay="auto"
  min={0}
  max={100}
/>
```

### Range Slider

```tsx
<Slider
  value={priceRange}
  onChange={(e, newValue) => setPriceRange(newValue)}
  valueLabelDisplay="auto"
  min={0}
  max={1000}
  valueLabelFormat={(value) => `$${value}`}
/>
```

---

## Rating Patterns

### Editable Rating

```tsx
<Rating
  value={rating}
  onChange={(e, newValue) => setRating(newValue)}
/>
```

### Read-Only Display

```tsx
<Rating value={4.5} precision={0.5} readOnly />
```

---

## Form Patterns

### Complete Form

```tsx
<form onSubmit={handleSubmit}>
  <Stack spacing={3}>
    <TextField label="Full name" required fullWidth />
    
    <TextField
      label="Email"
      type="email"
      required
      fullWidth
      error={!!errors.email}
      helperText={errors.email}
    />
    
    <FormControl fullWidth>
      <InputLabel>Country</InputLabel>
      <Select label="Country" value={country} onChange={handleCountryChange}>
        <MenuItem value="us">United States</MenuItem>
        <MenuItem value="uk">United Kingdom</MenuItem>
      </Select>
    </FormControl>
    
    <FormControlLabel
      control={<Checkbox required />}
      label="I agree to the terms and conditions"
    />
    
    <Stack direction="row" spacing={2} justifyContent="flex-end">
      <Button variant="text">Cancel</Button>
      <Button type="submit" variant="contained">Submit</Button>
    </Stack>
  </Stack>
</form>
```

### Inline Validation

```tsx
<TextField
  label="Email"
  value={email}
  onChange={(e) => setEmail(e.target.value)}
  onBlur={() => setTouched(true)}
  error={touched && !isValidEmail(email)}
  helperText={touched && !isValidEmail(email) ? 'Please enter a valid email' : ''}
/>
```

### Form Validation on Submit

- **Save button is never disabled** — users can click it at any time
- **Validation triggers on Save click** — validate all fields, set error states
- **Alert at top of form** — show `<Alert severity="error">` with summary message (e.g., "Please fix the errors below")
- **Field-level errors** — each invalid field shows its error via `helperText`

```tsx
<Stack spacing={3}>
  {hasErrors && (
    <Alert severity="error">Please fix the errors below before saving.</Alert>
  )}
  <TextField error={!!errors.name} helperText={errors.name} ... />
  <TextField error={!!errors.email} helperText={errors.email} ... />
  <Button variant="contained" onClick={handleSave}>Save</Button>
</Stack>
```

---

## Best Practices

### Labels

- **Always use labels** — Every input needs a visible label
- **Use `label` prop** — Not placeholder as the only label
- **Be concise** — "Email" not "Please enter your email address"

```tsx
// ❌ Placeholder as label
<TextField placeholder="Email" />

// ✅ Proper label
<TextField label="Email" placeholder="you@example.com" />
```

### Helper Text

- **Guide users** — Format expectations, character limits
- **Don't duplicate labels** — "Enter email" under an "Email" label is redundant
- **Use for errors** — Show specific error messages

### Validation

- **Validate on blur** — Don't show errors while typing
- **Be specific** — "Email must include @" not "Invalid email"
- **Show success too** — Green checkmark for valid fields (optional)

### Form Layout

- **Use Stack** — Consistent spacing between fields
- **Full width on mobile** — `fullWidth` for most fields
- **Group related fields** — Address fields together, etc.
- **Logical tab order** — Top to bottom, left to right

### Accessibility

- **Required fields** — Use `required` prop, not just visual indicators
- **Error announcements** — Errors should be announced to screen readers
- **Label association** — Labels must be properly connected to inputs (handled by MUI)

### Choosing Input Types

| Need | Use |
|------|-----|
| One of few options | `Select` |
| One of many options | `Autocomplete` |
| Multiple selections (few options) | `Checkbox` group |
| Multiple selections (many options) | `Autocomplete` with `multiple` |
| Binary choice (on/off) | `Switch` |
| Binary choice (agree/disagree) | `Checkbox` |
| One from a small set | `Radio` group |
| Numeric range | `Slider` |
| Star rating | `Rating` |
