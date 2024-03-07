import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
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
      await syncChallenges();
    }
  }

  Future<void> syncUsers() async {
    final user = await localDatabase.personDao.findUserByUid(_auth.currentUser!.uid);
    int ecoScore = user?.ecoScore ?? 0;

    if (user == null) {
      await localDatabase.personDao.insertUser(Person(
        userId: _auth.currentUser!.uid,
        picPath: 'assets/avatar.png',
        ecoScore: 0,
      ));
    }

    int updatedEcoScore = await syncCloudUsers(ecoScore);
    if (ecoScore != updatedEcoScore) {
      localDatabase.personDao.updateEcoScore(FirebaseAuth.instance.currentUser!.uid, updatedEcoScore);
    }
  }

  Future<int> syncCloudUsers(int ecoScore) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('syncUserEcoScore');
    try {
      final result = await callable.call(<String, dynamic>{
        'ecoScore': ecoScore,
      });
      final int updatedEcoScore = result.data['ecoScore'];
      print("Successfully synced ecoScore. Result: ${result.data}");
      return updatedEcoScore;
    } on FirebaseFunctionsException catch (e) {
      print("Failed to sync ecoScore: ${e.code} - ${e.message}");
    } catch (e) {
      print("An error occurred: $e");
    }
    return ecoScore;
  }

  Future<void> syncChallenges() async {
    final existingChallenges = await localDatabase.challengeDao.findChallengesByUid(_auth.currentUser!.uid);
    if (existingChallenges.isNotEmpty) return;

    final challengesSnapshot = await FirebaseFirestore.instance.collection('challenges').get();

    final List<Challenge> challengesToInsert = [];
    for (final doc in challengesSnapshot.docs) {
      final data = doc.data();
      challengesToInsert.add(Challenge(
        title: data['title'] ?? '',
        challengeDescription: data['description'] ?? '',
        ecoReward: data['reward'] ?? 0,
        requirement: data['required'] ?? 0,
        progress: 0,
        cType: data['cType'] ?? '',
        userId: _auth.currentUser!.uid,
      ));
    }

    for (final challenge in challengesToInsert) {
      await localDatabase.challengeDao.insertChallenge(challenge);
    }
  }

  Future<void> updateUserPts() async {
    // Implement your comparison and updating logic here
    // For example, comparing ecoScores and updating accordingly
  }
}