// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBRArzIq8wfihRXSzexQ4_JI0ngf5HL3lM',
    appId: '1:585150937230:web:94f1c3fca2fc6571d571df',
    messagingSenderId: '585150937230',
    projectId: 'extracurricular-project',
    authDomain: 'extracurricular-project.firebaseapp.com',
    storageBucket: 'extracurricular-project.appspot.com',
    measurementId: 'G-MN4WRY7L0T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCFqLlDl6rWDW-C8LZFPG_JzB08uwHn-Qo',
    appId: '1:585150937230:android:575016834f5a30ddd571df',
    messagingSenderId: '585150937230',
    projectId: 'extracurricular-project',
    storageBucket: 'extracurricular-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA0LTN8-fkfUs8WHYh1ZzxEwq79JbETi2o',
    appId: '1:585150937230:ios:c6fb876b43a4a610d571df',
    messagingSenderId: '585150937230',
    projectId: 'extracurricular-project',
    storageBucket: 'extracurricular-project.appspot.com',
    iosBundleId: 'com.example.selfProject',
  );
}
