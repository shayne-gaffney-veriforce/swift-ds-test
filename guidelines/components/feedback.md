# Feedback

Components for communicating system status, results, and responses to user actions.

---

## Quick Reference

| Component | Use For |
|-----------|---------|
| `Alert` | Inline status messages (success, error, warning, info) |
| `Snackbar` | Brief, auto-dismissing notifications |
| `Dialog` | Focused interactions requiring user decision |
| `CircularProgress` | Loading states, button spinners |
| `LinearProgress` | Page/section loading, upload progress |
| `Skeleton` | Content placeholders while loading |
| `Backdrop` | Full-screen loading overlay (use sparingly) |

---

## Imports

```tsx
import Alert from '@mui/material/Alert';
import AlertTitle from '@mui/material/AlertTitle';
import Snackbar from '@mui/material/Snackbar';
import Dialog from '@mui/material/Dialog';
import DialogTitle from '@mui/material/DialogTitle';
import DialogContent from '@mui/material/DialogContent';
import DialogContentText from '@mui/material/DialogContentText';
import DialogActions from '@mui/material/DialogActions';
import CircularProgress from '@mui/material/CircularProgress';
import LinearProgress from '@mui/material/LinearProgress';
import Skeleton from '@mui/material/Skeleton';
import Backdrop from '@mui/material/Backdrop';
```

---

## Alert Patterns

Alerts display important messages inline with the content.

**IMPORTANT**: When creating banners, notices, or any inline status message, ALWAYS use the `<Alert>` component. Do NOT create custom boxes with text styling — the Alert component provides consistent styling, accessibility, and proper semantic meaning.

```tsx
// ❌ Don't create custom "banner" boxes
<Box sx={{ p: 2, bgcolor: 'warning.light', borderRadius: 1 }}>
  <Typography>This is a warning message</Typography>
</Box>

// ✅ Use Alert for all banner/notice patterns
<Alert severity="warning">This is a warning message</Alert>
```

### Severity Levels

| Severity | Use For |
|----------|---------|
| `success` | Action completed, positive confirmation |
| `error` | Failed action, validation errors |
| `warning` | Caution, potential issues, expiring states |
| `info` | Neutral information, tips, updates |

```tsx
<Alert severity="success">Changes saved successfully</Alert>
<Alert severity="error">Unable to save. Please try again.</Alert>
<Alert severity="warning">Your session expires in 5 minutes</Alert>
<Alert severity="info">New features are available</Alert>
```

### Alert with Title

For important messages that need emphasis:

```tsx
<Alert severity="error">
  <AlertTitle>Payment failed</AlertTitle>
  Your card was declined. Please update your payment method.
</Alert>
```

### Dismissible Alert

```tsx
<Alert severity="info" onClose={() => setShowAlert(false)}>
  You have 3 unread messages
</Alert>
```

### Alert with Action

```tsx
<Alert
  severity="warning"
  action={
    <Button color="inherit" size="small">
      Extend session
    </Button>
  }
>
  Your session expires in 5 minutes
</Alert>
```

---

## Snackbar Patterns

Snackbars show brief, auto-dismissing messages.

### Success Notification

```tsx
<Snackbar
  open={showSuccess}
  autoHideDuration={4000}
  onClose={() => setShowSuccess(false)}
>
  <Alert severity="success" onClose={() => setShowSuccess(false)}>
    Changes saved successfully
  </Alert>
</Snackbar>
```

### Error Notification (Longer Duration)

Errors need more time to read:

```tsx
<Snackbar
  open={showError}
  autoHideDuration={6000}
  onClose={() => setShowError(false)}
>
  <Alert severity="error" onClose={() => setShowError(false)}>
    Unable to save changes. Please try again.
  </Alert>
</Snackbar>
```

### With Undo Action

```tsx
<Snackbar
  open={showUndo}
  autoHideDuration={5000}
  onClose={handleClose}
  message="Item removed"
  action={
    <Button color="inherit" size="small" onClick={handleUndo}>
      Undo
    </Button>
  }
/>
```

### Position

```tsx
// Bottom-left (default) — good for most cases
<Snackbar anchorOrigin={{ vertical: 'bottom', horizontal: 'left' }} />

// Top-center — for important notifications
<Snackbar anchorOrigin={{ vertical: 'top', horizontal: 'center' }} />
```

---

## Dialog Patterns

Dialogs focus user attention on a decision or task.

### Confirmation Dialog

**Important**: Avoid Yes/No buttons. Use specific action labels.

```tsx
<Dialog open={open} onClose={handleClose}>
  <DialogTitle>Remove item?</DialogTitle>
  <DialogContent>
    <DialogContentText>
      This will permanently remove "{item.name}". This action cannot be undone.
    </DialogContentText>
  </DialogContent>
  <DialogActions>
    <Button variant="text" color="secondary" onClick={handleClose}>Cancel</Button>
    <Button variant="contained" color="error" onClick={handleRemove}>
      Remove
    </Button>
  </DialogActions>
</Dialog>
```

### Form Dialog

```tsx
<Dialog open={open} onClose={handleClose} maxWidth="sm" fullWidth>
  <DialogTitle>Edit profile</DialogTitle>
  <DialogContent>
    <Stack spacing={2} sx={{ mt: 1 }}>
      <TextField label="Name" fullWidth defaultValue={user.name} />
      <TextField label="Email" fullWidth defaultValue={user.email} />
    </Stack>
  </DialogContent>
  <DialogActions>
    <Button variant="text" color="secondary" onClick={handleClose}>Cancel</Button>
    <Button variant="contained" onClick={handleSave}>Save</Button>
  </DialogActions>
</Dialog>
```

### Info Dialog

For non-destructive information:

```tsx
<Dialog open={open} onClose={handleClose}>
  <DialogTitle>Keyboard shortcuts</DialogTitle>
  <DialogContent>
    <List>
      <ListItem><ListItemText primary="⌘S" secondary="Save" /></ListItem>
      <ListItem><ListItemText primary="⌘Z" secondary="Undo" /></ListItem>
    </List>
  </DialogContent>
  <DialogActions>
    <Button variant="text" color="secondary" onClick={handleClose}>Close</Button>
  </DialogActions>
</Dialog>
```

### Dialog Sizes

```tsx
<Dialog maxWidth="xs" fullWidth>...</Dialog>  // Narrow (confirmations)
<Dialog maxWidth="sm" fullWidth>...</Dialog>  // Default (forms)
<Dialog maxWidth="md" fullWidth>...</Dialog>  // Wide (complex content)
<Dialog fullScreen>...</Dialog>               // Mobile or immersive
```

---

## Progress Patterns

### Button Loading State

```tsx
<Button
  variant="contained"
  disabled={isLoading}
  onClick={handleSave}
>
  {isLoading ? (
    <>
      <CircularProgress size={16} color="inherit" sx={{ mr: 1 }} />
      Saving...
    </>
  ) : (
    'Save'
  )}
</Button>
```

### Page Loading

```tsx
{isLoading && <LinearProgress sx={{ position: 'absolute', top: 0, left: 0, right: 0 }} />}
```

### Determinate Progress

For uploads or multi-step processes:

```tsx
<LinearProgress variant="determinate" value={uploadProgress} />
<Typography variant="caption">{uploadProgress}% uploaded</Typography>
```

---

## Skeleton Patterns

Skeletons provide better perceived performance than spinners for content loading.

### Text Content

```tsx
{isLoading ? (
  <Stack spacing={1}>
    <Skeleton variant="text" width="60%" />
    <Skeleton variant="text" width="80%" />
    <Skeleton variant="text" width="40%" />
  </Stack>
) : (
  <Typography>{content}</Typography>
)}
```

### Card Skeleton

```tsx
{isLoading ? (
  <Card>
    <Skeleton variant="rectangular" height={140} />
    <CardContent>
      <Skeleton variant="text" width="70%" height={28} />
      <Skeleton variant="text" />
      <Skeleton variant="text" width="50%" />
    </CardContent>
  </Card>
) : (
  <ActualCard />
)}
```

### Avatar Skeleton

```tsx
<Skeleton variant="circular" width={40} height={40} />
```

---

## Backdrop Patterns

Use backdrops sparingly — prefer inline loading states.

### Full Page Loading

Only for operations that block all interaction:

```tsx
<Backdrop open={isLoading} sx={{ zIndex: (theme) => theme.zIndex.modal + 1 }}>
  <Stack alignItems="center" spacing={2}>
    <CircularProgress color="inherit" />
    <Typography color="inherit">Processing...</Typography>
  </Stack>
</Backdrop>
```

---

## Form Submission Pattern

Complete pattern for form with loading, success, and error states:

```tsx
const [status, setStatus] = useState<'idle' | 'loading' | 'success' | 'error'>('idle');

const handleSubmit = async () => {
  setStatus('loading');
  try {
    await saveData();
    setStatus('success');
  } catch {
    setStatus('error');
  }
};

return (
  <>
    <Button
      variant="contained"
      onClick={handleSubmit}
      disabled={status === 'loading'}
    >
      {status === 'loading' ? 'Saving...' : 'Save'}
    </Button>

    <Snackbar 
      open={status === 'success'} 
      autoHideDuration={4000}
      onClose={() => setStatus('idle')}
    >
      <Alert severity="success">Changes saved</Alert>
    </Snackbar>

    <Snackbar 
      open={status === 'error'} 
      autoHideDuration={6000}
      onClose={() => setStatus('idle')}
    >
      <Alert severity="error">Failed to save. Please try again.</Alert>
    </Snackbar>
  </>
);
```

---

## Best Practices

### Alerts

- **Be specific** — "Unable to save changes" not "Error"
- **Provide next steps** — Tell users what to do
- **Use appropriate severity** — Don't cry wolf with errors

```tsx
// ❌ Vague
<Alert severity="error">Error</Alert>

// ✅ Specific and actionable
<Alert severity="error">
  Unable to save changes. Please check your connection and try again.
</Alert>
```

### Snackbars

- **Auto-dismiss success** — 3-4 seconds is enough
- **Longer duration for errors** — 5-6 seconds to read and understand
- **Don't stack snackbars** — Show one at a time

### Dialogs

- **Use specific action labels** — See `buttons.md` for label conventions
- **Cancel on left, primary on right**
- **Cancel is always secondary** — use `variant="text" color="secondary"` for cancel/dismiss:
  - Standard dialogs: `primary` contained + `secondary` text
  - Destructive dialogs: `error` contained + `secondary` text
- **Clear titles** — "Remove item?" not "Confirm"
- **Don't nest Paper inside Dialog** — modal content should be flat; use Stack/Box for sections
- **Use dialogs for focused tasks** — confirmations, quick edits, short forms (1–6 fields). For longer workflows or detail views, consider a Drawer instead

### Progress

- **Show progress for operations >1 second** — Users need feedback
- **Prefer skeletons for content** — Better perceived performance than spinners
- **Use inline loading** — Avoid full-screen backdrops when possible
- **Disable triggers during loading** — Prevent duplicate submissions

### Message Tone

- Be conversational but concise
- "Saved successfully" not "SAVE OPERATION COMPLETED"
- See `buttons.md` for label conventions (sentence case, action-oriented)
