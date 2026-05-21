# 🧠 Memory Match Flutter Game

> **CS5450 Mobile Programming — Exercise 2**  
> Lakehead University | Dr. Sabah Mohammed 
> **Student:** Harika Ravi | **Repository:** memory_game_CS5450

---

## Project Overview

**Memory Match** is a Flutter/Dart mobile application that implements a classic card-flipping memory game. The player flips cards two at a time to find matching emoji pairs. The game tracks moves, elapsed time, and awards a star rating upon completion.

### Key Features
- **20 cards** — 10 unique emoji pairs, shuffled every game
- **Smooth 3D flip animation** using `AnimationController` + `Matrix4.rotateY()`
- **Live timer** and **move counter** displayed in the header
- **Match detection** — matched pairs stay face-up with green highlight
- **Win screen** with time, moves, and ⭐ star rating
- **Restart** with confirmation dialog
- **Responsive** — works on Android, Windows Desktop, and Chrome Web

---

## Project Structure

```
memory_game/
├── lib/
│   ├── main.dart                  ← App entry point & MaterialApp setup
│   ├── models/
│   │   ├── card_model.dart        ← CardModel data class
│   │   └── game_state.dart        ← Game logic (ChangeNotifier)
│   ├── screens/
│   │   ├── home_screen.dart       ← Splash / home screen
│   │   └── game_screen.dart       ← Main game UI
│   └── widgets/
│       └── memory_card.dart       ← Card widget with 3D flip animation
├── pubspec.yaml                   ← Dependencies
└── README.md                      ← This file
```

### File Descriptions

| File | Description |
|------|-------------|
| `main.dart` | Entry point. Sets up MaterialApp with theme and routes to HomeScreen |
| `card_model.dart` | Immutable data class: pairId, emoji, label, colorIndex, isFaceUp, isMatched |
| `game_state.dart` | All game logic: shuffle, flip, match detection, timer, move counter, restart |
| `home_screen.dart` | Dark gradient splash screen with preview grid and Play Now button |
| `game_screen.dart` | Game UI: AppHeader, ScoreBar, CardGrid, WinScreen, BottomBar |
| `memory_card.dart` | 3D flip animation card widget with coloured back and emoji front |

---

## Tech Stack

| Component | Technology |
|-----------|-----------|
| Language | Dart 3.x |
| Framework | Flutter 3.44.0 (Material 3) |
| State Management | Provider 6.x (ChangeNotifier) |
| Animation | AnimationController + Matrix4 (3D flip) |
| Font | Google Fonts — Poppins |
| IDE | Android Studio |
| Target Platforms | Android 8+ / Windows Desktop / Chrome Web |

---

## Setup & Installation

### Prerequisites
- [Flutter SDK 3.44.0+](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio) with Flutter & Dart plugins
- Android SDK API 34 with command-line tools
- Git

### Step 1 — Clone the Repository
```bash
git clone https://github.com/Harika-ravi/memory_game_CS5450.git
cd memory_game_CS5450
```

### Step 2 — Install Dependencies
```bash
flutter pub get
```

### Step 3 — Verify Flutter Installation
```bash
flutter doctor
```
All items should show ✅ green checkmarks.

### Step 4 — Run on Android Emulator
```bash
# Create AVD: Android Studio → Tools → Device Manager → + → Pixel 7 → API 34
# Then run:
flutter run
```
Or press the green **▶ Run** button in Android Studio with Pixel 7 selected.

### Step 5 — Run on Windows Desktop
```bash
flutter run -d windows
```
Or select **Windows (desktop)** from the device dropdown and press **▶ Run**.

### Step 6 — Run on Chrome Web
```bash
flutter run -d chrome
```

---

## How to Play

1. Launch the app and tap **Play Now** on the home screen
2. The game board shows **20 face-down cards** in a 4×5 grid
3. Tap any card to flip it face-up and reveal its emoji
4. Tap a second card — if the emojis **match**, both stay face-up ✅
5. If they **don't match**, both flip back after 0.9 seconds
6. Continue until all **10 pairs** are found
7. The **Win Screen** shows your time, move count, and ⭐ star rating
8. Tap **Play Again** to start a new shuffled game

---

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2       # State management
  google_fonts: ^6.2.1   # Poppins font
  cupertino_icons: ^1.0.6

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

---

## Screenshots

### Windows Desktop



### Android — Pixel 7 (API 34)



##  Links

- **GitHub Repository:** https://github.com/Harika-ravi/memory_game_CS5450


