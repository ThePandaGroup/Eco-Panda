import 'package:flutter/material.dart';
import './page_template.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        // Define your app's theme here
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const EPageTemplate(),
    );
  }
}

// '/': (context) => const EPandaHomepage(), // Homepage - index 0
// '/route-planning': (context) => const EMapNav(), // Route Planning Page
// '/profile': (context) => const EProfile(), // Profile Page - index 2
// '/friends': (context) => const EFriends(), // Friends Page -
// '/settings': (context) => const ESettings(), // Settings Page -
// '/challenges': (context) => const EChallenges(), // Challenges Page - index 1
// '/leaderboards': (context) => const ELeaderboards(), // Leaderboards Page -
// '/carbon-history': (context) => const ECarbonHistory(), // Carbon Footprint History -