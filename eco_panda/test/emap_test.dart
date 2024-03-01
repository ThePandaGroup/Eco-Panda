import 'package:eco_panda/ehomepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eco_panda/main.dart'; // Adjust this import based on your app's structure
import 'package:eco_panda/emap_nav.dart';

void main() {
  testWidgets('Navigate from Home to Seattle University', (WidgetTester tester) async {
    // Pump the widget
    await tester.pumpWidget(MyApp());

    // Correcting the finder for the "Plan route" button. Considering the leading space and presence of an icon.
    final planRouteFinder = find.descendant(
      of: find.byType(OutlinedButton),
      matching: find.text(' Plan route'),
    );
    expect(planRouteFinder, findsOneWidget);

    await tester.tap(planRouteFinder.first);
    await tester.pumpAndSettle(); // Wait for any animations or navigations to complete.





    // Simulate entering "Seattle University" into a search field
    final Finder searchField = find.byType(TextField);
    await tester.enterText(searchField, 'Seattle University');
    await tester.pumpAndSettle(); // Update the UI

    // Assuming the button is initially disabled
    final Finder searchButton = find.widgetWithText(ElevatedButton, 'Navigate');
    // Verify the button is now enabled after entering text
    expect(tester.widget<ElevatedButton>(searchButton).enabled, isTrue);

  });

  testWidgets('Test dropdown selection', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: EMapNav()));

    // Find the DropdownButton widget
    final Finder dropdownButtonFinder = find.byType(DropdownButton<String>);

    // Tap on the dropdown button to open the dropdown menu
    await tester.tap(dropdownButtonFinder);
    await tester.pumpAndSettle();

    // Find the menu item for the first mode and tap on it
    final Finder firstModeFinder = find.byWidgetPredicate(
          (Widget widget) => widget is DropdownMenuItem<String>,
    ).first;
    await tester.tap(firstModeFinder);
    await tester.pumpAndSettle();

    // Verify that the DropdownButton now displays the first mode
    final dropdownButton = tester.widget<DropdownButton<String>>(dropdownButtonFinder);
    expect(dropdownButton.value, equals('transit')); // Assuming 'transit' is the first mode
  });




}

