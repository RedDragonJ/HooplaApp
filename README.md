# HooplaApp

### Steps to Run the App

#### 1. Clone the repository into your computer
```
git clone https://github.com/RedDragonJ/HooplaApp.git

or

git clone git@github.com:RedDragonJ/HooplaApp.git
```

#### 2. Navigate to the folder and open in Xcode
- Open FetchRecipe.xcodeproj in Xcode.
- Ensure you are using the latest version of Xcode compatible with iOS 17 or above.

#### 3. Build and Run
- Select the desired simulator or connected device.
- Press `Cmd + R` or click `Run` in Xcode to build and launch the app.

#### 4. Testing
- Run unit tests by selecting Product > Test in Xcode or pressing `Cmd + U`.

---

### Focus Areas
- Disk Image Caching: Custom disk-based caching minimizes memory usage, ensuring efficient performance while reserving memory for video playback.
- Error Handling: Centralized error handling with clear user feedback for network and decoding issues improves usability.
- Test Coverage: Unit tests for network calls, image caching, and state management ensure code reliability and prevent regressions.
- Clean Architecture: Modular patterns improve maintainability and scalability for future feature extensions.
- Dark/Light Mode Support: Consistent UI design ensures a polished user experience across themes.

---

### Trade-offs and Decisions
- Chose custom image caching over third-party libraries for better control, but it required additional development time.
- Centralized error handling improves code simplicity but limits detailed user feedback for specific errors.

---

### External Code and Dependencies
- No external third-party libraries are included.
