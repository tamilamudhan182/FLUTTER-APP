# FLUTTER-APP - OneJourney

<div align="center">
  <p><strong>Mini version of OneJourney, an AI-powered Indian mobility super app built with Flutter.</strong></p>
</div>

---

## 🌟 Features

- **Seamless Onboarding:** Animated splash logo followed by an engaging four-slide onboarding experience.
- **Secure Authentication:** Mock phone number and OTP login system featuring seamless language selection for localized accessibility.
- **Dynamic Navigation:** Provider-powered journey mode selection, active route tracking, and responsive bottom navigation state management.
- **Smart Route Planning:** Both Direct and Combined route planning capabilities with intelligent sorting and filtering mechanisms.
- **Journey Tiers:** Distinct route result cards categorizing trips into **Fastest**, **Cheapest**, and **Premium** options.
- **Comprehensive Trip Management:** Detailed trip views featuring price breakdown, real-time safety scores, carbon offset points, secure payment flows, and digital QR ticket generation.

## 📱 Core Screens

1. **Home:** Quick access to recent trips, saved destinations, and travel updates.
2. **Search:** Intelligent route discovery across multiple transit modes.
3. **Wallet:** Digital payments, balance tracking, and transaction history.
4. **Trips:** Historical journey data and active trip management.
5. **Profile:** User settings, preferences, and language controls.

## 🛠️ Tech Stack

- **Framework:** Flutter
- **State Management:** Provider
- **Design System:** Custom theme with comprehensive light/dark mode support (see `lib/core/theme`)
- **Routing:** Centralized routing system (`lib/core/routes`)

## 📁 Project Structure

```text
lib/
├── core/           # Theme, constants, routes, and shared utilities
├── features/       # Feature-driven architecture (auth, home, journey, splash)
├── models/         # Core data models (journey modes, routes)
├── widgets/        # Reusable UI components (buttons, cards, icons)
└── main.dart       # Application entry point
```

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed on your machine.
- An IDE such as VS Code or Android Studio.

### Installation

1. **Clone the repository (if you haven't already):**
   ```bash
   git clone https://github.com/tamilamudhan182/FLUTTER-APP.git
   cd FLUTTER-APP
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate Platform Folders (If missing):**
   If your project doesn't have `android`, `ios`, or `web` folders, generate them using:
   ```bash
   flutter create . --platforms=android,ios,web
   ```

4. **Run the Application:**
   ```bash
   flutter run
   ```

## 🤝 Contributing
Contributions, issues, and feature requests are welcome! Feel free to check the issues page or submit a pull request.
