# Backend Setup (Firebase + Supabase Storage)

Follow these steps to connect the SmartDrive Flutter app to your cloud backend.

## 1. Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.22 or newer
- Firebase CLI: `npm install -g firebase-tools`
- FlutterFire CLI: `dart pub global activate flutterfire_cli`
- A Firebase project named **SmartDrive** (or any name you prefer)
- A Supabase project with a storage bucket (default bucket name in code: `smartdrive-files`)

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

## 3. Configure Supabase Storage

1. In the Supabase dashboard, create a new project and note the **Project URL** and **anon public API key**.
2. In the **Storage** tab, create a bucket named `smartdrive-files` (or any bucket—if you rename it, pass `--dart-define SUPABASE_STORAGE_BUCKET=<name>` when running the app).
3. Optionally relax the bucket policy to allow authenticated users to upload/read. Example policy:
   ```sql
   create policy "Allow authenticated uploads"
   on storage.objects for insert
   with check ( auth.role() = 'authenticated' );
   ```

## 4. Provide runtime secrets

Request the latest `.env` file from the project owner and place it at the repository root (the file stays untracked in git):

```
SUPABASE_URL=https://<your-project>.supabase.co
SUPABASE_ANON_KEY=<anon-key>
SUPABASE_STORAGE_BUCKET=smartdrive-files
```

Run the app with:

```powershell
flutter run --dart-define-from-file=.env
```

If your Flutter version does not support `--dart-define-from-file`, pass each value manually:

```powershell
flutter run --dart-define SUPABASE_URL=... --dart-define SUPABASE_ANON_KEY=...
```

## 5. Verify the integration

1. Launch the app. The splash/login screen initializes Firebase + Supabase before building the UI.
2. Create a new account via **Sign Up**; check the Firebase Console → Authentication tab to confirm the user record.
3. Log in with the new account. You should land on the Home screen.
4. Use the **Upload to Supabase Storage** card to choose a local file. A successful upload returns a public URL that you can open from the Storage browser inside Supabase.

Once these steps succeed, the backend is fully connected and ready for additional features such as Firestore-powered content or Supabase-based asset storage.
