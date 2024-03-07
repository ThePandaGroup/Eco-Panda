import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:eco_panda/floor_model/app_entity_DAO.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'floor_model/app_database.dart';
import 'floor_model/app_entity.dart';

class SyncManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final AppDatabase localDatabase;

  SyncManager(this.localDatabase);

  Future<void> syncAll() async {
    final user = _auth.currentUser;
    if (user != null) {
      await syncUsers();
    }
    await syncChallenges();
    await syncHistory();
    await syncLeaderboard();
    await syncSettings();
  }

  Future<void> syncUsers() async {

  }

  Future<void> syncCloudUsers(int ecoScore) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('syncUserEcoScore');
    try {
      final result = await callable.call(<String, dynamic>{
        'ecoScore': ecoScore,
      });
      print("Successfully synced ecoScore. Result: ${result.data}");
    } on FirebaseFunctionsException catch (e) {
      print("Failed to sync ecoScore: ${e.code} - ${e.message}");
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  Future<void> updateUserPts() async {
    // Implement your comparison and updating logic here
    // For example, comparing ecoScores and updating accordingly
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