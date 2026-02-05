# Mula App

## Mobile app screenshots
| Splash screen | Onboarding screen |
| ------------------------- | ------------------------- |
| <img width="480" height="854" alt="splash-screen" src="https://github.com/user-attachments/assets/cabb55a8-15de-4827-85cb-1f06fb66f637" /> | <img width="480" height="854" alt="onboarding-screen" src="https://github.com/user-attachments/assets/c01adc8b-7ac9-4c00-b8f7-58f0e8637c9d" /> |
| | |
| Login screen | Signup screen |
| <img width="480" height="854" alt="login-screen" src="https://github.com/user-attachments/assets/89dd4267-d26c-4960-91d6-53456d76e445" /> | <img width="480" height="854" alt="signup-screen" src="https://github.com/user-attachments/assets/0c89ac01-f127-4f59-8db2-798323c6205b" /> |
| | |
| Home screen (home tab) | Send Money screen |
| <img width="480" height="854" alt="home-screen" src="https://github.com/user-attachments/assets/aa39a7e7-c688-44c6-8461-7dac602f983a" /> | <img width="480" height="854" alt="send-money" src="https://github.com/user-attachments/assets/bae86edb-ffef-4b29-9d16-f331f51a4768" /> |
| | |
| Transaction history screen | Profile screen |
| <img width="480" height="854" alt="recent-transactions" src="https://github.com/user-attachments/assets/cf9d790c-e970-4079-846c-8394944463dc" /> | <img width="480" height="854" alt="profile_screen" src="https://github.com/user-attachments/assets/4f83bffb-05f3-44a1-9835-fc1cbf6dde7d" /> |
| | |
| | |

## Overview
Mula is a slang word for money. This is a modern, cross-platform fintech application designed to make money management fast, secure, and effortless. Built with Flutter 💙 and Firebase 🔥, Mula delivers a smooth, feature-rich experience on both Android and iOS.

Whether you’re sending money to friends, tracking your spending, or managing your digital wallet, Mula keeps everything at your fingertips with an intuitive design and rock-solid security.

### Target users
Mula is designed for individuals and groups in Africa and beyond who need fast, secure, and flexible ways to move money. Key user segments include:
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
    - *sqlflite* - for creating and managing SQLite db
    - *flutter_native_splash* - for creating and generating app splash screen
    - *flutter_launcher_icons* - for creating and generating launcher icons
    - *uuid* - for generating UUID for id fields in Firebase collections
    - *intl* - for applying date and number formats


### Product thinking
Mula was born out of a challenge to design and build a user-centered fintech app using Flutter. The task was to create a functional mobile banking prototype for a chosen target audience, focusing on:
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
    cd Desktop
    git clone https://github.com/morikeli/mula.git
```

2. Open the cloned repository on your text editor and run this command:
```bash
    cd mula  # or change dir in the terminal and run the `flutter run` command
    flutter run
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
