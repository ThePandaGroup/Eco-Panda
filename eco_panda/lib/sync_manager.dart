import 'package:cloud_firestore/cloud_firestore.dart';
import 'floor_model/app_database.dart';

class SyncManager {

  final AppDatabase localDatabase;
  final FirebaseFirestore firebaseFirestore;

  SyncManager(this.localDatabase, this.firebaseFirestore);

  Future<void> syncAll() async {
    await syncUsers();
    await syncChallenges();
    await syncHistory();
    await syncLeaderboard();
    await syncSettings();
  }

  Future<void> syncUsers() async {

  }

  Future<void> syncChallenges() async {

  }

  Future<void> syncHistory() async {

  }

  Future<void> syncLeaderboard() async {

  }

  Future<void> syncSettings() async {

  }
}