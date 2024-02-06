import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eco_panda/main.dart';
import 'package:eco_panda/echallenges.dart';
void main() {
  testWidgets('Navigate to Challenges Page and Verify Content', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    await tester.tap(find.byIcon(Icons.emoji_events));
    await tester.pumpAndSettle(); // Wait for the page transition.

    // Verify the Challenges page is displayed.
    expect(find.byType(EChallenges), findsOneWidget);


    //  checking for a specific challenge's presence.
    expect(find.text('Daily Challenge'), findsWidgets);
    expect(find.text('First Eco route of the day'), findsWidgets);

  });
}
