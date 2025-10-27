# InboxInsight - Flutter Prototype (Android + Windows)

This project is a demo prototype for the InboxInsight Smart SMS Digest app.
It runs completely offline with simulated AI logic and glassmorphic UI (light theme).

## Requirements
- Flutter SDK (stable) installed and on PATH
- For Android: Android Studio/Emulator or USB device
- For Windows desktop: Windows desktop support enabled in Flutter

## Run (mobile)
1. Open terminal
2. cd to project folder:
   ```bash
   cd /path/to/InboxInsight
   ```
3. Get packages:
   ```bash
   flutter pub get
   ```
4. Run on connected device or emulator:
   ```bash
   flutter run
   ```

## Run (Windows desktop)
1. Enable windows desktop if not already:
   ```bash
   flutter config --enable-windows-desktop
   ```
2. Get packages:
   ```bash
   flutter pub get
   ```
3. Run for windows:
   ```bash
   flutter run -d windows
   ```

## Notes
- The app uses a simulated AI in `lib/ai/ai_classifier.dart` (rule-based). Replace with real ML or API if required.
- The Lottie animation is a placeholder file in `assets/animations/ai_brain.json` (you can replace it with a real Lottie JSON).
- Icons are placeholders — replace PNG files under `assets/icons/` with real images if desired.
