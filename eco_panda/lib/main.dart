import 'package:eco_panda/firebase_options.dart';
import 'package:eco_panda/floor_model/app_database.dart';
import 'package:flutter/material.dart';
import './page_template.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final AppDatabase localDb = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  runApp(
    Provider<AppDatabase>(
      create: (_) => localDb,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
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