# 🏗️ Architecture Overview

## 📊 Navigation Flow Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                         APP START                            │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│                    SPLASH SCREEN                             │
│  • Background: #A5B890                                       │
│  • Logo fade-in + scale animation (1000ms)                   │
│  • Skip button (top-right)                                   │
│  • Delay: 1200ms total                                       │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│          CHECK ONBOARDING STATUS                             │
│          (SharedPreferences via Riverpod)                    │
└────────────┬────────────────────────────┬───────────────────┘
             │                            │
    ┌────────▼────────┐         ┌────────▼────────┐
    │  First Run      │         │  Already Done   │
    │  (false)        │         │  (true)         │
    └────────┬────────┘         └────────┬────────┘
             │                            │
             ▼                            ▼
┌────────────────────────┐    ┌──────────────────────┐
│  ONBOARDING SCREEN     │    │    HOME SCREEN       │
│  • 4 pages             │    │  • Main app content  │
│  • PageView + swipe    │    │  • Reset button      │
│  • Skip button         │    └──────────────────────┘
│  • Dot indicators      │
│  • Next/Get Started    │
└────────────┬───────────┘
             │
             │ (Complete)
             ▼
┌────────────────────────┐
│  SET ONBOARDING DONE   │
│  SharedPreferences     │
└────────────┬───────────┘
             │
             ▼
┌────────────────────────┐
│    HOME SCREEN         │
└────────────────────────┘
```

## 🧩 Component Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         MAIN.DART                            │
│  • ProviderScope (Riverpod root)                             │
│  • MaterialApp with routes                                   │
│  • Theme configuration                                       │
└────────────────────────┬────────────────────────────────────┘
                         │
        ┌────────────────┼────────────────┐
        │                │                │
        ▼                ▼                ▼
┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│   SPLASH     │  │  ONBOARDING  │  │     HOME     │
│   SCREEN     │  │    SCREEN    │  │    SCREEN    │
└──────┬───────┘  └──────┬───────┘  └──────────────┘
       │                 │
       │                 │
       ▼                 ▼
┌─────────────────────────────────────────────────────────────┐
│                    RIVERPOD PROVIDERS                        │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  onboardingStorageServiceProvider                    │   │
│  │  → Provides OnboardingStorageService instance        │   │
│  └──────────────────────────────────────────────────────┘   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  onboardingCompleteProvider (FutureProvider)         │   │
│  │  → Checks SharedPreferences for completion status    │   │
│  └──────────────────────────────────────────────────────┘   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  currentPageIndexProvider (StateProvider)            │   │
│  │  → Tracks current page (0-3)                         │   │
│  └──────────────────────────────────────────────────────┘   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  onboardingPagesProvider (Provider)                  │   │
│  │  → List of 4 OnboardingPageModel objects             │   │
│  └──────────────────────────────────────────────────────┘   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  onboardingControllerProvider (Provider)             │   │
│  │  → OnboardingController with business logic          │   │
│  └──────────────────────────────────────────────────────┘   │
└────────────────────────┬────────────────────────────────────┘
                         │
        ┌────────────────┼────────────────┐
        │                │                │
        ▼                ▼                ▼
┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│   SERVICES   │  │    MODELS    │  │   WIDGETS    │
└──────────────┘  └──────────────┘  └──────────────┘
```

## 📦 Layer Breakdown

### 1️⃣ Presentation Layer (Screens)
```
SplashScreen
├── AnimationController (fade + scale)
├── FutureProvider (check onboarding status)
└── Navigation logic

OnboardingScreen
├── PageController
├── StateProvider (current page)
├── OnboardingPage widgets
└── Bottom navigation (skip, dots, next)

HomeScreen
├── Reset onboarding functionality
└── Placeholder content
```

### 2️⃣ State Management Layer (Providers)
```
Riverpod Providers
├── onboardingStorageServiceProvider
│   └── Singleton service instance
├── onboardingCompleteProvider
│   └── Async check from SharedPreferences
├── currentPageIndexProvider
│   └── Reactive page index (0-3)
├── onboardingPagesProvider
│   └── Static list of page data
└── onboardingControllerProvider
    └── Business logic methods
```

### 3️⃣ Business Logic Layer (Services)
```
OnboardingStorageService
├── isOnboardingComplete() → Future&lt;bool&gt;
├── setOnboardingComplete() → Future&lt;void&gt;
└── resetOnboarding() → Future&lt;void&gt;

OnboardingController
├── completeOnboarding()
├── nextPage(PageController)
├── skip(PageController)
└── updatePageIndex(int)
```

### 4️⃣ Data Layer (Models)
```
OnboardingPageModel
├── String title
├── String subtitle
├── String imagePath
└── Color backgroundColor
```

### 5️⃣ UI Components (Widgets)
```
DotIndicator
├── Animated width transition
└── Active/inactive colors

OnboardingPage
├── Fade animation
├── Title section
├── Image section
└── Subtitle section
```

## 🔄 Data Flow

```
User Action
    │
    ▼
Widget (Screen)
    │
    ▼
ref.read(provider)
    │
    ▼
Provider (Riverpod)
    │
    ▼
Controller / Service
    │
    ▼
SharedPreferences
    │
    ▼
Provider notifies listeners
    │
    ▼
Widget rebuilds
```

## 🎯 Key Design Patterns

### 1. **Repository Pattern**
- `OnboardingStorageService` abstracts SharedPreferences
- Easy to swap storage implementation

### 2. **Provider Pattern**
- Riverpod providers for dependency injection
- Reactive state management

### 3. **Controller Pattern**
- `OnboardingController` separates business logic
- Testable and reusable

### 4. **Composition**
- Small, focused widgets
- Reusable components (DotIndicator, OnboardingPage)

### 5. **Single Responsibility**
- Each file has one clear purpose
- Easy to maintain and extend

## 📱 Screen Composition

### Splash Screen
```
Scaffold
└── Stack
    ├── Center
    │   └── FadeTransition + ScaleTransition
    │       └── Image (logo)
    └── Positioned (top-right)
        └── Skip Button
```

### Onboarding Screen
```
Scaffold
└── Stack
    ├── PageView
    │   └── OnboardingPage (x4)
    │       ├── Title
    │       ├── Image (with fade)
    │       └── Subtitle
    ├── Positioned (top-right)
    │   └── Skip Button
    └── Positioned (bottom)
        └── Row
            ├── Skip Button
            ├── DotIndicator
            └── Next/Get Started Button
```

## 🧪 Testing Strategy

```
Unit Tests
├── OnboardingStorageService
│   ├── isOnboardingComplete()
│   ├── setOnboardingComplete()
│   └── resetOnboarding()
└── OnboardingController
    ├── completeOnboarding()
    ├── nextPage()
    └── skip()

Widget Tests
├── SplashScreen
│   ├── Logo displays
│   ├── Animation plays
│   └── Navigation works
├── OnboardingScreen
│   ├── All pages render
│   ├── Swipe navigation
│   └── Button actions
└── DotIndicator
    └── Correct dot highlighted

Integration Tests
└── Full flow
    ├── Splash → Onboarding → Home
    └── Splash → Home (returning user)
```

---

**This architecture ensures**:
✅ Separation of concerns
✅ Testability
✅ Scalability
✅ Maintainability
✅ Reusability
