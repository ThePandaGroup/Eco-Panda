import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eco_panda/main.dart';
import 'package:eco_panda/ecarbon_history.dart';

void main() {
  // Test to navigate from the homepage to the Carbon History page
  testWidgets('Navigate from HomePage to CarbonHistory', (WidgetTester tester) async {

    await tester.pumpWidget(MyApp());

    final Finder carbonHistoryButton = find.widgetWithText(OutlinedButton, 'View Your Carbon Footprints History');
    expect(carbonHistoryButton, findsOneWidget);

    await tester.tap(carbonHistoryButton);
    await tester.pumpAndSettle();


    expect(find.byType(ECarbonHistory), findsOneWidget);
  });

  // Extensive tests on the Carbon History functionality
  testWidgets('Displays current month\'s carbon footprint', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ECarbonHistory()));

    // Verify the display of current month's carbon footprint
    expect(find.text('Current Month\'s Carbon Footprint'), findsOneWidget);
    expect(find.text('2.5 tons'), findsOneWidget); // Adjust based on expected value
  });

  testWidgets('Displays historical data chart', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ECarbonHistory()));

    // Verify the chart is displayed
    expect(find.byType(LineChart), findsOneWidget);
  });

  testWidgets('Displays list of past carbon footprints', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ECarbonHistory()));

    // Verify the list of past footprints is displayed
    final List<double> _pastFootprints = [2.8, 3.2, 2.9, 3.1, 3.0]; // Your mock data
    for (final footprint in _pastFootprints) {
      expect(find.text('$footprint tons'), findsWidgets);
    }
  });
}
