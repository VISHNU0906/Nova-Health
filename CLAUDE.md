# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

NovaHealth is an AI-powered health and wellness Flutter application for cross-platform deployment (Android, iOS, Web, Windows, macOS, Linux). The app provides comprehensive health tracking including calorie monitoring, workout management, hydration tracking, period tracking, and wellness tools.

**Current Status:** Stage 1 Complete - Foundation & Core Architecture ✅

## Development Commands

### Setup and Dependencies
```bash
# Install dependencies
flutter pub get

# Generate Hive type adapters (run after modifying models)
flutter pub run build_runner build --delete-conflicting-outputs

# Watch for changes and auto-generate
flutter pub run build_runner watch

# Check Flutter and dependencies
flutter doctor
```

### Running the Application
```bash
# Run on default device
flutter run

# Run on specific platforms
flutter run -d chrome          # Web
flutter run -d windows         # Windows (requires Developer Mode enabled)
flutter run -d android         # Android
flutter run -d ios            # iOS

# Hot reload: Press 'r' in terminal
# Hot restart: Press 'R' in terminal
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

# Fix common issues
dart fix --apply
```

## Architecture

### Current Architecture (Stage 1 Complete)

The app follows a **clean, modular architecture** with clear separation of concerns:

```
lib/
├── main.dart                 # App entry point with Riverpod setup
├── config/                   # App configuration
│   ├── theme.dart           # Theme definition and colors
│   └── routes.dart          # Route constants
├── models/                   # Data models with Hive adapters
│   ├── user_model.dart
│   ├── workout_model.dart
│   ├── hydration_model.dart
│   ├── health_metric_model.dart
│   └── *.g.dart            # Generated Hive adapters
├── providers/               # Riverpod state management
│   ├── auth_provider.dart  # Auth state and current user
│   └── health_provider.dart # Health data providers
├── services/                # Business logic layer
│   ├── auth_service.dart   # Authentication logic
│   └── database_service.dart # Hive database operations
├── utils/                   # Utility functions
│   ├── constants.dart      # App-wide constants
│   ├── validators.dart     # Form validators
│   └── helpers.dart        # Helper functions (BMI, BMR, etc.)
├── widgets/                 # Reusable UI components
│   ├── custom_button.dart
│   └── custom_text_field.dart
└── pages/                   # UI screens
    ├── auth/               # Authentication flow
    ├── home/               # Main app container
    ├── dashboard/          # Dashboard with stats
    ├── profile/            # User profile
    ├── tracking/           # Health tracking inputs
    └── settings/           # App settings
```

### Architecture Patterns

1. **State Management**: Riverpod
   - Providers for global state
   - StateNotifier for complex state logic
   - Automatic state persistence

2. **Data Layer**: Hive (NoSQL Local Database)
   - Offline-first architecture
   - Fast, type-safe storage
   - Automatic serialization with adapters

3. **Service Layer**: Separate business logic
   - AuthService: Authentication operations
   - DatabaseService: Data CRUD operations
   - Clean separation from UI

4. **UI Layer**: Pages and Widgets
   - Stateless/Stateful widgets
   - ConsumerWidget/ConsumerStatefulWidget for Riverpod
   - Reusable custom widgets

### Key Design Decisions

1. **Local-First Approach**: Using Hive instead of Firebase for now
   - Can easily migrate to Firebase later
   - DatabaseService provides abstraction layer
   - All data stored locally for offline access

2. **Riverpod for State Management**:
   - Type-safe, compile-time checked
   - Easy testing and debugging
   - Better than Provider for large apps

3. **Model-First Development**:
   - All data structures defined as Dart classes
   - Hive adapters auto-generated
   - JSON serialization included

4. **Validation Layer**:
   - Centralized validators in `utils/validators.dart`
   - Reusable across forms
   - Consistent error messages

## Important Implementation Notes

### 1. Adding New Data Models

When adding a new model:

```dart
// 1. Create the model with Hive annotations
import 'package:hive/hive.dart';

part 'your_model.g.dart';

@HiveType(typeId: X) // Use next available ID
class YourModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String userId;

  // ... other fields
}

// 2. Register adapter in DatabaseService.init()
Hive.registerAdapter(YourModelAdapter());

// 3. Generate the adapter
flutter pub run build_runner build --delete-conflicting-outputs
```

### 2. Creating New Pages

```dart
// Use ConsumerWidget for Riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YourPage extends ConsumerWidget {
  const YourPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access providers with ref.watch() or ref.read()
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      // ... your UI
    );
  }
}
```

### 3. Working with Providers

```dart
// Read once (for callbacks)
ref.read(yourProvider)

// Watch for updates (rebuilds on change)
ref.watch(yourProvider)

// Listen to changes without rebuilding
ref.listen<YourState>(yourProvider, (previous, next) {
  // Handle state change
});
```

### 4. Authentication Flow

Current flow:
1. User signs up → `AuthService.signUp()`
2. Credentials stored securely → `FlutterSecureStorage`
3. User saved to Hive → `DatabaseService.saveUser()`
4. State updated → `currentUserProvider`
5. Navigate to gender selection → Complete profile
6. Navigate to home

Login flow:
1. Enter credentials
2. Verify with `AuthService.login()`
3. Update `currentUserProvider`
4. Navigate to home

### 5. Database Operations

```dart
// Get database instance
final db = DatabaseService();

// Save user
await db.saveUser(user);

// Get user
final user = db.getUser(userId);

// Query workouts by date range
final workouts = db.getUserWorkoutsByDateRange(userId, start, end);

// Hydration for today
final total = db.getTotalHydrationForDay(userId, DateTime.now());
```

### 6. Form Validation

```dart
CustomTextField(
  controller: _emailController,
  label: 'Email',
  validator: Validators.validateEmail, // From utils/validators.dart
)
```

### 7. Theme and Styling

Colors defined in `config/theme.dart`:
- `AppTheme.primaryGreen` - Main green color
- `AppTheme.darkGreen` - Dark green
- `AppTheme.lightGreen` - Light green background
- `AppTheme.peach` - Accent peach color

Use theme from context:
```dart
Text(
  'Hello',
  style: Theme.of(context).textTheme.displayLarge,
)
```

### 8. Navigation

Routes defined in `config/routes.dart`:
```dart
Navigator.pushNamed(context, AppRoutes.login);
Navigator.pushReplacementNamed(context, AppRoutes.home);
```

### 9. Helper Functions

Available in `utils/helpers.dart`:
- `Helpers.calculateBMI()` - Calculate BMI
- `Helpers.calculateBMR()` - Calculate Basal Metabolic Rate
- `Helpers.calculateTDEE()` - Calculate Total Daily Energy Expenditure
- `Helpers.formatDate()` - Format dates
- `Helpers.formatCalories()` - Format calorie display
- `Helpers.getGreeting()` - Get time-based greeting

## Current Features (Stage 1)

### ✅ Fully Functional:
1. **User Authentication**
   - Secure signup and login
   - Password hashing (SHA-256)
   - Session persistence
   - Logout

2. **Dashboard**
   - Personalized greeting
   - Today's stats (water, calories, weight, BMI)
   - Quick action buttons
   - Real-time data updates

3. **Profile Management**
   - User profile display
   - Health stats (weight, height, BMI)
   - Age calculation
   - Feature shortcuts
   - Account management (logout)

4. **Navigation**
   - Bottom navigation bar
   - Route management
   - Page transitions

### 🔄 UI Only (Functionality Coming in Stage 2):
- Detailed input forms for tracking
- Charts and data visualization
- Language switching (i18n)
- Feature implementations (Meal Timer, Workout details, etc.)
- Hydration reminders with notifications
- Period tracker with predictions
- Mental wellness tools

## Testing

### Current Test Setup
- Basic widget test in `test/widget_test.dart`
- Tests app launches successfully
- Uses ProviderScope for Riverpod testing

### Adding Tests
```dart
testWidgets('Test description', (WidgetTester tester) async {
  await tester.pumpWidget(
    const ProviderScope(
      child: MyApp(),
    ),
  );

  // Your test assertions
  expect(find.text('Something'), findsOneWidget);
});
```

## Common Issues & Solutions

### Issue: Hive adapter not found
**Solution**: Run code generation:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Issue: Provider not updating UI
**Solution**: Use `ref.watch()` instead of `ref.read()` in build method

### Issue: Windows build fails with symlink error
**Solution**: Enable Windows Developer Mode:
```bash
start ms-settings:developers
```

### Issue: Hot reload not working after model changes
**Solution**: Hot restart (R) or rebuild after running build_runner

## Development Workflow

1. **Starting Development**:
   ```bash
   flutter pub get
   flutter run -d chrome  # or your preferred device
   ```

2. **Adding a New Feature**:
   - Create model in `lib/models/` if needed
   - Generate adapters with build_runner
   - Create provider in `lib/providers/`
   - Create service methods in `lib/services/`
   - Create UI page in `lib/pages/`
   - Add route in `config/routes.dart`
   - Update navigation as needed

3. **Testing Changes**:
   ```bash
   flutter analyze        # Check for errors
   flutter test          # Run tests
   flutter run           # Test in app
   ```

4. **Before Committing**:
   ```bash
   flutter format lib/
   flutter analyze
   flutter test
   ```

## Stage 2 Preview

Next phase will implement:
- Full tracking modules (workouts, hydration, nutrition, symptoms, period)
- Charts with fl_chart
- Notifications
- i18n multi-language support
- Enhanced data visualization
- Mental wellness features
- More comprehensive testing

## Important Files to Know

- `lib/main.dart` - App entry, initializes Hive and Riverpod
- `lib/services/database_service.dart` - All database operations
- `lib/services/auth_service.dart` - Authentication logic
- `lib/providers/auth_provider.dart` - Auth state management
- `lib/models/user_model.dart` - User data structure
- `lib/config/theme.dart` - App theme and colors
- `lib/utils/constants.dart` - App constants
- `STAGE1_COMPLETE.md` - Detailed Stage 1 completion summary
- `DEV_PLAN.md` - Full 3-stage development plan

## Default Test Credentials

For testing the app:
- No default user (create one via signup)
- After signup, user is stored in local Hive database
- Data persists between app restarts

## Code Style Guidelines

- Use `const` constructors where possible
- Follow Flutter/Dart style guide
- Use meaningful variable names
- Add comments for complex logic
- Keep functions small and focused
- Use Riverpod's ConsumerWidget for stateful UI
- Prefer composition over inheritance

---

**Last Updated:** 2025-11-02 (Stage 1 Complete)
**Next Milestone:** Stage 2 - Core Health Tracking Features
