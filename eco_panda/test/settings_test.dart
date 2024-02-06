import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eco_panda/page_template.dart';

void main() {
  testWidgets('Navigate to Settings page', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: EPageTemplate()));

    // Tap the bottom navigation bar item for Profile
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    // Tap on the "Edit Profile" button
    await tester.tap(find.text('Edit Profile'));
    await tester.pumpAndSettle();

    // Verify settings page is displayed by checking for specific widgets
    expect(find.text('Profile Setting'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Permission Access'), findsOneWidget);

    expect(find.byType(Switch), findsWidgets);
  });
}


// Test