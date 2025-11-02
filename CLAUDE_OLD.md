# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

NovaHealth is an AI-powered health and wellness Flutter application for cross-platform deployment (Android, iOS, Web, Windows, macOS, Linux). The app provides comprehensive health tracking including calorie monitoring, workout management, hydration tracking, period tracking, and wellness tools.

## Development Commands

### Setup and Dependencies
```bash
# Install dependencies
flutter pub get

# Check Flutter and dependencies
flutter doctor
```

### Running the Application
```bash
# Run on default device
flutter run

# Run on specific platforms
flutter run -d chrome          # Web
flutter run -d windows         # Windows
flutter run -d android         # Android
flutter run -d ios            # iOS
```

### Building for Production
```bash
# Android APK
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release

# Windows
flutter build windows --release
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

### Code Quality
```bash
# Analyze code for issues
flutter analyze

# Format code
flutter format lib/
```

## Architecture

### Single-File Architecture
The entire application is contained in `lib/main.dart` (~1400 lines). This is a monolithic architecture that should eventually be refactored into modular components.

### Application Flow
1. **Entry Point**: `main()` → `MyApp` (MaterialApp with named routes)
2. **Navigation Flow**:
   - `LandingPage` (/) → Login or Signup
   - `LoginPage` (/login) → `NovaHomePage` (on success)
   - `SignupPage` (/signup) → `GenderPage` (/gender) → `NovaHomePage` (/novahome)
3. **Main App**: `NovaHomePage` with bottom navigation between:
   - `ProfilePage` (index 0)
   - `LanguagePage` (index 1)
   - `InputPage` (index 2)

### Key Pages and Components

**Authentication Pages**:
- `LandingPage`: Initial landing with LOGIN/SIGNUP buttons
- `LoginPage`: Email/password login with in-memory credential validation
- `SignupPage`: User registration with username, email, password, DOB fields
- `GenderPage`: Gender selection post-signup (Male, Female, Other, Prefer not to say)

**Main Application Pages**:
- `NovaHomePage`: Container with BottomNavigationBar switching between three main pages
- `ProfilePage`: User profile with health tracking shortcuts (Meal Timer, Stay Mindful, Workout, Diet, Habit Tracker, Period Tracker, Stress Help, Hydration) plus SOS button
- `LanguagePage`: Multi-language support selection (English US/UK, Mandarin, Spanish, Arabic, Hindi, French, Russian, Vietnamese)
- `InputPage`: Daily input form with dropdown for tracking types (WORKOUT, HYDRATION, FOOD, SYMPTOMS, PERIOD TRACKER)

### State Management
- Currently uses `StatefulWidget` with `setState()` for local state
- No global state management solution (Provider, Riverpod, Bloc) implemented yet
- In-memory user database stored in global variable `_userDatabase` (main.dart:146)

### Authentication System
- **In-Memory Storage**: User credentials stored in `Map<String, String> _userDatabase`
- **Default Test Credentials**:
  - Email: `test@example.com`
  - Password: `password123`
- **No Backend**: All authentication is client-side only (not production-ready)

### Styling and Theme
- Custom color palette:
  - Primary green: `Color(0xFF616F57)` and `Color(0xFF25460E)`
  - Background: `Color(0xFFFFC8B6)`, `Color(0xFFFFCDBD)`, `Color(0xFFDFF7E1)`
  - Accent: `Color(0x66cce1be)`, `Color(0xe26e9552)`
- Font: Roboto (system font) with Poppins for specific headers
- Custom components: `StarShape` for decorative elements (main.dart:1323)

### Navigation
- **Named Routes** defined in MyApp (main.dart:18-24):
  - `/` → LandingPage
  - `/login` → LoginPage
  - `/signup` → SignupPage
  - `/gender` → GenderPage
  - `/novahome` → NovaHomePage
- **Custom Transitions**: `_fadeRoute()` helper for FadeTransition (main.dart:1386)

## Important Implementation Notes

1. **Monolithic Structure**: All UI code lives in a single file. Future refactoring should:
   - Extract pages to `lib/pages/` directory
   - Move reusable widgets to `lib/widgets/`
   - Create `lib/models/` for data models
   - Add `lib/services/` for business logic
   - Implement proper state management

2. **No Backend Integration**: Currently no API calls, database persistence, or backend services. Health data is not persisted.

3. **Hardcoded Status Bar**: Mock status bar showing "9:41" and battery icon appears on multiple pages (should be removed or replaced with real system info)

4. **Profile Data**: Hardcoded user info ("Riya Vetnekar", "rvetnekar@gmail.com") in ProfilePage:949-956

5. **Incomplete Features**: Many tracking options (Meal Timer, Workout, Diet, etc.) are UI placeholders without functionality

6. **No Form Validation**: Limited validation on signup/login forms beyond basic null/empty checks

## Testing Credentials

Use these credentials to test the login flow:
- **Email**: `test@example.com`
- **Password**: `password123`

## Future Architectural Improvements

The README indicates plans for:
- Backend API integration
- State management (Provider/Riverpod mentioned)
- Machine learning models for recommendations
- Wearable device integration
- Data synchronization
- Local storage for offline mode
- Push notifications
