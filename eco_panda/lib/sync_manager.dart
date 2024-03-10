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
    int routes = user?.routes ?? 0;

    if (user == null) {
      await localDatabase.personDao.insertUser(Person(
        userId: _auth.currentUser!.uid,
        username: username,
        picPath: 'assets/avatar.png',
        ecoScore: 0,
        routes: 0
      ));
    }

    final updatedData = await syncCloudUsers(ecoScore, username, routes);
    localDatabase.personDao.updateUsername(_auth.currentUser!.uid, updatedData['username']);
    if (ecoScore != updatedData['ecoScore']) {
      localDatabase.personDao.updateEcoScore(_auth.currentUser!.uid, updatedData['ecoScore']);
    }
    if (routes != updatedData['routes']) {
      localDatabase.personDao.updateRoute(_auth.currentUser!.uid, updatedData['routes']);
    }
  }

  Future<Map<String, dynamic>> syncCloudUsers(int ecoScore, String username, int routes) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('syncUserState');
    try {
      final result = await callable.call(<String, dynamic>{
        'ecoScore': ecoScore,
        'username': username,
        'routes': routes,
      });
      print("Successfully synced ecoScore. Result: ${result.data}");
      return result.data;
    } on FirebaseFunctionsException catch (e) {
      print("Failed to sync ecoScore: ${e.code} - ${e.message}");
    } catch (e) {
      print("An error occurred: $e");
    }
    return {'ecoScore': ecoScore, 'routes': routes};
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
    final firestore = FirebaseFirestore.instance;
    final snapshot = await firestore.collection('challenges').get();

    List<Challenge> challenges = snapshot.docs.map((doc) {
      return Challenge(
        challengeId: doc.id,
        title: doc.data()['title'] ?? '',
        challengeDescription: doc.data()['description'] ?? '',
        ecoReward: doc.data()['reward'] ?? 0,
        requirement: doc.data()['required'] ?? 0,
        cType: doc.data()['cType'] ?? '',
      );
    }).toList();

    await refreshChallenges(challenges);
  }

  Future<void> refreshChallenges(List<Challenge> newChallenges) async {
    final challengeDao = localDatabase.challengeDao;
    await challengeDao.deleteAllChallenges();

    for (var challenge in newChallenges) {
      await challengeDao.insertChallenge(challenge);
    }
  }

  Future<void> incrementUserEcoscore(int ecoScore) async {
    final user = _auth.currentUser;
    if (user != null) {
      int currentEcoscore = await localDatabase.personDao.retrieveEcoScore(_auth.currentUser!.uid) ?? 0;
      localDatabase.personDao.updateEcoScore(_auth.currentUser!.uid, currentEcoscore + ecoScore);
      incrementUserCloudEcoscore(ecoScore);
      incrementMonthlyHistory(ecoScore);
    }
  }

  Future<void> incrementUserCloudEcoscore(int ecoScore) async {
    FirebaseFunctions functions = FirebaseFunctions.instance;
    try {
      final HttpsCallableResult result = await functions.httpsCallable('updateUserEcoScore').call({
        'ecoScore': ecoScore,
      });
      print("Function result: ${result.data}");
    } catch (e) {
      print("Error calling function: $e");
    }
  }

  Future<void> incrementMonthlyHistory(int ecoScore) async {
    final localDb = localDatabase;
    final DateTime now = DateTime.now();
    final String currentYearMonth = "${now.year}-${now.month.toString().padLeft(2, '0')}";

    History? currentMonthData = await localDb.historyDao.retrieveHistoryByYearMonth(currentYearMonth, _auth.currentUser!.uid);

    if (currentMonthData == null) {
      currentMonthData = History(
        yearMonth: currentYearMonth,
        historyCarbonFootprint: ecoScore,
        userId: _auth.currentUser!.uid,
      );
      await localDb.historyDao.insertHistory(currentMonthData);
    } else {
      await localDb.historyDao.updateHistoryCarbonFootprint(currentMonthData.yearMonth, _auth.currentUser!.uid, currentMonthData.historyCarbonFootprint + ecoScore);
    }
  }

  Future<void> incrementUserRoute() async {
    final user = _auth.currentUser;
    if (user != null) {
      int currentRoutes = await localDatabase.personDao.retrieveRoute(_auth.currentUser!.uid) ?? 0;
      localDatabase.personDao.updateRoute(_auth.currentUser!.uid, currentRoutes + 1);
      incrementUserCloudRoute();
    }
  }

  Future<void> incrementUserCloudRoute() async {
    FirebaseFunctions functions = FirebaseFunctions.instance;
    try {
      final HttpsCallableResult result = await functions.httpsCallable('incrementUserRoute').call();
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

  Future<void> updatePicPath(String picPath) async {
    final user = _auth.currentUser;
    if (user != null) {
      localDatabase.personDao.updatePicPath(_auth.currentUser!.uid, picPath);
    }
  }
}