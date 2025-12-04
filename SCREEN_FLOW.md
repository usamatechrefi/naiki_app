# 📱 Screen Flow Overview

## 🎬 Complete User Journey

### Flow Diagram
```
┌─────────────────────────────────────────────────────────────┐
│                      APP LAUNCH                              │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│                   SPLASH SCREEN                              │
│  ┌───────────────────────────────────────────────────┐      │
│  │                                            [Skip] │      │
│  │                                                    │      │
│  │                                                    │      │
│  │                    [Logo]                          │      │
│  │                   (Animated)                       │      │
│  │                                                    │      │
│  │                                                    │      │
│  │               Background: #A5B890                  │      │
│  └───────────────────────────────────────────────────┘      │
│                                                              │
│  Duration: 1.2 seconds                                       │
│  Animation: Fade-in + Scale                                  │
└────────────────────────┬────────────────────────────────────┘
                         │
            ┌────────────┴────────────┐
            │                         │
    [First Run]              [Returning User]
            │                         │
            ▼                         ▼
┌──────────────────────┐    ┌──────────────────────┐
│  ONBOARDING SCREEN   │    │    HOME SCREEN       │
└──────────────────────┘    └──────────────────────┘
```

---

## 📄 Screen 1: Splash Screen

### Layout
```
┌─────────────────────────────────────┐
│                          [Skip]     │ ← Top-right skip button
│                                     │
│                                     │
│                                     │
│            ┌──────────┐             │
│            │          │             │
│            │  [Logo]  │             │ ← Center logo
│            │          │             │   (Fade + Scale animation)
│            └──────────┘             │
│                                     │
│                                     │
│                                     │
│                                     │
└─────────────────────────────────────┘

Background: #A5B890 (Sage Green)
```

### Features
- ✅ Logo fade-in animation (0-700ms)
- ✅ Logo scale animation (0.5 → 1.0)
- ✅ Skip button (navigates to home)
- ✅ Auto-navigation after 1200ms
- ✅ Checks onboarding status

### Code Location
`lib/features/splash/screens/splash_screen.dart`

---

## 📄 Screen 2-5: Onboarding Pages (1-4)

### Page 1: Small Kindness, Big Impact
```
┌─────────────────────────────────────┐
│                          [Skip]     │ ← Top-right skip
│                                     │
│  Small Kindness.                    │ ← Title
│  Big Impact.                        │   (32px, bold)
│                                     │
│                                     │
│         ┌─────────────┐             │
│         │   [Image]   │             │ ← Illustration
│         │  Hands      │             │   (Fade-in animation)
│         │  Heart      │             │
│         └─────────────┘             │
│                                     │
│                                     │
│                                     │
│  ┌──────┐  ┌───┐  ┌──────────┐     │
│  │ Skip │  │ ● ○ ○ ○ │  │  next  │  │ ← Bottom nav
│  └──────┘  └───┘  └──────────┘     │
└─────────────────────────────────────┘

Background: #2F4517 (Dark Green)
Text: White
```

### Page 2: Support Only Verified Women
```
┌─────────────────────────────────────┐
│                          [Skip]     │
│                                     │
│  Support Only                       │
│  Verified Women                     │
│                                     │
│         ┌─────────────┐             │
│         │   [Badge]   │             │
│         │  Checkmark  │             │
│         └─────────────┘             │
│                                     │
│  Every project is reviewed and      │
│  approved by our team to            │ ← Subtitle
│  ensure authenticity, safety, and   │   (16px)
│  genuine need.                      │
│                                     │
│  ┌──────┐  ┌───┐  ┌──────────┐     │
│  │ Skip │  │ ○ ● ○ ○ │  │  next  │  │
│  └──────┘  └───┘  └──────────┘     │
└─────────────────────────────────────┘

Background: #A5B890 (Sage Green)
Text: Dark Green (#2F4517)
```

### Page 3: Direct Help, No Middlemen
```
┌─────────────────────────────────────┐
│                          [Skip]     │
│                                     │
│  Direct Help                        │
│  No Middlemen                       │
│                                     │
│         ┌─────────────┐             │
│         │   [Hands]   │             │
│         │   Heart     │             │
│         └─────────────┘             │
│                                     │
│  Your donation goes straight to the │
│  woman you choose.                  │
│  fast, transparent, and secure.     │
│                                     │
│  ┌──────┐  ┌───┐  ┌──────────┐     │
│  │ Skip │  │ ○ ○ ● ○ │  │  next  │  │
│  └──────┘  └───┘  └──────────┘     │
└─────────────────────────────────────┘

Background: #2F4517 (Dark Green)
Text: White
```

### Page 4: See the Difference You Make
```
┌─────────────────────────────────────┐
│                                     │ ← No skip on last page
│                                     │
│  See the Difference                 │
│  You Make                           │
│                                     │
│         ┌─────────────┐             │
│         │  [Impact]   │             │
│         │   Image     │             │
│         └─────────────┘             │
│                                     │
│  Get updates and impact stories     │
│  after every donation.              │
│  Your kindness creates real change. │
│                                     │
│         ┌───┐  ┌──────────────┐    │
│         │ ○ ○ ○ ● │  │ Get Started │ │ ← Final button
│         └───┘  └──────────────┘    │
└─────────────────────────────────────┘

Background: #A5B890 (Sage Green)
Text: Dark Green (#2F4517)
Button: Dark Green background
```

### Features
- ✅ Swipe left/right to navigate
- ✅ Skip button (jumps to last page)
- ✅ Animated dot indicators
- ✅ Next button (advances one page)
- ✅ Get Started (completes onboarding)
- ✅ Fade-in animations per page

### Code Location
`lib/features/splash/screens/onboarding_screen.dart`
`lib/features/splash/widgets/onboarding_page.dart`

---

## 📄 Screen 6: Home Screen

### Layout
```
┌─────────────────────────────────────┐
│  Naiki                      [↻]     │ ← App bar with reset
├─────────────────────────────────────┤
│                                     │
│                                     │
│            ┌──────────┐             │
│            │    ♥     │             │ ← Heart icon
│            └──────────┘             │
│                                     │
│       Welcome to Naiki!             │ ← Title
│                                     │
│   Your journey to make a            │
│   difference starts here.           │ ← Subtitle
│                                     │
│                                     │
│   ┌───────────────────────┐         │
│   │ View Onboarding Again │         │ ← Reset button
│   └───────────────────────┘         │
│                                     │
└─────────────────────────────────────┘

Background: #A5B890 (Sage Green)
```

### Features
- ✅ Placeholder for main app
- ✅ Reset onboarding button
- ✅ Refresh icon in app bar
- ✅ Styled with app colors

### Code Location
`lib/features/home/screens/home_screen.dart`

---

## 🎨 Color Scheme

### Primary Colors
```
Dark Green:  #2F4517  ████████
Sage Green:  #A5B890  ████████
White:       #FFFFFF  ████████
```

### Usage
- **Dark Green (#2F4517)**
  - Onboarding pages 1 &amp; 3 background
  - Text on light backgrounds
  - Buttons on light backgrounds

- **Sage Green (#A5B890)**
  - Splash screen background
  - Onboarding pages 2 &amp; 4 background
  - Home screen background
  - Buttons on dark backgrounds

- **White (#FFFFFF)**
  - Text on dark backgrounds
  - Buttons text on dark buttons

---

## 🎬 Animations

### Splash Screen
```
Timeline:
0ms    ─────────────────────────────────────────
       │ Start
       │ Opacity: 0.0
       │ Scale: 0.5
       │
700ms  ─────────────────────────────────────────
       │ Animation Complete
       │ Opacity: 1.0
       │ Scale: 1.0
       │
1200ms ─────────────────────────────────────────
       │ Navigate
       │ → Onboarding or Home
```

### Onboarding Pages
```
Each page change:
0ms    ─────────────────────────────────────────
       │ Page enters
       │ Opacity: 0.0
       │
800ms  ─────────────────────────────────────────
       │ Fade complete
       │ Opacity: 1.0
```

### Dot Indicators
```
On page change:
0ms    ─────────────────────────────────────────
       │ Width: 8px (inactive)
       │
300ms  ─────────────────────────────────────────
       │ Width: 16px (active)
```

---

## 🔄 Navigation Flow

### First Run
```
Splash Screen (1.2s)
    │
    ├─ Check: onboarding_complete = false
    │
    ▼
Onboarding Page 1
    │
    ├─ Swipe or Next
    ▼
Onboarding Page 2
    │
    ├─ Swipe or Next
    ▼
Onboarding Page 3
    │
    ├─ Swipe or Next
    ▼
Onboarding Page 4
    │
    ├─ Tap "Get Started"
    ├─ Set: onboarding_complete = true
    │
    ▼
Home Screen
```

### Returning User
```
Splash Screen (1.2s)
    │
    ├─ Check: onboarding_complete = true
    │
    ▼
Home Screen
```

### Skip Flow
```
Splash Screen
    │
    ├─ Tap "Skip"
    │
    ▼
Home Screen

OR

Onboarding Page 1/2/3
    │
    ├─ Tap "Skip"
    │
    ▼
Onboarding Page 4
    │
    ├─ Tap "Get Started"
    │
    ▼
Home Screen
```

---

## 📐 Responsive Design

### Layout Breakpoints
- **Small phones** (&lt;5.5"): All elements scale proportionally
- **Medium phones** (5.5"-6.5"): Optimal layout
- **Large phones** (&gt;6.5"): Increased padding
- **Tablets**: Centered content with max width

### Image Sizing
```dart
// Splash logo
width: screenWidth * 0.6
height: screenHeight * 0.4

// Onboarding images
width: screenWidth * 0.7
height: screenHeight * 0.35
```

---

## 🎯 User Interactions

### Splash Screen
| Action | Result |
|--------|--------|
| Wait 1.2s | Auto-navigate |
| Tap "Skip" | Go to Home |

### Onboarding
| Action | Result |
|--------|--------|
| Swipe left | Next page |
| Swipe right | Previous page |
| Tap "Skip" | Jump to page 4 |
| Tap "Next" | Next page |
| Tap "Get Started" | Complete &amp; go to Home |

### Home Screen
| Action | Result |
|--------|--------|
| Tap "View Onboarding Again" | Reset &amp; restart |
| Tap refresh icon | Reset &amp; restart |

---

## 📊 State Management

### Riverpod Providers
```
onboardingCompleteProvider
    │
    ├─ Reads from SharedPreferences
    ├─ Returns: bool
    └─ Used by: SplashScreen

currentPageIndexProvider
    │
    ├─ Tracks: 0-3
    ├─ Updates on: PageView change
    └─ Used by: OnboardingScreen

onboardingPagesProvider
    │
    ├─ Provides: List&lt;OnboardingPageModel&gt;
    ├─ Count: 4 pages
    └─ Used by: OnboardingScreen

onboardingControllerProvider
    │
    ├─ Methods: nextPage(), skip(), complete()
    └─ Used by: OnboardingScreen
```

---

## 🎨 Typography

### Font Sizes
- **Title**: 32px
- **Subtitle**: 16px
- **Button**: 16px
- **Skip**: 16px

### Font Weights
- **Title**: 600 (Semi-bold)
- **Subtitle**: 400 (Regular)
- **Button**: 600 (Semi-bold)

### Line Heights
- **Title**: 1.2
- **Subtitle**: 1.5

---

## 📱 Platform Considerations

### Android
- ✅ Status bar: Transparent
- ✅ Navigation bar: Sage green
- ✅ Back button: Disabled on splash/onboarding

### iOS
- ✅ Safe area: Respected
- ✅ Status bar: Dark icons
- ✅ Swipe back: Disabled on onboarding

---

**This visual overview shows exactly what users will see and experience!** 🎨
