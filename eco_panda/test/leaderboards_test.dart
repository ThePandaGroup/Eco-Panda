
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
    // debugDumpApp();
    expect(find.text('Top 10 Users'), findsOneWidget);


  //
    await tester.pump();

  //   final userListFinder = find.byType(ListTile);
  //   expect(userListFinder, findsNWidgets(9));
  //
  //   // Verify "Your Rank" section exists and displays user rank
    expect(find.textContaining('Your Rank'), findsOneWidget);
  //
  //
  //   expect(find.text('User 19'), findsOneWidget);
  //   expect(find.text('380 pts'), findsWidgets);
  //
  //   final iconFinder = find.byIcon(Icons.emoji_events);
  //
  //   // Find all icons with the specified icon
  //   final icons = tester.widgetList(iconFinder).toList();
  //
  //   // Verify that there are exactly three icons with the specified icon
  //   expect(icons, hasLength(3));
  //
  //   // Verify the color of each icon individually
  //   expect((icons[0] as Icon).color, Colors.amber);
  //   expect((icons[1] as Icon).color, Colors.grey);
  //   expect((icons[2] as Icon).color, Colors.brown);
  });
}
