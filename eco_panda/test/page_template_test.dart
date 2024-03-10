import 'package:eco_panda/auth_gate.dart';
import 'package:eco_panda/floor_model/app_database.dart';
import 'package:eco_panda/page_template.dart';
import 'package:eco_panda/sync_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:eco_panda/main.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

void main() {
  group('Firebase Auth with email and password', () {
    test('Mock sign-in returns a user with an email', () async {
      final mockAuth = MockFirebaseAuth(mockUser: MockUser(email: 'test@example.com'));

      final result = await mockAuth.signInWithEmailAndPassword(email: 'test@example.com', password: 'password');
      final user = result.user;

      expect(user!.email, equals('test@example.com'));
    });
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