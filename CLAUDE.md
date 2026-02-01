# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

NovaHealth is a cross-platform Flutter health and wellness mobile application. The entire application is currently implemented in a **single monolithic file** (`lib/main.dart` - 1397 lines) using a route-based navigation pattern.

## Development Commands

### Setup
```bash
# Install dependencies
flutter pub get

# Update dependencies
flutter pub upgrade
```

### Running the App
```bash
# Run on web (development)
flutter run -d chrome

# Run on Android
flutter run -d android

# Run on iOS
flutter run -d ios

# Run on Windows/Linux/macOS
flutter run -d windows
flutter run -d linux
flutter run -d macos
```

### Build
```bash
# Build for web
flutter build web

# Build APK for Android
flutter build apk

# Build for iOS
flutter build ios

# Build for desktop
flutter build windows
flutter build linux
flutter build macos
```

### Testing & Quality
```bash
# Run tests
flutter test

# Run linter
flutter analyze

# Format code
flutter format lib/
```

## Architecture

### Single-File Monolith Structure

The entire application resides in `lib/main.dart` with the following flow:

```
MyApp (MaterialApp with named routes)
├── / → LandingPage (entry point)
├── /login → LoginPage
├── /signup → SignupPage
├── /gender → GenderPage
└── /novahome → NovaHomePage
    └── BottomNavigationBar (3 tabs)
        ├── ProfilePage
        ├── LanguagePage
        └── InputPage
```

### Authentication Flow

**In-Memory User Database:**
- Global `Map<String, String> _userDatabase` stores email:password pairs
- Default test credentials: `test@example.com` / `password123`
- New users added to map during signup (data lost on app restart)
- **No encryption, no persistent storage, no backend integration**

**User Journey:**
1. LandingPage → Login OR Signup
2. LoginPage → (successful auth) → NovaHomePage
3. SignupPage → GenderPage → NovaHomePage

### Navigation Pattern

- Uses `Navigator.pushNamed()` for route transitions
- Custom `_fadeRoute()` helper for fade transitions via `PageRouteBuilder`
- Login/Signup use `Navigator.pushReplacement()` to prevent back navigation

### Page Components

All pages are **self-contained StatelessWidget or StatefulWidget classes** in the same file:

**Auth Pages:**
- `LandingPage` - Welcome screen with Login/Signup buttons
- `LoginPage` - Email/password form with in-memory validation
- `SignupPage` - Registration form (username, email, password, DOB)
- `GenderPage` - Gender selection dropdown (post-signup)

**Main App:**
- `NovaHomePage` - Bottom navigation shell (Profile/Language/Input tabs)
- `ProfilePage` - User profile + health feature grid (8 modules)
- `LanguagePage` - Language selection UI
- `InputPage` - Daily health input with custom `StarShape` decorations

### Health Features (UI-Only, No Functionality)

Profile page displays 8 feature modules:
- Meal Timer
- Stay Mindful
- Your Workout
- Your Diet
- Habit Tracker
- Period Tracker
- Stress Help
- Hydration

**Note:** These are currently decorative UI elements with no backend logic.

### Styling & Design System

**Color Palette:**
- Primary background: `#FFC8B6` (peach/salmon)
- Secondary background: `#DFF7E1` (light mint)
- Dark green: `#25460E`, `#616F57`
- Button background: `#616F57`
- Button text: `#DFF7E1`

**Typography:**
- Font family: Roboto (hardcoded throughout)
- No centralized theme or styling system
- All styles defined inline in widgets

### Custom Widgets

**`StarShape` (ShapeBorder):**
- Custom shape class used in `InputPage` for decorative elements
- Parameters: points, innerRadiusRatio, pointRounding, rotation, squash
- Draws n-pointed stars using polar coordinates and trigonometry

## Critical Architectural Limitations

1. **No State Management** - All state is local to widgets or in-memory globals
2. **No Data Persistence** - User data lost on app restart
3. **No Backend Integration** - No API calls, no database
4. **No Security** - Plain text passwords, no auth tokens
5. **Monolithic File** - All 1397 lines in one file makes maintenance difficult
6. **Hard-coded Data** - Profile info, feature lists all hard-coded
7. **No Form Validation** - Minimal input validation
8. **No Error Handling** - No try-catch, no error states

## Design Patterns Used

- **Named Routes** for navigation (defined in MaterialApp)
- **StatefulWidget** for pages with user input (Login, Signup, Gender, Home)
- **StatelessWidget** for static content pages
- **Custom Transitions** via `PageRouteBuilder` for fade effects

## Anima Integration

The `.anima/` directory contains design-to-code artifacts from Anima (Figma plugin):
- `components.json` - Component definitions
- `conventions.json` - Design conventions
- `enrichments.json` - Design enrichments
- `library.json` - Component library
- `workspace.json` - Workspace metadata

**Note:** This suggests the UI was initially generated from Figma designs.

## Future Refactoring Recommendations

When extending this codebase:

1. **Split into multiple files** - Create separate files for each page/feature
2. **Add state management** - Implement Provider, Riverpod, or Bloc
3. **Add data persistence** - Use SharedPreferences or SQLite
4. **Create reusable widgets** - Extract common UI patterns
5. **Implement proper auth** - Use Firebase Auth or similar
6. **Add form validation** - Use Flutter Form validators
7. **Create theme system** - Centralize colors and typography
8. **Add error handling** - Proper try-catch and error states
9. **Backend integration** - Connect to REST API or Firebase
10. **Organize by feature** - Use feature-first folder structure

## Dependencies

**Production:**
- `flutter` (SDK)
- `cupertino_icons: ^1.0.8`

**Development:**
- `flutter_test` (SDK)
- `flutter_lints: ^5.0.0`

No external packages for state management, networking, or persistence.
