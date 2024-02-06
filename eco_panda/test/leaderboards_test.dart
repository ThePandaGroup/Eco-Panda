// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:eco_panda/main.dart';
//
// void main() {
//   testWidgets('Navigate to Leaderboards Page and Verify Content', (WidgetTester tester) async {
//     await tester.pumpWidget(MyApp());
//
//     final seeAllLeaderboardsButtonFinder = find.widgetWithText(OutlinedButton, 'See All Leaderboards');
//     expect(seeAllLeaderboardsButtonFinder, findsOneWidget);
//
//     await tester.tap(seeAllLeaderboardsButtonFinder);
//     await tester.pumpAndSettle(); // Wait for the navigation to complete.
//
//     // Verify "Top 10 Users" section exists
//     expect(find.text('Top 10 Users'), findsOneWidget);
//
//     // Verify "Your Rank" section exists and displays user rank
//     expect(find.textContaining('Your Rank'), findsOneWidget); // Use textContaining for partial matches if needed
//
//     // Optionally, check for the presence of specific user names or ranks if the data is predictable
//     expect(find.text('User 1'), findsOneWidget);
//     expect(find.text('100 pts'), findsWidgets);
//
//     final iconFinder = find.byIcon(Icons.emoji_events);
//
//     // Find all icons with the specified icon
//     final icons = tester.widgetList(iconFinder).toList(); // Convert Iterable to List
//
//     // Verify that there are exactly three icons with the specified icon
//     expect(icons, hasLength(3));
//
//     // Verify the color of each icon individually
//     expect((icons[0] as Icon).color, Colors.amber);
//     expect((icons[1] as Icon).color, Colors.grey);
//     expect((icons[2] as Icon).color, Colors.brown);
//   });
// }


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

    // Verify "Top 10 Users" section exists
    expect(find.text('Top 10 Users'), findsOneWidget);

    await tester.pump();

    final userListFinder = find.byType(ListTile);
    expect(userListFinder, findsNWidgets(9));

    // Verify "Your Rank" section exists and displays user rank
    expect(find.textContaining('Your Rank'), findsOneWidget);


    expect(find.text('User 1'), findsOneWidget);
    expect(find.text('100 pts'), findsWidgets);

    final iconFinder = find.byIcon(Icons.emoji_events);

    // Find all icons with the specified icon
    final icons = tester.widgetList(iconFinder).toList();

    // Verify that there are exactly three icons with the specified icon
    expect(icons, hasLength(3));

    // Verify the color of each icon individually
    expect((icons[0] as Icon).color, Colors.amber);
    expect((icons[1] as Icon).color, Colors.grey);
    expect((icons[2] as Icon).color, Colors.brown);
  });
}