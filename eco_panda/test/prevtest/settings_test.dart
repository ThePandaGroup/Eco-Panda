
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eco_panda/page_template.dart';

void main() {
  testWidgets('Navigate to Settings Page and Verify Content', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: EPageTemplate()));

    // Tap the bottom navigation bar item for Profile
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    // Tap on the "Edit Profile" button
    await tester.tap(find.text('Edit Profile'));
    await tester.pumpAndSettle();

    // Verify the presence of specific components on the Settings page.
    expect(find.text('Profile Setting'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Permission Access'), findsOneWidget);


    // Verify the profile name setting section.
    expect(find.text('Current Name: John Hougland'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);


    // Verify the notification settings section.
    expect(find.text('Pop-up Notification'), findsOneWidget);
    expect(find.text('Email Notification'), findsOneWidget);


    // Verify the access privilege settings section.
    expect(find.text('Camera'), findsOneWidget);
    expect(find.text('GPS'), findsOneWidget);
    expect(find.text('Contacts'), findsOneWidget);
    expect(find.text('Other Features'), findsOneWidget);

  });
}


