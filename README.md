# firebase_auth

플루터 파이어베이스 연동

## 작업순서

```bash
flutter create flutter_firebase_auth
git init

flutter pub add cloud_firestore
flutter pub add equatable
flutter pub add firebase_auth
flutter pub add firebase_core
flutter pub add provider
flutter pub add validators
```

## 파이어베이스설정

android/app/build.gradle

```ini
applicationId "com.fnhero.firebase_auth"
```

appNickName "android-flutter-firebase-auth-fnhero"

android/app/local.properties

```ini
flutter.minSdkVersion=21
flutter.targetSdkVersion=30
flutter.compileSdkVersion=30
```

```ini
minSdkVersion localProperties.getProperty('flutter.minSdkVersion')
targetSdkVersion localProperties.getProperty('flutter.targetSdkVersion')
```

/android/app/gradle/build.gradle

```ini
classpath 'com.google.gms:google-services:4.3.10'
```

/android/app/build.grale
> [https://firebase.google.com/docs/android/setup#available-libraries]

```ini
apply plugin: 'com.google.gms.google-services'
implementation platform('com.google.firebase:firebase-bom:29.1.0')
implementation 'com.google.firebase:firebase-analytics-ktx'
implementation 'com.google.firebase:firebase-auth-ktx'
implementation 'com.google.firebase:firebase-firestore-ktx'
```

## 제외

/android/app/google-services.json
