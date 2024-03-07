import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_panda/floor_model/app_entity_DAO.dart';
import 'floor_model/app_database.dart';
import 'floor_model/app_entity.dart';

class SyncManager {

  final String uid;
  final AppDatabase localDatabase;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  SyncManager(this.uid, this.localDatabase);

  Future<void> syncAll() async {
    await syncUsers();
    await syncChallenges();
    await syncHistory();
    await syncLeaderboard();
    await syncSettings();
  }

  Future<void> syncUsers() async {
    User? localUser = await localDatabase.userDao.findUserByUid(uid);

    DocumentSnapshot firestoreUserSnapshot = await firebaseFirestore.collection('users').doc(uid).get();
    bool userExistsInCloud = firestoreUserSnapshot.exists;

    // Scenario 1: User exists in both storages
    if (localUser != null && userExistsInCloud) {
      Map<String, dynamic> firestoreUserData = firestoreUserSnapshot.data() as Map<String, dynamic>;
      await compareAndUpdateUser(localUser, firestoreUserData);

    // Scenario 2: User exists only in local storage
    } else if (localUser != null && !userExistsInCloud) {
      // await firebaseFirestore.collection('users').doc(uid).set(localUser.toMap());

    // Scenario 3: User exists only in cloud storage
    } else if (localUser == null && userExistsInCloud) {
      // User newUser = User(uid: uid, userName: firestoreUserSnapshot.data()!['userName'] as String, picPath: firestoreUserSnapshot.data()!['picPath'] as String, carbonFootprintScore: firestoreUserSnapshot.data()!['carbonFootprintScore'] as int, ecoScore: firestoreUserSnapshot.data()!['ecoScore'] as int);
      // await localDatabase.userDao.insertUser(newUser);

    // Scenario 4: User does not exist in either storage
    } else {
      // User newUser = User(
      //   userName: "DefaultUserName", // Example default data
      //   picPath: "default/path",
      //   carbonFootprintScore: 0,
      //   ecoScore: 0,
      // );
      // await localDatabase.userDao.insertUser(newUser);
      // await firebaseFirestore.collection('users').doc(uid).set(newUser.toMap());
    }
  }

  Future<void> compareAndUpdateUser(User localUser, Map<String, dynamic> firestoreUserData) async {
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