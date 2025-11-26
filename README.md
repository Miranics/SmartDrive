# SmartDrive

SmartDrive is a mobile application built with Flutter that helps learners prepare for their provisional driving license exam in Rwanda. The app provides practice quizzes, mock tests, flashcards, progress tracking, and practical driving tips.

## Table of Contents

- [Features](#features)
- [Screenshots](#screenshots)
- [Technology Stack](#technology-stack)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Firebase Setup](#firebase-setup)
- [Running the Application](#running-the-application)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [Contributing](#contributing)
- [License](#license)

## Features

### User Authentication

- Secure user registration and login with Firebase Authentication
- Email verification system to ensure valid user accounts
- Password reset functionality
- Remember me option for convenient access

### Learning Tools

- **Flashcards**: Study key driving concepts and road signs
- **Practice Quizzes**: Interactive multiple-choice questions with instant feedback
- **Mock Tests**: Full exam simulations that mirror the actual provisional exam
- **Progress Tracking**: Visual dashboard showing learning statistics and performance metrics

### Progress Monitoring

- Track average scores and quiz completion
- Monitor questions answered across different categories
- View study streaks and exam readiness percentage
- Set exam date with countdown timer
- Category-based progress (Traffic Signs, Road Safety, Vehicle Control)

### Additional Features

- Practical driving tips and guidance
- Dark mode support with theme switching
- Clean, modern user interface with Material Design 3
- Offline-capable with local data caching

## Screenshots

### Authentication Screens

Homepage/Landing Page

<img width="523" height="1005" alt="image" src="https://github.com/user-attachments/assets/0ecdfbf7-3aad-4078-be12-296d5b0ad085" />

Login Screen

<img width="526" height="1011" alt="image" src="https://github.com/user-attachments/assets/fccc4d5f-cca8-4318-ba93-7103149c57d2" />

Sign Up Screen

<img width="518" height="1005" alt="image" src="https://github.com/user-attachments/assets/6a12d1bf-70e2-42d9-bd80-e9b2f2e613df" />

### Main Application Screens

Welcome Page

<img width="493" height="1003" alt="image" src="https://github.com/user-attachments/assets/b27752a2-5e66-4cfe-9246-3b5d2768351e" />

Provisional Exam Dashboard

<img width="481" height="1020" alt="image" src="https://github.com/user-attachments/assets/9b23539d-adb6-4c99-bdf5-c088e6febef7" />

Practice Quiz

<img width="519" height="1006" alt="image" src="https://github.com/user-attachments/assets/308ab298-1bb1-4a31-8556-44be385408fb" />

Mock Test

<img width="533" height="1009" alt="image" src="https://github.com/user-attachments/assets/cd772994-f631-4515-a10e-223156c88d0c" />

### Progress and Settings

Progress Screen

<img width="507" height="1004" alt="image" src="https://github.com/user-attachments/assets/260e30e3-5fd7-4331-a5a4-b894ba77f586" />

Flashcards

<img width="519" height="1014" alt="image" src="https://github.com/user-attachments/assets/e95cbb35-bc0a-4737-9f07-ebf68971466d" />

Practical Tips

<img width="502" height="1020" alt="image" src="https://github.com/user-attachments/assets/62d039de-cdca-4356-ade5-189a23390c9a" />

Settings Page

<img width="515" height="1009" alt="image" src="https://github.com/user-attachments/assets/0a2c670e-49be-4e11-9b60-f8f581adcfdd" />

## Technology Stack

### Frontend

- **Framework**: Flutter 3.9.0+
- **Language**: Dart 3.1.3+
- **UI Design**: Material Design 3
- **State Management**: Riverpod 2.6.1
- **Fonts**: NicoMoji (branding), Google Fonts Montserrat (content)

### Backend Services

- **Authentication**: Firebase Authentication 5.3.2
- **Database**: Cloud Firestore 5.4.4
- **Core**: Firebase Core 3.6.0

### Additional Libraries

- **Environment Variables**: flutter_dotenv 6.0.0
- **Local Storage**: shared_preferences 2.2.2
- **Functional Programming**: dartz 0.10.1
- **Package Info**: package_info_plus 8.0.0
- **Google Sign In**: google_sign_in 6.2.2

## Project Structure

```
lib/
├── main.dart                      # Application entry point
├── firebase_options.dart          # Firebase configuration
├── config/
│   └── runtime_env.dart           # Environment configuration
├── constants/
│   └── app_colors.dart            # Color constants
├── core/
│   ├── constants/                 # Core constants
│   ├── errors/                    # Error handling
│   ├── router/                    # Route guards and navigation
│   └── theme/                     # Theme configuration
├── features/
│   └── auth/                      # Authentication feature module
├── models/
│   ├── provisional_question.dart  # Question data model
│   └── user_exam_stats.dart       # User statistics model
├── providers/
│   └── theme_provider.dart        # Theme state management
├── screens/
│   ├── homepage.dart              # Landing page
│   ├── login.dart                 # Login screen
│   ├── signup.dart                # Registration screen
│   ├── verify_email.dart          # Email verification
│   ├── WelcomePage.dart           # Main dashboard
│   ├── provisional_exam.dart      # Exam practice hub
│   ├── QuizPage.dart              # Practice quiz interface
│   ├── flashcard.dart             # Flashcard study mode
│   ├── mock_test_page.dart        # Mock test interface
│   ├── progress_screen.dart       # Progress dashboard
│   ├── tips_page.dart             # Driving tips
│   ├── settings_page.dart         # App settings
│   └── forgot_password.dart       # Password reset
├── services/
│   ├── auth_service.dart          # Authentication logic
│   ├── provisional_exam_service.dart  # Exam data service
│   └── preferences_service.dart   # Local preferences
├── utils/
│   └── theme_helper.dart          # Theme utilities
└── widgets/
    ├── button_component.dart      # Reusable button
    ├── input.dart                 # Input field component
    ├── page_header.dart           # Page header component
    ├── practice_quiz_card.dart    # Quiz card widget
    ├── progress_bar.dart          # Progress indicator
    ├── tips_card_component.dart   # Tips card widget
    ├── contact_us_card.dart       # Contact card
    └── user_status.dart           # User status widget
```

## Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK**: Version 3.9.0 or higher
  - Download from: https://docs.flutter.dev/get-started/install
- **Dart SDK**: Version 3.1.3 or higher (included with Flutter)
- **Firebase CLI**: Install globally via npm
  ```bash
  npm install -g firebase-tools
  ```
- **FlutterFire CLI**: Install globally via Dart
  ```bash
  dart pub global activate flutterfire_cli
  ```
- **Code Editor**: VS Code, Android Studio, or IntelliJ IDEA
- **Git**: For version control
- **Firebase Account**: Create a free account at https://firebase.google.com

### Platform-Specific Requirements

#### Android

- Android Studio with Android SDK
- Minimum SDK version: 21 (Android 5.0)
- Java Development Kit (JDK) 11 or higher

#### iOS (macOS only)

- Xcode 14.0 or higher
- CocoaPods
- iOS deployment target: 12.0 or higher

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/Miranics/SmartDrive.git
cd SmartDrive
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Verify Flutter Installation

```bash
flutter doctor
```

Resolve any issues reported by Flutter Doctor before proceeding.

## Firebase Setup

### 1. Create a Firebase Project

1. Go to the [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project" and follow the setup wizard
3. Name your project (e.g., "SmartDrive")
4. Enable Google Analytics (optional)

### 2. Enable Firebase Services

#### Authentication

1. In Firebase Console, go to Authentication
2. Click "Get Started"
3. Enable "Email/Password" sign-in method
4. Optionally enable "Google" sign-in

#### Firestore Database

1. Go to Firestore Database
2. Click "Create database"
3. Start in production mode or test mode
4. Choose a Cloud Firestore location

### 3. Configure Firebase for Flutter

#### Authenticate with Firebase CLI

```bash
firebase login
```

#### Run FlutterFire Configuration

```bash
flutterfire configure --project=your-firebase-project-id
```

This command will:

- Generate `lib/firebase_options.dart` with your Firebase configuration
- Create platform-specific configuration files

#### Android Configuration

1. Download `google-services.json` from Firebase Console
2. Place it in `android/app/` directory
3. Verify package name matches `com.example.smartdrive` in:
   - `android/app/build.gradle`
   - `android/app/src/main/AndroidManifest.xml`

#### iOS Configuration (if building for iOS)

1. Download `GoogleService-Info.plist` from Firebase Console
2. Place it in `ios/Runner/` directory
3. Open `ios/Runner.xcworkspace` in Xcode
4. Add the plist file to the Runner target

#### macOS Configuration (if building for macOS)

1. Download `GoogleService-Info.plist` for macOS
2. Place it in `macos/Runner/` directory

### 4. Environment Variables (Optional)

Create a `.env` file in the project root:

```bash
cp .env.example .env
```

Edit `.env` to customize the email verification redirect URL:

```
FIREBASE_EMAIL_REDIRECT_URL=https://your-project-id.firebaseapp.com
```

### 5. Seed Question Data (Optional)

To populate the question bank:

1. Navigate to the scripts directory
2. Run the seeding script:
   ```bash
   node scripts/seed_provisional_questions.js
   ```

Alternatively, manually add questions to Firestore:

- Collection: `provisional_questions`
- Document structure:
  ```json
  {
    "question": "What does a red traffic light mean?",
    "a": "Stop",
    "b": "Slow down",
    "c": "Proceed with caution",
    "d": "Speed up",
    "correctAnswer": "a",
    "category": "Traffic Signs"
  }
  ```

## Running the Application

### Development Mode

#### Run on Connected Device/Emulator

```bash
flutter run
```

#### Run on Specific Device

```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d device_id
```

#### Run with Hot Reload

Flutter supports hot reload by default. After making code changes:

- Press `r` in the terminal to hot reload
- Press `R` to hot restart

### Build for Production

#### Android APK

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

#### Android App Bundle (for Play Store)

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

#### iOS (macOS only)

```bash
flutter build ios --release
```

Then open Xcode to archive and distribute.

### Troubleshooting

#### Common Issues

1. **Firebase initialization error**

   - Verify `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) is in the correct location
   - Run `flutterfire configure` again

2. **Package version conflicts**

   ```bash
   flutter pub upgrade
   flutter clean
   flutter pub get
   ```

3. **Build errors**

   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

4. **Gradle build issues (Android)**
   - Check internet connection
   - Clear Gradle cache: `cd android && ./gradlew clean`

## Usage

### First Time Setup

1. **Launch the App**: Open SmartDrive on your device
2. **Create Account**:
   - Tap "Start Now" on the homepage
   - Fill in your name, email, and password
   - Tap "Sign Up"
3. **Verify Email**:
   - Check your email inbox for verification link
   - Click the verification link
   - Return to the app and log in
4. **Start Learning**: Access the welcome dashboard

### Main Features

#### Practice Quiz

1. From the welcome page, tap "Provisional Exam Practice"
2. Select "Practice Quiz"
3. Answer questions with instant feedback
4. Progress automatically saves

#### Mock Test

1. Navigate to "Provisional Exam Practice"
2. Select "Mock tests"
3. Complete timed full-length practice exams
4. Review results and statistics

#### Flashcards

1. Go to "Provisional Exam Practice"
2. Select "Flashcards"
3. Swipe through cards to study concepts
4. Tap to flip and reveal answers

#### Track Progress

1. Tap "Progress" from the provisional exam page
2. View statistics:
   - Average score
   - Questions answered
   - Study streak
   - Category-specific progress
3. Set your exam date for countdown tracking

#### Practical Tips

1. From the welcome page, tap "Practical Driving Tips"
2. Browse tips organized by category
3. Learn real-world driving scenarios

#### Settings

1. Tap the settings icon (top right on welcome page)
2. Toggle dark mode
3. View app information
4. Log out

## Dependencies

### Core Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Firebase
  firebase_core: ^3.6.0
  firebase_auth: ^5.3.2
  cloud_firestore: ^5.4.4

  # State Management
  flutter_riverpod: ^2.6.1

  # UI
  google_fonts: ^6.1.0
  cupertino_icons: ^1.0.8

  # Utilities
  flutter_dotenv: ^6.0.0
  shared_preferences: ^2.2.2
  package_info_plus: ^8.0.0
  dartz: ^0.10.1
  equatable: ^2.0.7

  # Authentication
  google_sign_in: ^6.2.2
```

### Dev Dependencies

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

## Contributing

Contributions are welcome! Please follow these steps:

1. **Fork the Repository**

   ```bash
   git clone https://github.com/your-username/SmartDrive.git
   ```

2. **Create a Feature Branch**

   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make Changes**

   - Write clean, documented code
   - Follow Flutter style guidelines
   - Test your changes thoroughly

4. **Commit Changes**

   ```bash
   git add .
   git commit -m "Add: description of your changes"
   ```

5. **Push to Branch**

   ```bash
   git push origin feature/your-feature-name
   ```

6. **Open a Pull Request**
   - Go to the original repository
   - Click "New Pull Request"
   - Describe your changes in detail

### Code Style Guidelines

- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused
- Write widget tests for new features

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Support

For questions, issues, or feature requests:

- **GitHub Issues**: https://github.com/Miranics/SmartDrive/issues
- **Email**: Contact through the in-app contact card
- **Documentation**: See [docs/backend_setup.md](docs/backend_setup.md) for detailed Firebase setup

## Acknowledgments

- Firebase for authentication and database services
- Flutter team for the framework
- Google Fonts for typography
- Rwanda driving regulations for content guidance

Made With Love for aspiring drivers
