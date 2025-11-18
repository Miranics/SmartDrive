# SmartDrive

SmartDrive is a Flutter app that helps learner drivers track progress, practice quizzes, and store supporting documents. The backend stack is:

- **Firebase Authentication** for signup/login
- **Firestore** (ready for data once billing is enabled)
- **Supabase Storage** for uploading learner documents from the home screen card

## Prerequisites

- Flutter 3.24+ (uses Dart 3.4/3.5 features)
- Firebase CLI + FlutterFire CLI: `npm install -g firebase-tools` and `dart pub global activate flutterfire_cli`
- A Firebase project (this repo currently points to `smartdrive-dc55d`)
- A Supabase project with a bucket named `smartdrive-files`

## Local setup

1. Request the current `.env` file (Supabase URL/anon key/bucket) from the project owner and place it at the repo root. The file is gitignored on purpose, so never commit it.
2. If you haven’t already, run `flutterfire configure --project <your-project-id>` so `lib/firebase_options.dart` matches your Firebase project and drop the generated `google-services.json` / `GoogleService-Info.plist` files into the respective platform folders.
3. Install dependencies and launch:

	```powershell
	flutter pub get
	flutter run --dart-define-from-file=.env
	```

	> If your Flutter version doesn’t support `--dart-define-from-file`, pass each `SUPABASE_*` value manually.

## Feature smoke test

1. Launch the app on an emulator or device.
2. Use **Sign Up** to create a new email/password account (Firebase Auth panel should show the user).
3. Log in with the same credentials and land on the home screen.
4. Use the **Upload to Supabase Storage** card to select any small file. A toast appears and the file is uploaded to the `smartdrive-files` bucket under `<uid>/<timestamp>_<filename>`.

## Troubleshooting

- Firestore now requires billing. Make sure your Firebase project is linked to a Google Cloud billing account even if you stay within the free tier.
- If Supabase uploads fail, double-check the anon key and that the bucket allows authenticated uploads.
- See a full backend walkthrough in [`docs/backend_setup.md`](docs/backend_setup.md).

## Tests

```powershell
flutter test
```

Known analyzer infos (super parameters, `withOpacity`) are on the backlog and don’t block functionality.
