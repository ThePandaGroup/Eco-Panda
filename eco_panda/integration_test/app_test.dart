import 'package:eco_panda/firebase_options.dart';
import 'package:eco_panda/floor_model/app_database.dart';
import 'package:eco_panda/sync_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  String username = 'user_63396';

  Future<void> signIn(WidgetTester tester) async {
    final Finder emailField = find.widgetWithText(TextField, 'Email');
    await tester.enterText(emailField, 'test@gmail.com');
    await tester.pumpAndSettle();

    final Finder passwordField = find.widgetWithText(TextField, 'Password');
    await tester.enterText(passwordField, 'test123');
    await tester.pumpAndSettle();

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  }

  Future<void> initialPage(WidgetTester tester) async {
    expect(find.text('Welcome back, $username!'), findsOneWidget);
  }

  Future<void> carbonHistoryPage(WidgetTester tester) async {
    await tester.tap(find.text('View Your Carbon Footprints History'));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
  }

  Future<void> navigationPage(WidgetTester tester) async {
    await tester.tap(find.text('Walk'));
    await tester.pumpAndSettle();

    await tester.tap(find.text(' Plan route'));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
  }

  Future<void> leaderboardPage(WidgetTester tester) async {
    await tester.tap(find.text('See All Leaderboards'));
    await tester.pumpAndSettle();

    Finder refreshIconFinder = find.byIcon(Icons.refresh);
    await tester.tap(refreshIconFinder);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
  }

  Future<void> challengesPage(WidgetTester tester) async {
    await tester.tap(find.byIcon(Icons.emoji_events));
    await tester.pumpAndSettle();
  }

  Future<void> changeAvatar(WidgetTester tester) async {
    await tester.tap(find.byType(CircleAvatar));
    await tester.pumpAndSettle();

    expect(find.text('Choose Avatar'), findsOneWidget);
    await tester.tap(find.byType(CircleAvatar).at(1));
    await tester.pumpAndSettle();
  }

  Future<void> changeUsername(WidgetTester tester) async {
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    expect(find.text('Change Username'), findsOneWidget);
    await tester.enterText(find.byType(TextField), username);

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
  }

  Future<void> signOut(WidgetTester tester) async {
    await tester.tap(find.text('Sign Out'));
    await tester.pumpAndSettle();

    expect(find.text('Are you sure you want to sign out?'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Sign Out'));
    await tester.pumpAndSettle();
  }

  Future<void> profilePage(WidgetTester tester) async {
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    await changeUsername(tester);
    await Future.delayed(const Duration(seconds: 2));

    await changeAvatar(tester);
    await signOut(tester);
  }

  group('Application flow', () {
    testWidgets('Overall integration test', (tester) async {
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

      await tester.pumpAndSettle();

      await initialPage(tester);
      await carbonHistoryPage(tester);
      await navigationPage(tester);
      await leaderboardPage(tester);

      await challengesPage(tester);
      await profilePage(tester);
    });
  });
}
