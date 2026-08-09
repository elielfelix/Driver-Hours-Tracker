# 🚛 DOT Hours Tracker

[![Download APK](https://img.shields.io/badge/Download-APK-3b82f6?style=for-the-badge&logo=android)](https://github.com/elielfelix/Driver-Hours-Tracker/releases/latest/download/DOT-Hours-Tracker-v1.0.0.apk)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)

An open-source Flutter app (Android + Web) for truck drivers to track on-duty
work hours against DOT Hours-of-Service limits.

## 📥 Download

Get the latest Android APK from the **[Releases page](https://github.com/elielfelix/Driver-Hours-Tracker/releases/latest)** —
no Google Play account needed.

1. Go to [Releases](https://github.com/elielfelix/Driver-Hours-Tracker/releases/latest)
2. Download the `.apk` file under **Assets**
3. On your Android phone, open the downloaded file (you may need to allow
   **"Install from unknown sources"** for your browser/file manager, since
   this isn't distributed via the Play Store)
4. Tap **Install**

Log a **Start** and **End** time for each work session, subtract any **Break**
minutes, and the app totals your on-duty hours per day and per week —
highlighting violations of the 14-hour window, 11-hour driving cap, and
70-hour weekly limit. Lock a completed day to see the earliest time you can
legally clock back in (10-hour rest or 34-hour reset).

> ⚠️ **Disclaimer**: For personal reference only. This calculator is not a
> substitute for official logs, ELDs, or regulatory compliance tools. Always
> verify hours with your employer and follow applicable laws.

## ✨ Features

- Log multiple work sessions per day (start / end time + break minutes)
- Automatic on-duty hour calculation (gross and net of breaks)
- Daily limit tracking: 14-hr window, 11-hr on-duty
- Weekly 70-hour cap tracking with progress bar
- Lock ("I'm Done for Today") to compute next legal clock-in time
  (10-hr standard rest or 34-hr full reset)
- Export weekly data as **CSV** or **plain-text report**
- Share / copy a quick weekly summary
- All data stored locally on-device (no account, no server, no tracking)

## 📱 App Structure

This repo contains two things:

1. **`dot_hours_tracker.html`** — the original single-file HTML/CSS/JS web
   app (works standalone in any browser, data stored in `localStorage`).
2. **Flutter Android/Web app** (`lib/`, `android/`, etc.) — a native Android
   & Web wrapper that bundles the HTML app as an asset and renders it inside
   a `WebView`, so it can be installed and distributed as a normal Android
   APK / AAB while keeping the exact same logic and UI as the HTML version.

## 🛠️ Tech Stack

- [Flutter](https://flutter.dev) 3.35.4 / Dart 3.9.2
- [`webview_flutter`](https://pub.dev/packages/webview_flutter) to render the
  bundled HTML/CSS/JS app
- Vanilla HTML/CSS/JavaScript for the core tracker logic (no build step
  needed to run `dot_hours_tracker.html` directly in a browser)

## 🚀 Getting Started

### Run the standalone HTML app
Just open `dot_hours_tracker.html` in any modern browser — no install needed.

### Run the Flutter app
```bash
flutter pub get
flutter run            # debug, on a connected device/emulator
flutter build apk --release   # build a release APK
flutter build web --release   # build for web
```

## 📄 License

This project is open source under the [MIT License](LICENSE).
