# Maverick App

## Mobile app screenshots
| Splash screen | Onboarding screen |
| ------------------------- | ------------------------- |
| <img width="480" height="854" alt="splash-screen" src="https://github.com/user-attachments/assets/06b35d97-499e-4147-aaca-bfc7c1d2aed4" /> | <img width="480" height="854" alt="Onboarding-screen" src="https://github.com/user-attachments/assets/604e9a50-4b4f-4af6-ba95-63e0471cfcd4" />|
| | |
| Login | Signup |
| <img width="480" height="854" alt="Login" src="https://github.com/user-attachments/assets/bbcd3b18-66dc-452b-9c17-41bfefed5ad9" /> | <img width="480" height="854" alt="signup" src="https://github.com/user-attachments/assets/7913c50d-c5a2-489d-9679-377c701c96d8" /> |
| | |
| | |
| Dashboard (home tab) | Send Money |
| <img width="480" height="854" alt="Dashboard" src="https://github.com/user-attachments/assets/fe34f625-1f23-4145-9027-f03c035acd39" /> | <img width="480" height="854" alt="Send-money" src="https://github.com/user-attachments/assets/d7b88131-fe2c-4014-b73d-389b068b826b" />|
| | |
| Transaction history | Profile |
| <img width="480" height="854" alt="Transaction-history" src="https://github.com/user-attachments/assets/0fb03220-3749-451f-9122-5433b9258198" /> | <img width="480" height="854" alt="Profile-screen" src="https://github.com/user-attachments/assets/3e133232-10ae-4d4a-85aa-d82c292d8591" /> |
| | |
| | |

## Overview
Maverick is a modern, cross-platform fintech application designed to make money management fast, secure, and effortless. Built with Flutter 💙 and Firebase 🔥, Maverick delivers a smooth, feature-rich experience on both Android and iOS.

Whether you’re sending money to friends, tracking your spending, or managing your digital wallet, Maverick keeps everything at your fingertips with an intuitive design and rock-solid security.

### Target users
Maverick is designed for individuals and groups in Africa and beyond who need fast, secure, and flexible ways to move money. Key user segments include:
- 💼 Freelancers – Professionals on platforms like Upwork or Fiverr receiving international payments.
- 🛍 Small Business Owners & Market Vendors – Accepting digital payments instead of cash, enabling safer and faster transactions.


### Key features
- 🔐 **Secure Authentication** – Login with Firebase Auth, plus app-level PIN protection for extra security.
- 💳 **Wallet Dashboard** – View your balance, recent transactions, and quick actions in one place.
- 💸 **Instant Money Transfers** – Send and receive money in multiple currencies with real-time processing.
- 📜 **Transaction History & Insights** – Track your spending, filter by date/type, and view analytics.
- 👤 **Profile & Settings** – Manage your personal details, update your PIN, and customize preferences.
- 🌓 **Dark & Light Mode** – Adaptive themes for a better user experience.


### Tech Stack
- 🎨 **Frontend**: Flutter v3.38.5, Dart v3.10.4
- ☁️ **Backend & Auth**: Firebase
- 💾 **Storage**: Firebase Firestore
- 🗄️ **Local Storage**: SQLite (for offline data and PIN storage)
- ⚡ **State Management**: BLoC
- 🏗️ **Architecture**: MVVM (separation of logic, UI, and services)
- 🗃️ **Libraries/packages**:
    - *crypto* - PIN hashing
    - *toastification* - display toast notifications in the app
    - *bootstrap_icons* - icons used in the app
    - *sqlflite* - for creating and managing SQLite db
    - *flutter_native_splash* - for creating and generating app splash screen
    - *flutter_launcher_icons* - for creating and generating launcher icons
    - *uuid* - for generating UUID for id fields in Firebase collections
    - *intl* - for applying date and number formats


### Product thinking
Maverick was born out of a challenge to design and build a user-centered fintech app using Flutter. The task was to create a functional mobile banking prototype for a chosen target audience, focusing on:
  - 📱 Mobile-first product design with strong UX.
  - 🛠 Modular, maintainable Flutter architecture with clear separation of concerns.
  - ⚡ Smooth state management, local storage, and routing.
  - 🤝 Real-world problem-solving for underserved markets, especially in Africa.

This wasn’t just a coding challenge — it was an exercise in product thinking, aligning technical execution with genuine user needs while balancing feasibility, scalability, and user experience.


## Developer instructions
---
**NOTE**: 
* To run this project, you **MUST** install Flutter SDK on your machine. Refer to [Flutter's documentation](https://docs.flutter.dev/get-started/install) and follow a step-by-step guide on how you can install Flutter SDK on your OS.

* Make sure you have installed Android Studio or a text editor of your choice - VS Code or XCode.

* Make sure your machine supports virtualization - required to run an emulator. If it doesn't, don't worry, you can install `scrcpy` on your machine or use Android Studio's `mirror device` feature.

**Scrcpy Installation guide** 
* [Install scrcpy on Windows](https://github.com/Genymobile/scrcpy/blob/master/doc/windows.md)
* [Install scrcpy on Linux](https://github.com/Genymobile/scrcpy/blob/master/doc/linux.md)
* [Install scrcpy on MacOS](https://github.com/Genymobile/scrcpy/blob/master/doc/macos.md)

---

#### Installation guide for developers

1. Git clone

Clone this repository by opening your terminal/CMD and change the current working directory to Desktop - use `cd Desktop` command.
```bash
    $ cd Desktop
    $ git clone https://github.com/morikeli/maverick-fintech.git
```

2. Open the cloned repository on your text editor and run this command:
```bash
    $ cd maverick-fintech  # or change dir in the terminal and run the `flutter run` command
    $ flutter run
```
3. Make sure you have a very strong internet connection so that the necessary gradle files can be downloaded. These files are necessary to build the project `apk` file.

---
**Keep in mind**:
* When building the application for the first time, it may take 10 - 15 minutes to finish the installation and build process.
* When running the application using the `flutter run` command, it may take atleast a minute to install the build files on a physical device.
---


## 🤝 Contributor expectations
Incase of a bug or you wish to make a contribution, create a new branch using the git command `git checkout -b <name of your branch>` and create a pull request. Wait for review.

You can also open an issue using the `Issues` tab. The reported issue will be reviewed and a solution may be provided.


## 🙏 Request
Don't forget to star the repo 🌟😉


## 🐞 Known issues 
1. Non-functional features

The features outlined below are non-functional:
- Some list tile and icons (e.g. icon button to add/update profile pic) in the profile screen are placeholder icon.
- Notifications icon.
- Forgot password functionality. It uses dummy data.
- Profile pictures are static.

2. Bugs
- Name of the recipient is shown for received transactions instead of the sender's name.





