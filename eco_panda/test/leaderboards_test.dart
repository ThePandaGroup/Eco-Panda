import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eco_panda/main.dart'; // Adjust this import to the location of your main app file.

void main() {
  testWidgets('Navigate to Leaderboards Page and Verify Content', (WidgetTester tester) async {
    // Assuming your main app widget is MyApp and it includes EPandaHomepage.
    await tester.pumpWidget(MyApp());

    // Now, find the "See All Leaderboards" button. This assumes the button is uniquely identified by its text.
    // Adjust the finder if your app structure requires it (e.g., using a Key).
    final seeAllLeaderboardsButtonFinder = find.widgetWithText(OutlinedButton, 'See All Leaderboards');
    expect(seeAllLeaderboardsButtonFinder, findsOneWidget);

    // Tap the "See All Leaderboards" button to navigate to the leaderboards page.
    await tester.tap(seeAllLeaderboardsButtonFinder);
    await tester.pumpAndSettle(); // Wait for the navigation to complete.

    // Verify the leaderboards page is displayed by checking for "Top 10 Users" and "Your Rank" texts.
    expect(find.text('Top 10 Users'), findsOneWidget, reason: 'The "Top 10 Users" text should be present on the leaderboards page.');
    expect(find.text('Your Rank'), findsOneWidget, reason: 'The "Your Rank" text should be present on the leaderboards page.');
  });
}
