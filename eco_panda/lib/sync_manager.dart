import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'floor_model/app_database.dart';
import 'floor_model/app_entity.dart';
import 'dart:math' as math;

class SyncManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final AppDatabase localDatabase;

  SyncManager(this.localDatabase);

  Future<void> syncAll() async {
    final user = _auth.currentUser;
    if (user != null) {
      await syncUsers();
      await syncUserRank();
      await syncChallenges();
    }
  }

  Future<void> syncUsers() async {
    final user = await localDatabase.personDao.findUserByUid(_auth.currentUser!.uid);
    int ecoScore = user?.ecoScore ?? 0;
    String username = user?.username ?? 'user_${math.Random().nextInt(99999)}';

    if (user == null) {
      await localDatabase.personDao.insertUser(Person(
        userId: _auth.currentUser!.uid,
        username: username,
        picPath: 'assets/avatar.png',
        ecoScore: 0,
      ));
    }

    int updatedEcoScore = await syncCloudUsers(ecoScore, username);
    if (ecoScore != updatedEcoScore) {
      localDatabase.personDao.updateEcoScore(_auth.currentUser!.uid, updatedEcoScore);
    }
  }

  Future<int> syncCloudUsers(int ecoScore, String username) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('syncUserState');
    try {
      final result = await callable.call(<String, dynamic>{
        'ecoScore': ecoScore,
        'username': username,
      });
      final int updatedEcoScore = result.data['ecoScore'];
      print("Successfully synced ecoScore. Result: ${result.data}");
      localDatabase.personDao.updateUsername(_auth.currentUser!.uid, username);
      return updatedEcoScore;
    } on FirebaseFunctionsException catch (e) {
      print("Failed to sync ecoScore: ${e.code} - ${e.message}");
    } catch (e) {
      print("An error occurred: $e");
    }
    return ecoScore;
  }

  Future<void> syncUserRank() async {
    final user = _auth.currentUser;
    if (user == null) {
      return;
    }
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getUserRank');
    try {
      final HttpsCallableResult result = await callable.call();
      final rank = result.data['rank'];
      print("User rank: $rank");
      if (rank != -1) {
        await localDatabase.personDao.updateRank(user.uid, rank);
      }
    } on FirebaseFunctionsException catch (e) {
      print("Failed to fetch user rank: ${e.code} - ${e.message}");
    } catch (e) {
      print("An error occurred while fetching user rank: $e");
    }
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

  Future<void> incrementUserEcoscore(int ecoScore) async {
    final user = _auth.currentUser;
    if (user != null) {
      int currentEcoscore = await localDatabase.personDao.retrieveEcoScore(_auth.currentUser!.uid) ?? 0;
      localDatabase.personDao.updateEcoScore(_auth.currentUser!.uid, currentEcoscore + ecoScore);
      incrementUserCloudEcoscore(ecoScore);
    }
  }

  Future<void> incrementUserCloudEcoscore(int ecoScore) async {
    FirebaseFunctions functions = FirebaseFunctions.instance;
    try {
      final HttpsCallableResult result = await functions.httpsCallable('updateUserPoints').call({
        'ecoScore': ecoScore,
      });
      print("Function result: ${result.data}");
    } catch (e) {
      print("Error calling function: $e");
    }
  }

  Future<bool> updateUsername(String newUsername) async {
    final user = _auth.currentUser;
    if (user != null) {
      localDatabase.personDao.updateUsername(_auth.currentUser!.uid, newUsername);
      return await updateCloudUsername(newUsername);
    }
    return false;
  }

  Future<bool> updateCloudUsername(String newUsername) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('updateUsername');
    try {
      final response = await callable.call({
        'username': newUsername,
      });
      print(response.data);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
}