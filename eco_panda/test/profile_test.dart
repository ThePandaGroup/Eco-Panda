import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eco_panda/page_template.dart';
import 'package:eco_panda/eprofile.dart';

void main() {
  testWidgets('Profile Page Test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(MaterialApp(home: EPageTemplate()));

    // Tap the bottom navigation bar item for Profile
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    // Verify that Profile page is shown
    expect(find.byType(EProfile), findsOneWidget);

    // Verify the existence of profile-related content
    expect(find.text('John Hougland'), findsOneWidget);
    expect(find.text('Your Eco Score: 85'), findsOneWidget);

    // Verify the Edit Profile button is present
    expect(find.text('Edit Profile'), findsOneWidget);

    // Tap on the Edit Profile button if you want to test navigation from it
    await tester.tap(find.text('Edit Profile'));
    await tester.pumpAndSettle();
  });
}
// test