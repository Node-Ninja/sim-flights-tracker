# Sim Flights Tracker

Sim Flights Tracker is a Flutter app for tracking simulated flights and controllers on VATSIM / IVAO networks. Official site: https://www.simflightstracker.com

## Quick links
- Project entry: lib/main.dart
- App shell: lib/sim_flights_tracker.dart
- Routing: lib/core/config/router_config.dart
- Providers: lib/core/state/provider/providers.dart (includes appConfigProvider, liveDataProvider)
- Dependency injection: lib/core/dependency_injection/injection_container.dart
- Routes constants: lib/core/constants/app_routes.dart
- Example test: test/app_config_provider_test.dart
- Example env: .env.example

## Prerequisites
- Flutter installed and configured (stable channel recommended). See https://flutter.dev
- Android SDK (for Android) or Xcode (for iOS) for device/emulator builds
- Optional: Visual Studio Code or Android Studio

## Setup

1. Clone the repository
```bash
git clone <repository-url>
cd sim-flights-tracker
```

2. Install Flutter packages
```bash
flutter pub get
```

3. Create and populate the environment file
```bash
cp .env.example .env
# Edit .env and provide required values (Google Maps API key, ad unit IDs, backend host, etc.)
```
Ensure .env exists and matches keys in .env.example. Missing or invalid values may cause runtime errors.

4. Platform-specific setup
- Android: ensure AndroidManifest.xml contains required entries for maps/ads and Gradle config is correct.
- iOS: ensure Info.plist contains required keys and signing is configured.

5. Dependency injection
- The DI container is configured in lib/core/dependency_injection/injection_container.dart and initialized at startup. No extra manual step beyond .env is usually required.

## Run the app
```bash
flutter run
```
Entrypoint: main() in lib/main.dart

## Build
- Android APK:
```bash
flutter build apk --release
```
- iOS (macOS + Xcode required):
```bash
flutter build ios --release
```

## Testing
```bash
flutter test
```
See test/app_config_provider_test.dart for an example.

## Configuration notes
- Routing: lib/core/config/router_config.dart, routes in lib/core/constants/app_routes.dart
- State management: Riverpod providers in lib/core/state/provider/providers.dart
- App config persistence: lib/core/state/notifier/app_config_state_notifier.dart and lib/core/state/model/app_config_state.dart
- Backend API: implemented in the data layer (lib/data/datasource/remote/sft/sft_datasource_impl.dart and repository layers). To use a different backend, update .env and relevant constants.

## Localization
- Generated localization: lib/core/config/i10n/generated/
- Active locale supplied by appConfigProvider and applied in lib/sim_flights_tracker.dart

## Troubleshooting
- Ensure .env exists and values match .env.example.
- If maps or ads fail, verify platform manifest/Info.plist entries and keys in .env.
- For network/backend issues, inspect datasource implementations in lib/data/...

## Contributing
- Fork the repository, create a feature branch, add tests, and open a pull request.
- Follow existing code style and project conventions.

## License
- This repository contains the open source app for Sim Flights Tracker. Check project files for license and attribution details.