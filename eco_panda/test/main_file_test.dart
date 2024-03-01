import 'package:eco_panda/page_template.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eco_panda/main.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('MyApp widget is rendered', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byType(MyApp), findsOneWidget);
  });

  testWidgets('EPageTemplate widget is rendered as home', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byType(EPageTemplate), findsOneWidget);
  });

  testWidgets('MaterialApp widget has correct title', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final MaterialApp app = tester.widget(find.byType(MaterialApp));
    expect(app.title, 'Your App Title');
  });

  testWidgets('MaterialApp widget has correct theme', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final MaterialApp app = tester.widget(find.byType(MaterialApp));
    expect(app.theme, ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ));
  });
}