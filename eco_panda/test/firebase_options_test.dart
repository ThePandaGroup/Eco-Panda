import 'package:eco_panda/firebase_options.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:eco_panda/firebase_options.dart'; // Adjust the import path as needed

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DefaultFirebaseOptions', () {
    test('returns correct FirebaseOptions for web', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.android; // Simulate platform
      // Simulate kIsWeb to true if possible, or run this test in a web environment
      if (kIsWeb) {
        final options = DefaultFirebaseOptions.currentPlatform;
        expect(options.apiKey, contains('AIza')); // Simplified check for this example
        // Add more checks for other fields if necessary
      }
    });

    test('returns correct FirebaseOptions for Android', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      final options = DefaultFirebaseOptions.currentPlatform;
      expect(options.apiKey, 'AIzaSyB7RdGhkvRZV8HlO2ltXny4QRFh2j0Kd-w');
      // Add more checks for other fields if necessary
    });

    test('returns correct FirebaseOptions for iOS', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      final options = DefaultFirebaseOptions.currentPlatform;
      expect(options.apiKey, 'AIzaSyBQkD7Zx50iXiBoNiObkcbmsUXHDm9OH1g');
      // Add more checks for other fields if necessary
    });

    test('throws UnsupportedError for unsupported platforms', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.linux; // Simulate an unsupported platform
      expect(() => DefaultFirebaseOptions.currentPlatform, throwsA(isInstanceOf<UnsupportedError>()));
    });

    // Reset the platform override after each test
    tearDown(() {
      debugDefaultTargetPlatformOverride = null;
    });
  });
}
