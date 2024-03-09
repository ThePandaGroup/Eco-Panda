import 'package:eco_panda/floor_model/app_database.dart';
import 'package:eco_panda/sync_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:eco_panda/main.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_core/firebase_core.dart';
import 'mock_setup.dart';

void main() {
  final mockAppDatabase = setupMocks();

  testWidgets('SyncManager Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<AppDatabase>(create: (_) => mockAppDatabase),
          Provider<SyncManager>(create: (_) => SyncManager(mockAppDatabase)),
        ],
        child: const MyApp(),
      ),
    );

    // Add your widget testing logic here
  });
}
