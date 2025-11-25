# 🚗 SmartDrive

**SmartDrive** is a comprehensive Flutter mobile application designed to help learners prepare for their provisional driving license exam in Rwanda. The app provides an interactive learning experience with practice quizzes, progress tracking, and practical driving tips.

## 📱 Features

- **🔐 User Authentication**: Secure sign-up and login with Firebase Authentication, including email verification
- **📝 Practice Quizzes**: Interactive multiple-choice quizzes covering driving theory and road safety
- **📊 Progress Tracking**: Visual progress indicators to track learning advancement
- **🎯 Mock Tests**: Comprehensive practice tests simulating the actual provisional exam
- **💡 Driving Tips**: Practical tips and guidance for real-world driving scenarios
- **☁️ Cloud Storage**: File upload and management using Supabase Storage
- **🎨 Modern UI**: Clean, intuitive interface with Material Design 3 and custom fonts

## 🏗️ Architecture

### Tech Stack

- **Frontend**: Flutter 3.9.0+ with Material Design 3
- **Backend Services**:
  - Firebase Authentication (user management & email verification)
  - Cloud Firestore (data storage)
  - Supabase Storage (file uploads & asset management)
- **State Management**: StreamBuilder for reactive authentication state
- **Custom Fonts**: NicoMoji for branding, Google Fonts (Montserrat) for content

### Project Structure

```
lib/
├── main.dart                 # App entry point & authentication gate
├── config/
│   └── runtime_env.dart      # Environment configuration
├── screens/
│   ├── homepage.dart         # Main landing page
│   ├── login.dart            # User login screen
│   ├── signup.dart           # User registration
│   ├── verify_email.dart     # Email verification flow
│   ├── QuizPage.dart         # Interactive quiz interface
│   ├── progress_screen.dart  # Learning progress dashboard
│   ├── provisional_exam.dart # Mock exam simulator
│   ├── tips_page.dart        # Practical driving tips
│   └── WelcomePage.dart      # Onboarding screen
├── services/
│   ├── auth_service.dart     # Firebase auth wrapper
│   └── storage_service.dart  # Supabase storage utilities
└── widgets/
    └── [Reusable UI components]
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.9.0 or higher
- Dart SDK 3.0.0 or higher
- Firebase CLI: `npm install -g firebase-tools`
- FlutterFire CLI: `dart pub global activate flutterfire_cli`
- A Firebase project
- A Supabase project with storage bucket

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Miranics/SmartDrive.git
   cd SmartDrive
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   
   Follow the [Backend Setup Guide](docs/backend_setup.md) for detailed instructions:
   
   ```bash
   firebase login
   flutterfire configure --project=<your-firebase-project-id>
   ```
   
   - Place `google-services.json` in `android/app/`
   - Place `GoogleService-Info.plist` in `ios/Runner/` and `macos/Runner/`

4. **Configure Supabase**
   
   Create a `.env` file in the project root:
   
   ```env
   SUPABASE_URL=https://<your-project>.supabase.co
   SUPABASE_ANON_KEY=<your-anon-key>
   SUPABASE_STORAGE_BUCKET=smartdrive-files
   ```

5. **Run the app**
   ```bash
   flutter run --dart-define-from-file=.env
   ```

## 📦 Dependencies

### Core Dependencies
- `firebase_core` ^3.6.0 - Firebase initialization
- `firebase_auth` ^5.3.2 - User authentication
- `cloud_firestore` ^5.4.4 - Cloud database
- `supabase_flutter` ^2.6.0 - Supabase integration
- `flutter_dotenv` ^5.1.0 - Environment variable management
- `google_fonts` ^6.1.0 - Custom typography
- `file_picker` ^8.1.2 - File selection utilities
- `cupertino_icons` ^1.0.8 - iOS-style icons

### Dev Dependencies
- `flutter_test` - Testing framework
- `flutter_lints` ^5.0.0 - Code quality checks

## 🎯 Usage

### Authentication Flow
1. **Sign Up**: New users create an account with email and password
2. **Email Verification**: Users verify their email address before accessing the app
3. **Login**: Returning users sign in with credentials
4. **Auto-Login**: Users remain authenticated across sessions

### Learning Flow
1. **Welcome Screen**: Introduction to SmartDrive features
2. **Homepage**: Dashboard with navigation to different sections
3. **Practice Quizzes**: Answer questions with instant feedback
4. **Track Progress**: Monitor quiz completion and scores
5. **Mock Exams**: Simulate the actual driving test experience
6. **Tips & Resources**: Access practical driving advice

## 🔒 Security

- Firebase Authentication handles secure credential storage
- Email verification prevents unauthorized access
- Environment variables keep API keys out of version control
- Supabase Row Level Security (RLS) policies control data access

## 🌍 Localization

Currently supports:
- English (default)
- Focused on Rwandan driving regulations and road signs

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For backend configuration help, see [docs/backend_setup.md](docs/backend_setup.md)

For questions or issues:
- Open an issue on GitHub
- Contact the development team through the in-app contact card

## 🙏 Acknowledgments

- Firebase for authentication and database services
- Supabase for storage solutions
- Flutter team for the amazing framework
- Google Fonts for typography

---

**Made with ❤️ for aspiring drivers in Rwanda**

