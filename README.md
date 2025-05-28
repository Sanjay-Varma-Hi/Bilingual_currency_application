# Currency Champions

Currency Champions is a fun, educational Flutter app designed to help children learn about coins, bills, and money concepts through interactive games and quizzes. The app is optimized for tablets and iPads, and supports both English and Spanish.

## Features
- Learn about US coins and bills with images and facts
- Play interactive games: Name the Coin, Value of the Coin, Coin Value Conversion, Name the Bill, Value of the Bill, Bill Value Conversion
- Take quizzes with multiple levels (matching, MCQs, currency combinations, word problems)
- Global score tracking and per-quiz progress popup
- Bilingual support (English/Spanish)
- Responsive, tablet-friendly UI

## Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.x recommended)
- [Firebase CLI](https://firebase.google.com/docs/cli) (for deployment)
- A Firebase project (already configured in this repo)

### Installation
1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   cd flutter_application_1
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

### Running Locally
1. **Run on web (recommended for tablets/desktops):**
   ```bash
   flutter run -d chrome
   ```
2. **Run on a connected device:**
   ```bash
   flutter run
   ```

### Building for Web
To build the app for web deployment:
```bash
flutter build web
```
The output will be in the `build/web` directory.

### Deploying to Firebase Hosting
1. **Login to Firebase (if not already):**
   ```bash
   firebase login
   ```
2. **Build the web app:**
   ```bash
   flutter build web
   ```
3. **Deploy to Firebase Hosting:**
   ```bash
   firebase deploy
   ```

Your app will be live at the Firebase Hosting URL shown in the terminal after deployment.

## Project Structure
- `lib/` - Main Flutter app code
  - `screens/` - All app screens (home, games, quizzes, etc.)
  - `widgets/` - Reusable widgets (score, popup, etc.)
  - `globals/` - Global state (score, translations)
- `assets/` - Images for coins, bills, and UI

## Customization
- To add new coins/bills, update the assets and the relevant screens in `lib/screens/`
- To add new games or quiz levels, follow the structure in `lib/screens/` and update the popup in `ScoreWithPopupWidget`

## Support
For questions or contributions, please open an issue or pull request on the repository.

---
Enjoy learning with Currency Champions! 