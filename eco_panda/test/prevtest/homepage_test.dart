import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eco_panda/ehomepage.dart';

void main() {
  group('EPandaHomepage Tests', () {
    testWidgets('Displays welcome message and eco score', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: EPandaHomepage()));

      expect(find.text('Welcome back, John!'), findsOneWidget);
      expect(find.text('Your Eco Score: 85'), findsOneWidget);
    });

    testWidgets('Navigate to Carbon History page', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: EPandaHomepage()));

      // View Your Carbon Footprints History button
      await tester.tap(find.widgetWithText(OutlinedButton, 'View Your Carbon Footprints History'));
      await tester.pumpAndSettle();

    });

    testWidgets('Displays transport mode options correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: EPandaHomepage()));

      // Verify the transport mode buttons are displayed
      final transportModes = ['Walk', 'Bicycle', 'Transit', 'Drive'];
      for (var mode in transportModes) {
        expect(find.text(mode), findsOneWidget);
      }
    });

    testWidgets('Navigate to Leaderboards page', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: EPandaHomepage()));

      // See All Leaderboards button
      await tester.tap(find.widgetWithText(OutlinedButton, 'See All Leaderboards'));
      await tester.pumpAndSettle();

    });
  });
}
