
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eco_panda/main.dart';
import 'package:eco_panda/echallenges.dart';

void main() {
  testWidgets('Navigate to Challenges Page and Verify Content', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    await tester.tap(find.byIcon(Icons.emoji_events));
    await tester.pumpAndSettle();


    expect(find.byType(EChallenges), findsOneWidget);


    expect(find.text('Daily Challenge'), findsOneWidget);
    expect(find.text('First Eco route of the day'), findsOneWidget);
    expect(find.byType(ChallengeProgressIndicator), findsWidgets);

    expect(find.text('New User Challenge'), findsOneWidget);
    expect(find.text('Plan your first route'), findsOneWidget);
    expect(find.byType(ChallengeProgressIndicator), findsWidgets);

    expect(find.text('Weekly Challenge'), findsOneWidget);
    expect(find.text('I planned 10 rountes in the app !'), findsOneWidget);
    expect(find.byType(ChallengeProgressIndicator), findsWidgets);


    expect(find.text('0/10'), findsOneWidget); // Weekly Challenge progress
  });
}
