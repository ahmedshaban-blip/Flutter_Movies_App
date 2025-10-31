# Flutter Movies App

[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/ahmedshaban-blip/Flutter_Movies_App)

A feature-rich movie browsing application built with Flutter, showcasing clean architecture, dynamic theming, and smooth animations. The app fetches data from The Movie Database (TMDb) API to display now-playing and upcoming movies, allows users to view details, and manage a local favorites list.

---

## 📱 Screenshots

<div align="center">
  <img src="https://raw.githubusercontent.com/ahmedshaban-blip/Flutter_Movies_App/refs/heads/main/assets/screenshots/splash.jpg" width="200" alt="Splash Screen"/>
  <img src="https://raw.githubusercontent.com/ahmedshaban-blip/Flutter_Movies_App/refs/heads/main/assets/screenshots/onboarding1.jpg" width="200" alt="Onboarding Screen 1"/>
  <img src="https://raw.githubusercontent.com/ahmedshaban-blip/Flutter_Movies_App/refs/heads/main/assets/screenshots/onboarding2.jpg" width="200" alt="Onboarding Screen 2"/>
  <img src="https://raw.githubusercontent.com/ahmedshaban-blip/Flutter_Movies_App/refs/heads/main/assets/screenshots/onboarding3.jpg" width="200" alt="Onboarding Screen 3"/>
</div>

<div align="center">
  <img src="https://raw.githubusercontent.com/ahmedshaban-blip/Flutter_Movies_App/refs/heads/main/assets/screenshots/Now%20Playing.jpg" width="200" alt="Now Playing"/>
  <img src="https://raw.githubusercontent.com/ahmedshaban-blip/Flutter_Movies_App/refs/heads/main/assets/screenshots/upcoming.jpg" width="200" alt="Upcoming Movies"/>
  <img src="https://raw.githubusercontent.com/ahmedshaban-blip/Flutter_Movies_App/refs/heads/main/assets/screenshots/Favorite.jpg" width="200" alt="Favorites"/>
  <img src="https://raw.githubusercontent.com/ahmedshaban-blip/Flutter_Movies_App/refs/heads/main/assets/screenshots/Details2.jpg" width="200" alt="Movie Details"/>
</div>

---

## ✨ Features

- **🎬 Discover Movies**: Browse through comprehensive lists of "Now Playing" and "Upcoming" movies with beautiful card layouts
- **📖 Detailed Views**: Tap on any movie to see an immersive detail screen featuring:
  - High-quality movie poster
  - Full title and overview
  - IMDb-style rating with stars
  - Release date and popularity metrics
  - Backdrop image for enhanced visual appeal
- **❤️ Favorites Management**: Add or remove movies from your personal favorites list with instant feedback, persisted locally on the device
- **🌓 Dynamic Theming**: Seamlessly switch between a sleek dark mode and a clean light mode with smooth transitions
- **🌍 Localization**: Full support for English and Arabic languages with RTL (Right-to-Left) support
- **📱 Responsive UI**: Perfectly adapts to different screen sizes and orientations using flutter_screenutil
- **🎨 Smooth Animations**: 
  - Animated splash screen with Lottie animations
  - Engaging onboarding flow for first-time users
  - Page transitions and micro-interactions throughout the app
- **🔍 Search & Filter**: Easily find your favorite movies
- **💾 Offline Support**: Favorites are stored locally and available even without internet connection

---

## 🏗️ Technology Stack & Architecture

This project follows **Clean Architecture** principles to create a scalable, maintainable, and testable codebase. The application is organized into three distinct layers:

### 🎨 Presentation Layer
Handles all UI and user interactions using the **BLoC (Cubit)** pattern for state management.

**Technologies:**
- **Framework**: Flutter SDK
- **State Management**: `flutter_bloc` (Cubit pattern)
- **Responsive Design**: `flutter_screenutil`
- **Fonts**: `google_fonts`
- **Animations**: `flutter_animate`, `animate_do`, `lottie`
- **UI Components**: Custom widgets following Material Design 3

### 🧠 Domain Layer
Contains the core business logic, completely independent of frameworks and external dependencies.

**Components:**
- **Entities**: Core business models (Movie, Genre, etc.)
- **Use Cases**: Business logic operations (GetNowPlayingMovies, GetUpcomingMovies, ToggleFavorite)
- **Repository Interfaces**: Contracts for data operations

### 💽 Data Layer
Implements data retrieval from remote and local sources.

**Technologies:**
- **Networking**: `dio` with interceptors for error handling
- **HTTP Client**: RESTful API integration with TMDb
- **Local Storage**: `shared_preferences` for user preferences and favorites
- **Serialization**: `json_serializable` for model conversion
- **Dependency Injection**: `get_it` for service location

**Data Sources:**
- **Remote**: TMDb API for movie data
- **Local**: SharedPreferences for favorites and settings

---

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK**: Version 3.0 or higher ([Installation Guide](https://docs.flutter.dev/get-started/install))
- **Dart SDK**: Version 3.0 or higher (included with Flutter)
- **IDE**: VS Code, Android Studio, or IntelliJ IDEA
- **Git**: For version control

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ahmedshaban-blip/flutter_movies_app.git
   cd flutter_movies_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **API Configuration:**
   - The project comes with a demo API key for TMDb
   - Located in: `lib/core/network/movies_api.dart`
   - To use your own API key:
     1. Get a free API key from [The Movie Database (TMDb)](https://www.themoviedb.org/settings/api)
     2. Replace the existing key in `movies_api.dart`

4. **Run the application:**
   ```bash
   # For development
   flutter run
   
   # For release build
   flutter run --release
   ```

5. **Generate localization assets (if needed):**
   ```bash
   flutter pub run easy_localization:generate -S assets/translations
   ```

---

## 📁 Project Structure

The project follows a feature-first approach with clean architecture layers:

```
lib/
├── main.dart                          # App entry point
├── app.dart                           # App widget configuration
├── app_bloc_observer.dart             # BLoC observer for debugging
│
├── core/                              # Core functionality shared across features
│   ├── constants/                     # App-wide constants
│   │   ├── api_constants.dart         # API endpoints and keys
│   │   ├── app_constants.dart         # General app constants
│   │   └── storage_keys.dart          # Local storage keys
│   │
│   ├── cubit/                         # Global state management
│   │   ├── theme_cubit.dart           # Theme management
│   │   └── locale_cubit.dart          # Localization management
│   │
│   ├── errors/                        # Error handling
│   │   ├── failures.dart              # Failure classes
│   │   └── exceptions.dart            # Custom exceptions
│   │
│   ├── extensions/                    # Dart extensions
│   │   ├── context_extension.dart     # BuildContext helpers
│   │   ├── string_extension.dart      # String utilities
│   │   └── date_extension.dart        # Date formatting
│   │
│   ├── network/                       # Networking layer
│   │   ├── api_consumer.dart          # API interface
│   │   ├── dio_consumer.dart          # Dio implementation
│   │   └── movies_api.dart            # TMDb API endpoints
│   │
│   ├── routing/                       # Navigation
│   │   ├── app_router.dart            # Route definitions
│   │   └── routes.dart                # Route names
│   │
│   ├── services/                      # Core services
│   │   ├── theme_service.dart         # Theme persistence
│   │   ├── locale_service.dart        # Language persistence
│   │   └── service_locator.dart       # Dependency injection
│   │
│   └── theme/                         # Theming
│       ├── app_theme.dart             # Theme definitions
│       ├── app_colors.dart            # Color palette
│       └── text_styles.dart           # Typography
│
├── features/                          # Feature modules
│   ├── bottom_nav.dart                # Bottom navigation bar
│   │
│   ├── splash/                        # Splash screen
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   └── splash_screen.dart
│   │   │   └── widgets/
│   │
│   ├── onboarding/                    # Onboarding flow
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   └── onboarding_screen.dart
│   │   │   └── widgets/
│   │   │       ├── onboarding_page.dart
│   │   │       └── page_indicator.dart
│   │
│   ├── home/                          # Now Playing movies
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── movie_model.dart
│   │   │   ├── datasources/
│   │   │   │   └── movies_remote_datasource.dart
│   │   │   └── repositories/
│   │   │       └── movies_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── movie.dart
│   │   │   ├── repositories/
│   │   │   │   └── movies_repository.dart
│   │   │   └── usecases/
│   │   │       └── get_now_playing_movies.dart
│   │   └── presentation/
│   │       ├── cubit/
│   │       │   ├── movies_cubit.dart
│   │       │   └── movies_state.dart
│   │       ├── screens/
│   │       │   └── home_screen.dart
│   │       └── widgets/
│   │           ├── movie_card.dart
│   │           └── movies_list.dart
│   │
│   ├── upcoming/                      # Upcoming movies
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── details/                       # Movie details
│   │   └── presentation/
│   │       ├── screens/
│   │       │   └── movie_details_screen.dart
│   │       └── widgets/
│   │           ├── movie_header.dart
│   │           ├── movie_info.dart
│   │           └── rating_display.dart
│   │
│   └── favorite/                      # Favorites management
│       ├── data/
│       │   └── datasources/
│       │       └── favorites_local_datasource.dart
│       ├── domain/
│       │   └── usecases/
│       │       ├── get_favorites.dart
│       │       ├── add_favorite.dart
│       │       └── remove_favorite.dart
│       └── presentation/
│           ├── cubit/
│           │   ├── favorites_cubit.dart
│           │   └── favorites_state.dart
│           └── screens/
│               └── favorites_screen.dart
│
└── assets/                            # Static assets
    ├── images/                        # Image assets
    ├── animations/                    # Lottie animations
    └── translations/                  # Localization files
        ├── en.json
        └── ar.json
```

---

## 🎨 Key Architecture Patterns

### Clean Architecture Benefits
- **Independence**: Business logic is independent of frameworks, UI, and external agencies
- **Testability**: Business rules can be tested without UI, database, or external elements
- **Flexibility**: Easy to switch data sources or UI frameworks
- **Maintainability**: Changes in one layer don't affect others

### State Management (BLoC/Cubit)
- **Separation of Concerns**: Business logic separated from UI
- **Predictable State**: Unidirectional data flow
- **Easy Testing**: Testable without UI components
- **Reactive**: Automatic UI updates on state changes

### Dependency Injection (GetIt)
- **Loose Coupling**: Components depend on abstractions
- **Easy Mocking**: Simple to mock dependencies for testing
- **Single Responsibility**: Each component has one clear purpose

---

## 🛠️ Key Dependencies

```yaml
dependencies:
  # Core Framework
  flutter:
    sdk: flutter
  
  # State Management
  flutter_bloc: ^8.1.3
  
  # Networking
  dio: ^5.3.2
  
  # Local Storage
  shared_preferences: ^2.2.1
  
  # Dependency Injection
  get_it: ^7.6.4
  
  # Localization
  easy_localization: ^3.0.3
  
  # UI & Animations
  flutter_screenutil: ^5.9.0
  google_fonts: ^6.1.0
  flutter_animate: ^4.2.0
  animate_do: ^3.1.2
  lottie: ^2.7.0
  
  # Utilities
  intl: ^0.18.1
  cached_network_image: ^3.3.0
```

---

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📝 License

Distributed under the MIT License. See `LICENSE` for more information.

---

## 👨‍💻 Author

**Ahmed Shaban**

- GitHub: [@ahmedshaban-blip](https://github.com/ahmedshaban-blip)

- LinkedIn:  www.linkedin.com/in/ahmed-shaban-front-cross

---

## 🙏 Acknowledgments

- [The Movie Database (TMDb)](https://www.themoviedb.org/) for providing the movie data API
- [Flutter Community](https://flutter.dev/community) for amazing packages and support
- All contributors who help improve this project

---

## 📞 Support

If you have any questions or need help, please open an issue in the GitHub repository.

⭐️ **If you find this project useful, please consider giving it a star!** ⭐️
