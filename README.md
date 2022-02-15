# Flutter firebase auth template

This project is a template auth for Flutter application using Firebase.

## Installation
To use this project, clone the repo and update some files with your settings :

  -  Android
    
    Update `applicationId` with your project name inside `android/app/build.gradle` .
  
  -  Ios 
   
   Update `PRODUCT_BUNDLE_IDENTIFIER` with your project name inside `ios\Runner.xcodeproj\project.pbxproj` .
   
    
 -  Web settings

    Update your file`Index.html`

    ```
     <script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js"></script>
     
     // at the top of your script
      var firebaseConfig = {
        apiKey: "...",
        authDomain: "[YOUR_PROJECT].firebaseapp.com",
        databaseURL: "https://[YOUR_PROJECT].firebaseio.com",
        projectId: "[YOUR_PROJECT]",
        storageBucket: "[YOUR_PROJECT].appspot.com",
        messagingSenderId: "...",
        appId: "1:...:web:...",
        measurementId: "G-...",
      };

      // Initialize Firebase
      firebase.initializeApp(firebaseConfig);
    ```

### Packages

- firebase_auth (https://pub.dev/packages/firebase_auth)
- firebase_core (https://pub.dev/packages/firebase_core)
- provider (https://pub.dev/packages/provider)

