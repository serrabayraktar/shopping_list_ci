# Alışveriş Listem — Flutter + GitHub Actions

A small Flutter mobile application for practicing automated tests in CI.

## Features
- Add shopping list items
- Prevent empty input
- Mark an item purchased
- Delete an item

## Requirements
- Flutter SDK (stable channel) installed on macOS
- Android Studio + emulator for Android UI, or Xcode + iOS Simulator for iOS UI
- Git + GitHub account

## First run
1. Unzip the project, then open Terminal in the `shopping_list_ci` directory.
2. Run `flutter doctor` to check your setup.
3. Run `flutter create --platforms=android,ios .` to generate platform projects. This only needs to be done once locally.
4. Run `flutter pub get`.
5. Run `flutter test` to run five widget tests, no emulator needed.
6. Run `flutter run` with a running emulator/simulator to see the app.

## CI/CD
The `.github/workflows/flutter_ci.yml` workflow executes on every push and pull request. It checks out the code, installs Flutter, generates Android project boilerplate, runs static analysis, and runs widget tests.

This CI setup runs **widget tests**, not emulator-based end-to-end integration tests.

## Upload to GitHub
Create a **new empty repository** named `shopping_list_ci` (do not initialize with README), and run:

```bash
git init
git add .
git commit -m "Add Flutter shopping app and automated tests"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/shopping_list_ci.git
git push -u origin main
```

Replace `YOUR_USERNAME` with your GitHub handle. Open your repository's **Actions** tab to inspect the CI run.
