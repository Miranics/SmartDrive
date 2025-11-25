# 🎨 SmartDrive Theme Behavior

## Theme Strategy

### ✅ Always Light Theme (No Theme Toggle)
These pages are **always light theme** because users haven't set preferences yet:

1. **Homepage** (`/homepage`) - Landing page for new visitors
2. **Signup** (`/signup`) - New user registration
3. **Forgot Password** (`/forgot_password`) - Password reset

**Why?** New users haven't chosen their theme preference yet, so we default to light theme for the best first impression.

### ✅ Respects User Theme Preference
These pages **adapt to user's saved theme preference**:

1. **Login** (`/login`) - Respects saved theme from previous sessions
2. **Welcome Page** (`/welcome`) - Main dashboard after login
3. **Settings** (`/settings`) - Theme toggle available here
4. **Provisional Exam** (`/provisional_exam`) - All exam features
5. **Flashcards** - Study materials
6. **Practice Quiz** (`/quiz`) - Quiz interface
7. **Progress Screen** (`/progress`) - Progress tracking
8. **Practical Tips** (`/tips`) - Driving tips

**Why?** Returning users have already set their preference, and it's saved in SharedPreferences. The app loads their choice automatically.

## How It Works

### Theme Persistence
```dart
// Theme preference is saved in SharedPreferences
// Located in: lib/services/preferences_service.dart

static Future<bool> getDarkMode() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('darkMode') ?? false; // Default: light theme
}

static Future<void> setDarkMode(bool value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('darkMode', value);
}
```

### Theme Provider
```dart
// Theme state managed by Riverpod
// Located in: lib/providers/theme_provider.dart

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

// Automatically loads saved preference on app start
```

## User Journey

### New User Flow
1. Opens app → **Homepage** (light theme)
2. Clicks "Start Now" → **Signup** (light theme)
3. Creates account → Verifies email
4. Logs in → **Welcome Page** (light theme by default)
5. Goes to **Settings** → Toggles dark mode
6. All authenticated pages now use dark theme ✅

### Returning User Flow
1. Opens app → **Login** (respects saved preference)
2. If dark mode was enabled → Login page uses dark theme
3. After login → All pages use saved dark theme preference ✅

## Testing Instructions

### Test New User Experience
1. Clear app data (or use new device)
2. Open app → Homepage should be light
3. Sign up → Signup page should be light
4. Login → Should be light (no preference saved yet)
5. Go to Settings → Toggle dark mode
6. Navigate through all pages → All should be dark ✅

### Test Returning User Experience
1. Login with existing account that has dark mode enabled
2. Login page should respect dark theme
3. After login, all pages should be dark
4. Go to Settings → Toggle to light mode
5. All pages should switch to light ✅

## Dark Theme Colors

### Dark Mode Palette
- **Background**: `#16213E` (Dark blue-gray)
- **Surface**: `#1A1A2E` (Slightly lighter blue-gray)
- **Accent**: `#0F3460` (Deep blue)
- **Text Primary**: `#FFFFFF` (White)
- **Text Secondary**: `#E0E0E0` (Light gray)

### Light Mode Palette
- **Background**: `#C0E2FF` (Light blue)
- **Surface**: `#FFFFFF` (White)
- **Primary**: `#006FFF` (Blue)
- **Text**: `#000000` (Black)

## Implementation Details

### Force Light Theme (Homepage, Signup)
```dart
// Wrap Scaffold with Theme widget
return Theme(
  data: ThemeData.light(),
  child: Scaffold(
    // ... rest of the page
  ),
);
```

### Respect User Preference (All other pages)
```dart
// Use Theme.of(context) to get current theme
return Scaffold(
  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  // ... rest of the page
);
```

## Summary

✅ **Homepage** - Always light (new users)
✅ **Signup** - Always light (new users)
✅ **Login** - Respects saved preference (returning users)
✅ **All authenticated pages** - Respect saved preference
✅ **Settings** - Toggle available to change preference
✅ **Preference persists** - Saved across app restarts

Perfect user experience! 🎉
