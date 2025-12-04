# Naiki - Splash Screen &amp; Onboarding Flow

## 📱 Overview

Production-ready Flutter module implementing a **Splash Screen** and **4-Screen Onboarding Flow** using **Riverpod** state management with clean architecture, responsive UI, smooth animations, and persistent storage.

## 🎯 Features

### Splash Screen
- ✅ Smooth fade-in + scale animation (1000ms)
- ✅ Background color: `#A5B890`
- ✅ Center logo with error handling
- ✅ Skip button (top-right corner)
- ✅ Automatic navigation based on first-run detection
- ✅ SharedPreferences integration via Riverpod

### Onboarding Flow
- ✅ 4 onboarding screens with PageView
- ✅ Swipe support for navigation
- ✅ Custom background colors per page:
  - Page 1: `#2F4517` (Dark Green)
  - Page 2: `#A5B890` (Sage Green)
  - Page 3: `#2F4517` (Dark Green)
  - Page 4: `#A5B890` (Sage Green)
- ✅ Animated dot indicators
- ✅ Skip button (top-right + bottom-left)
- ✅ Next/Get Started button with dynamic styling
- ✅ Fade animations for images and text
- ✅ Persistent onboarding completion state

## 📁 Project Structure

```
lib/
├── main.dart                                    # App entry point with Riverpod
├── features/
│   ├── splash/
│   │   ├── models/
│   │   │   └── onboarding_page_model.dart      # Data model for onboarding pages
│   │   ├── services/
│   │   │   └── onboarding_storage_service.dart # SharedPreferences wrapper
│   │   ├── providers/
│   │   │   └── onboarding_providers.dart       # Riverpod providers &amp; controller
│   │   ├── screens/
│   │   │   ├── splash_screen.dart              # Splash screen with animations
│   │   │   └── onboarding_screen.dart          # Main onboarding flow
│   │   └── widgets/
│   │       ├── dot_indicator.dart              # Animated page indicators
│   │       └── onboarding_page.dart            # Individual page widget
│   └── home/
│       └── screens/
│           └── home_screen.dart                # Home screen placeholder
└── assets/
    └── images/
        ├── splash_logo.png
        ├── onboard_1.png
        ├── onboard_2.png
        └── onboard_3.png
```

## 🏗️ Architecture

### Clean Architecture Principles
- **Models**: Data structures (`OnboardingPageModel`)
- **Services**: Business logic (`OnboardingStorageService`)
- **Providers**: State management (Riverpod providers)
- **Screens**: UI presentation layer
- **Widgets**: Reusable UI components

### State Management (Riverpod)

#### Providers
1. **`onboardingStorageServiceProvider`**
   - Provides instance of `OnboardingStorageService`
   
2. **`onboardingCompleteProvider`** (FutureProvider)
   - Checks if onboarding is complete
   - Returns `bool` from SharedPreferences

3. **`currentPageIndexProvider`** (StateProvider)
   - Tracks current page index (0-3)
   
4. **`onboardingPagesProvider`** (Provider)
   - Provides list of 4 `OnboardingPageModel` objects

5. **`onboardingControllerProvider`** (Provider)
   - Provides `OnboardingController` for business logic

#### Controller Methods
- `completeOnboarding()`: Marks onboarding as complete
- `nextPage(PageController)`: Navigates to next page
- `skip(PageController)`: Skips to last page
- `updatePageIndex(int)`: Updates current page index

## 🎨 Design Specifications

### Colors
```dart
Primary Dark Green: Color(0xFF2F4517)
Sage Green: Color(0xFFA5B890)
```

### Typography
- **Title**: 32px, FontWeight.w600
- **Subtitle**: 16px, FontWeight.w400
- **Button**: 16px, FontWeight.w600

### Animations
- **Splash Logo**: Fade-in + Scale (1000ms)
- **Onboarding Pages**: Fade-in (800ms)
- **Dot Indicators**: Animated width transition (300ms)
- **Page Transitions**: Smooth slide (300ms)

## 🚀 Usage

### Installation

1. **Install dependencies**:
```bash
flutter pub get
```

2. **Run the app**:
```bash
flutter run
```

### Navigation Flow

```
SplashScreen (/)
    ↓
[Check onboarding status]
    ↓
    ├─→ First Run → OnboardingScreen (/onboarding)
    │                     ↓
    │              [Complete onboarding]
    │                     ↓
    └─→ Already Completed → HomeScreen (/home)
```

### Testing Onboarding

The **HomeScreen** includes a reset button to clear onboarding state for testing:

```dart
// Reset onboarding and restart
final storageService = ref.read(onboardingStorageServiceProvider);
await storageService.resetOnboarding();
Navigator.of(context).pushReplacementNamed('/');
```

## 📦 Dependencies

```yaml
dependencies:
  flutter_riverpod: ^2.5.0      # State management
  shared_preferences: ^2.2.2     # Persistent storage
```

## 🎯 Key Implementation Details

### 1. First-Run Detection
```dart
Future&lt;bool&gt; isOnboardingComplete() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('onboarding_complete') ?? false;
}
```

### 2. Splash Navigation Logic
```dart
final onboardingComplete = await ref.read(onboardingCompleteProvider.future);

if (onboardingComplete) {
  Navigator.of(context).pushReplacementNamed('/home');
} else {
  Navigator.of(context).pushReplacementNamed('/onboarding');
}
```

### 3. Onboarding Completion
```dart
Future&lt;void&gt; _completeOnboarding() async {
  await ref.read(onboardingControllerProvider).completeOnboarding();
  if (mounted) {
    Navigator.of(context).pushReplacementNamed('/home');
  }
}
```

### 4. Dynamic Button Styling
```dart
final isLightBackground = currentPage.backgroundColor == const Color(0xFFA5B890);

ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: isLightBackground 
        ? const Color(0xFF2F4517)
        : const Color(0xFFA5B890),
    foregroundColor: isLightBackground 
        ? Colors.white
        : const Color(0xFF2F4517),
  ),
  // ...
)
```

## 🔧 Customization

### Adding More Onboarding Pages

Edit `onboardingPagesProvider` in `onboarding_providers.dart`:

```dart
final onboardingPagesProvider = Provider&lt;List&lt;OnboardingPageModel&gt;&gt;((ref) {
  return const [
    // Add new pages here
    OnboardingPageModel(
      title: 'Your Title',
      subtitle: 'Your subtitle',
      imagePath: 'assets/images/your_image.png',
      backgroundColor: Color(0xFF2F4517),
    ),
  ];
});
```

### Changing Animation Duration

In `splash_screen.dart`:
```dart
_animationController = AnimationController(
  duration: const Duration(milliseconds: 1000), // Change here
  vsync: this,
);
```

### Modifying Colors

Update color constants throughout the codebase or create a theme file:
```dart
class AppColors {
  static const primary = Color(0xFF2F4517);
  static const secondary = Color(0xFFA5B890);
}
```

## 🧪 Testing Checklist

- [ ] Splash screen displays logo with animation
- [ ] Skip button navigates to home screen
- [ ] First run shows onboarding
- [ ] Subsequent runs skip onboarding
- [ ] All 4 onboarding pages display correctly
- [ ] Swipe navigation works
- [ ] Skip button jumps to last page
- [ ] Next button advances pages
- [ ] Get Started completes onboarding
- [ ] Dot indicators update correctly
- [ ] Colors match specifications
- [ ] Animations are smooth
- [ ] Images load correctly
- [ ] Error states handled gracefully

## 📝 Notes

- **Null Safety**: All code is null-safe
- **Error Handling**: Image loading includes error builders
- **Responsive**: Layout adapts to different screen sizes
- **Performance**: Animations use `SingleTickerProviderStateMixin`
- **Clean Code**: Follows Flutter best practices
- **Scalable**: Easy to add more pages or modify behavior

## 🎓 Learning Resources

- [Riverpod Documentation](https://riverpod.dev/)
- [Flutter Animations](https://docs.flutter.dev/development/ui/animations)
- [SharedPreferences](https://pub.dev/packages/shared_preferences)

---

**Built with ❤️ using Flutter &amp; Riverpod**
