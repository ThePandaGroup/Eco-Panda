import 'package:eco_panda/page_template.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:eco_panda/main.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

class MockFirebaseApp extends Mock implements FirebaseApp {}

void main() {
  setUpAll(() async {
  });

  testWidgets('Successful sign-in navigates to EPageTemplate', (WidgetTester tester) async {
    // Initialize your mocks
    final MockFirebaseAuth mockAuth = MockFirebaseAuth();
    final MockUser mockUser = MockUser();

    // Setup mock behavior
    when(mockAuth.currentUser).thenReturn(mockUser);
    when(mockUser.email).thenReturn('test@example.com');

    // Build our app and trigger a frame with the mockProvider
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            Provider<FirebaseAuth>.value(value: mockAuth),
            // Add other providers if necessary
          ],
          child: const MyApp(),
        ),
      ),
    );

    // Optionally, if you want to simulate sign-in, do it here and then pumpAndSettle
    // await tester.pumpAndSettle();

    // Check if EPageTemplate is displayed after sign-in
    expect(find.byType(EPageTemplate), findsOneWidget);
  });
}

// void main() {
//   final mockAppDatabase = setupMocks();
//
//   testWidgets('SyncManager Test', (WidgetTester tester) async {
//     await tester.pumpWidget(
//       MultiProvider(
//         providers: [
//           Provider<AppDatabase>(create: (_) => mockAppDatabase),
//           Provider<SyncManager>(create: (_) => SyncManager(mockAppDatabase)),
//         ],
//         child: const MyApp(),
//       ),
//     );
//
//     // Add your widget testing logic here
//   });

// void main() {
//   setupFirebaseAuthMocks();
//
//   group('Auth and Navigation Test', () {
//     setUpAll(() async {
//       await Firebase.initializeApp();
//     });
//
//     testWidgets('Navigate to HomePage after SignIn', (WidgetTester tester) async {
//       final mockAuth = MockFirebaseAuth();
//       when(mockAuth.authStateChanges()).thenAnswer(
//             (_) => Stream.fromIterable([MockUser()]),
//       );
//
//       await tester.pumpWidget(MultiProvider(
//         providers: [
//           Provider<FirebaseAuth>.value(value: mockAuth),
//         ],
//         child: MaterialApp(
//           home: AuthGate(),
//         ),
//       ));
//
//       await tester.pumpAndSettle();
//
//       expect(find.byType(EPageTemplate), findsOneWidget);
//     });
//   });
// }