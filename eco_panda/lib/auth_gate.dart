import 'package:eco_panda/page_template.dart';
import 'package:eco_panda/sync_manager.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<void> _syncUserData(BuildContext context) async {
    final syncManager = Provider.of<SyncManager>(context, listen: false);
    await syncManager.syncAll();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder(
            future: _syncUserData(context),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              return const EPageTemplate();
            },
          );
        } else {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Container(
                color: Color(0xFFF5FBE5),
                child: Center(
                  child: Image.asset('assets/ecopanda_nobg.png'),
                ),
              );
            },
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
            sideBuilder: (context, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/ecopanda_nobg.png'),
                ),
              );
            },
          );
        }
      },
    );
  }
}