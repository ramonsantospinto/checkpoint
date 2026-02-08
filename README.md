# 🎮 CheckPoint

Own your progress. Track your Steam journey.

CheckPoint is a modern Flutter application that integrates with the Steam Web API to help players monitor their current game, total playtime, achievement progress, and completion percentage — all in a clean and focused experience.

Built with Clean Architecture and designed for scalability.

---

## 🚀 What is CheckPoint?

Steam shows data.

CheckPoint gives you clarity.

Instead of navigating multiple Steam pages, CheckPoint centralizes:

- 🎮 Current game status
- ⏱ Total playtime
- 🏆 Achievement progress
- 📊 Completion percentage
- 🔐 Secure Steam authentication

---

## 🏗 Architecture

CheckPoint is built using:

- **Flutter**
- **Clean Architecture**
- **Feature-based modular structure**
- **Provider (State Management)**
- **Dio (Networking)**
- **Mason (Feature scaffolding)**
- **Firebase Cloud Functions (Secure Steam API Proxy)**

## 🗂 Project Structure

The project adopts a feature-first Clean Architecture structure:

```
lib/
├── core/
└── features/
├── auth/
├── library/
└── achievements/
```

Each feature is organized into:

- **data** (API, models, repositories)
- **domain** (entities, use cases)
- **presentation** (controllers, providers, UI)

This structure enables scalability, testability, and production-level maintainability.

---

## 🔐 Security

The Steam Web API key is never exposed in the mobile application.

All Steam API requests are handled through a secure backend proxy built with Firebase Cloud Functions.

Authentication is performed via Steam OpenID.

---

## 🧱 Code Generation with Mason

CheckPoint uses Mason bricks to generate new features following Clean Architecture standards.

Example:

bash
mason make feature_clean_provider --feature_name achievements

This ensures consistency, scalability, and maintainability.

## 👨‍💻 Author

**Ramon Santos**  
Flutter Developer specializing in Clean Architecture and scalable mobile applications.
