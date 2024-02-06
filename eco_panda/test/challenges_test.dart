import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eco_panda/echallenges.dart'; // Adjust this import based on your file structure

void main() {
  group('EChallenges Widget Tests', () {
    testWidgets('EChallenges displays challenge cards correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: EChallenges()));

      // Verify that all challenge cards are displayed
      expect(find.byType(ChallengeCard), findsNWidgets(3)); // Assuming you have 3 challenges

      // Verify specific challenge details
      expect(find.text('Daily Challenge'), findsOneWidget);
      expect(find.text('First Eco route of the day'), findsOneWidget);
      expect(find.text('New User Challenge'), findsOneWidget);
      // Add more assertions as needed
    });

    testWidgets('Challenge progress is displayed correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: EChallenges()));

      // Check for specific progress indicators
      expect(find.text('0/1'), findsWidgets); // Checks if progress text is displayed as expected
      // You can add more specific checks for each challenge based on its progress
    });
  });
}
