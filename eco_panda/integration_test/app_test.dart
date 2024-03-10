import 'package:eco_panda/firebase_options.dart';
import 'package:eco_panda/floor_model/app_database.dart';
import 'package:eco_panda/floor_model/app_entity.dart';
import 'package:eco_panda/sync_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:eco_panda/main.dart';
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  Person? currentUser;

  Future<void> signIn(WidgetTester tester) async {
    final Finder emailField = find.widgetWithText(TextField, 'Email');
    await tester.enterText(emailField, 'test@gmail.com');
    await tester.pumpAndSettle();

    final Finder passwordField = find.widgetWithText(TextField, 'Password');
    await tester.enterText(passwordField, 'test123');
    await tester.pumpAndSettle();

    final Finder signInButton = find.widgetWithText(OutlinedButton, 'Sign in');

    await tester.tap(signInButton);
    await tester.pumpAndSettle();
  }

  Future<void> initialPage(WidgetTester tester) async {

    expect(find.text('Welcome back, user_63396'), findsOneWidget);
    expect(find.text('Your Eco Score: 0'), findsOneWidget);
    await tester.pumpAndSettle();
  }

  group('Sign In Test', () {
    testWidgets('Sign in with email and password', (tester) async {
      final AppDatabase localDb = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final syncManager = SyncManager(localDb);
      await tester.pumpWidget(MultiProvider(
        providers: [
          Provider<AppDatabase>(create: (_) => localDb),
          Provider<SyncManager>(create: (_) => syncManager),
        ],
        child: const MyApp(),
      ));
      await tester.pumpAndSettle();

      await signIn(tester);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();


    });
  });
}
