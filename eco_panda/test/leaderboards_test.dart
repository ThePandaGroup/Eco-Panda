
import 'package:eco_panda/eleaderboards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Leaderboards Page Displays Mock Data', (WidgetTester tester) async {
    // Create the widget by injecting the MockLeaderboardService
    await tester.pumpWidget(MaterialApp(
      home: ELeaderboards(
        leaderboardService: MockLeaderboardService(),
      ),
    ));

    // Initially, show a loading indicator
    expect(find.byType(CircularProgressIndicator), findsWidgets);

    // Wait for the FutureBuilder to finish
    await tester.pumpAndSettle();

    // Verify the mock data is displayed
    expect(find.text('Mock User 1'), findsOneWidget);
    expect(find.text('90 pts'), findsWidgets); // Example assertion for points

    // Verify "Your Rank" displays correctly
    expect(find.text('You'), findsOneWidget);
    expect(find.text('0 pts'), findsOneWidget);
  });
}