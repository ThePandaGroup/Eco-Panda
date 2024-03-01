import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:eco_panda/firebase_options.dart';

void main() {
  group('DefaultFirebaseOptions', () {
    test('returns correct FirebaseOptions for web', () {
      if (kIsWeb) {
        expect(DefaultFirebaseOptions.currentPlatform, DefaultFirebaseOptions.web);
      }
    });

    test('returns correct FirebaseOptions for android', () {
      if (defaultTargetPlatform == TargetPlatform.android) {
        expect(DefaultFirebaseOptions.currentPlatform, DefaultFirebaseOptions.android);
      }
    });

    test('returns correct FirebaseOptions for iOS', () {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        expect(DefaultFirebaseOptions.currentPlatform, DefaultFirebaseOptions.ios);
      }
    });

    test('throws UnsupportedError for unsupported platforms', () {
      if (defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux) {
        expect(() => DefaultFirebaseOptions.currentPlatform, throwsUnsupportedError);
      }
    });

    test('web FirebaseOptions has correct values', () {
      FirebaseOptions options = DefaultFirebaseOptions.web;
      expect(options.apiKey, 'AIzaSyA9vACPwB1T18v9fPn0U8KHiDKmnR8PGHs');
      expect(options.appId, '1:62935483043:web:2d495325fccb8b4b5bb516');
      expect(options.messagingSenderId, '62935483043');
      expect(options.projectId, 'eco-panda-2bd29');
      expect(options.authDomain, 'eco-panda-2bd29.firebaseapp.com');
      expect(options.storageBucket, 'eco-panda-2bd29.appspot.com');
      expect(options.measurementId, 'G-G4N2WVP2NJ');
    });

    test('android FirebaseOptions has correct values', () {
      FirebaseOptions options = DefaultFirebaseOptions.android;
      expect(options.apiKey, 'AIzaSyB7RdGhkvRZV8HlO2ltXny4QRFh2j0Kd-w');
      expect(options.appId, '1:62935483043:android:d511e473e00c88c05bb516');
      expect(options.messagingSenderId, '62935483043');
      expect(options.projectId, 'eco-panda-2bd29');
      expect(options.storageBucket, 'eco-panda-2bd29.appspot.com');
    });

    test('ios FirebaseOptions has correct values', () {
      FirebaseOptions options = DefaultFirebaseOptions.ios;
      expect(options.apiKey, 'AIzaSyBQkD7Zx50iXiBoNiObkcbmsUXHDm9OH1g');
      expect(options.appId, '1:62935483043:ios:25cb483b84cc66025bb516');
      expect(options.messagingSenderId, '62935483043');
      expect(options.projectId, 'eco-panda-2bd29');
      expect(options.storageBucket, 'eco-panda-2bd29.appspot.com');
      expect(options.iosBundleId, 'com.example.ecoPanda');
    });
  });
}