import 'package:cloud_functions/cloud_functions.dart';
import 'package:eco_panda/floor_model/app_database.dart';
import 'package:eco_panda/floor_model/app_entity_DAO.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseApp extends Mock implements FirebaseApp {}
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockUserCredential extends Mock implements UserCredential {}
class MockUser extends Mock implements User {}
class MockFirebaseFunctions extends Mock implements FirebaseFunctions {}
class MockAppDatabase extends Mock implements AppDatabase {}
class MockPersonDao extends Mock implements PersonDao {}
class MockChallengeDao extends Mock implements ChallengeDao {}
class MockHistoryDao extends Mock implements HistoryDao {}
class MockChallengeStatusDao extends Mock implements ChallengeStatusDao {}
class MockDestinationDao extends Mock implements DestinationDao {}

void setupFirebaseAuthMocks() {
  TestWidgetsFlutterBinding.ensureInitialized();

  when(Firebase.initializeApp()).thenAnswer((_) async {
    return MockFirebaseApp();
  });

  // Add additional Firebase service mocks here as needed
}

MockAppDatabase setupMocks() {
  setupFirebaseAuthMocks(); // Existing setup for Firebase Auth mocks

  // Mock AppDatabase and its DAOs
  final mockAppDatabase = MockAppDatabase();
  when(mockAppDatabase.personDao).thenReturn(MockPersonDao());
  when(mockAppDatabase.challengeDao).thenReturn(MockChallengeDao());
  when(mockAppDatabase.historyDao).thenReturn(MockHistoryDao());
  when(mockAppDatabase.challengeStatusDao).thenReturn(MockChallengeStatusDao());
  when(mockAppDatabase.destinationDao).thenReturn(MockDestinationDao());

  return mockAppDatabase;
}
