import 'package:eco_panda/firebase_options.dart';
import 'package:eco_panda/floor_model/app_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'auth_gate.dart';
import 'sync_manager.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final AppDatabase localDb = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final syncManager = SyncManager(localDb);

  runApp(
    MultiProvider(
      providers: [
        Provider<AppDatabase>(create: (_) => localDb),
        Provider<SyncManager>(create: (_) => syncManager),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco-Panda',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AuthGate(),
    );
  }
}