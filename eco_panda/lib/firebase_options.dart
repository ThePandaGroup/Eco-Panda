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
    apiKey: 'AIzaSyA9vACPwB1T18v9fPn0U8KHiDKmnR8PGHs',
    appId: '1:62935483043:web:2d495325fccb8b4b5bb516',
    messagingSenderId: '62935483043',
    projectId: 'eco-panda-2bd29',
    authDomain: 'eco-panda-2bd29.firebaseapp.com',
    storageBucket: 'eco-panda-2bd29.appspot.com',
    measurementId: 'G-G4N2WVP2NJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7RdGhkvRZV8HlO2ltXny4QRFh2j0Kd-w',
    appId: '1:62935483043:android:d511e473e00c88c05bb516',
    messagingSenderId: '62935483043',
    projectId: 'eco-panda-2bd29',
    storageBucket: 'eco-panda-2bd29.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBQkD7Zx50iXiBoNiObkcbmsUXHDm9OH1g',
    appId: '1:62935483043:ios:25cb483b84cc66025bb516',
    messagingSenderId: '62935483043',
    projectId: 'eco-panda-2bd29',
    storageBucket: 'eco-panda-2bd29.appspot.com',
    iosBundleId: 'com.example.ecoPanda',
  );
}