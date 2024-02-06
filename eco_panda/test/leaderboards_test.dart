import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eco_panda/main.dart';

void main() {
  testWidgets('Navigate to Leaderboards Page and Verify Content', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final seeAllLeaderboardsButtonFinder = find.widgetWithText(OutlinedButton, 'See All Leaderboards');
    expect(seeAllLeaderboardsButtonFinder, findsOneWidget);

    await tester.tap(seeAllLeaderboardsButtonFinder);
    await tester.pumpAndSettle(); // Wait for the navigation to complete.

    expect(find.text('Top 10 Users'), findsOneWidget, reason: 'The "Top 10 Users" text should be present on the leaderboards page.');
    expect(find.text('Your Rank'), findsOneWidget, reason: 'The "Your Rank" text should be present on the leaderboards page.');
  });
}
