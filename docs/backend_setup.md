# Backend Setup (Firebase Only)

Follow these steps to connect the SmartDrive Flutter app to Firebase services.

## 1. Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.22 or newer
- Firebase CLI: `npm install -g firebase-tools`
- FlutterFire CLI: `dart pub global activate flutterfire_cli`
- A Firebase project named **SmartDrive** (or any name you prefer)

## 2. Configure Firebase

1. Authenticate in the CLI:
   ```powershell
   firebase login
   ```
2. From the project root, run the FlutterFire wizard and select every platform you plan to ship:
   ```powershell
   flutterfire configure --project=<your-firebase-project-id>
   ```
   This command generates `lib/firebase_options.dart` with real credentials. The repository currently contains a placeholder file—overwrite it with the generated one.
3. Android-specific:
   - Download the generated `google-services.json` and place it in `android/app/`.
   - Ensure your package name in Firebase matches `com.example.smartdrive` or update `android/app/build.gradle` + `android/app/src/main/AndroidManifest.xml` accordingly.
4. iOS/macOS-specific:
   - Download `GoogleService-Info.plist` for each bundle ID (Runner, macOS) and add them to `Runner/` and `macos/Runner/` respectively.
   - In Xcode, add the plist files to the Runner targets and enable the **FirebaseAppDelegateProxyEnabled** setting if you use Messaging later.
5. Web/Desktop:
   - FlutterFire already injects the configuration; just ensure `web/index.html` contains `<script src="/__/firebase/init.js"></script>` (added automatically by FlutterFire 3+).

## 3. Optional runtime overrides

SmartDrive reads the `.env` file (via `flutter_dotenv`) if you need to override the Firebase email verification redirect URL. Create `.env` at the repository root with:

```
FIREBASE_EMAIL_REDIRECT_URL=https://smartdrive-dc55d.firebaseapp.com
```

If the file is omitted, the default value above is used automatically.

## 4. Verify the integration

1. Launch the app. The splash/login screen initializes Firebase before building the UI.
2. Create a new account via **Sign Up**; check the Firebase Console → Authentication tab to confirm the user record.
3. Log in with the new account. You should land on the Home screen and can access quizzes, progress, and mock tests backed by Firestore data.

Once these steps succeed, the backend is fully connected and ready for additional Firestore-powered content.
