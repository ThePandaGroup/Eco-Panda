import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eco_panda/main.dart'; // Update this with the path to your app's main file
import 'package:eco_panda/ecarbon_history.dart'; // Update this with the path to your Carbon History page

void main() {
  // Test to navigate from the homepage to the Carbon History page
  testWidgets('Navigate from HomePage to CarbonHistory', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp()); // Ensure this is your app's root widget.

    // Find the button by looking for its child text.
    final Finder carbonHistoryButton = find.widgetWithText(OutlinedButton, 'View Your Carbon Footprints History');
    expect(carbonHistoryButton, findsOneWidget); // Verify that exactly one button is found.

    // Tap the found button.
    await tester.tap(carbonHistoryButton);
    await tester.pumpAndSettle(); // Wait for any navigation animations to complete.

    // Verify that the CarbonHistory page is displayed.
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
