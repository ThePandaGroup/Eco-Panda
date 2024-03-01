import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:eco_panda/sync_manager.dart';
import 'package:eco_panda/floor_model/app_database.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockAppDatabase extends Mock implements AppDatabase {}



void main() {
  group('SyncManager', () {
    test('has a syncAll method', () {
      final db = MockAppDatabase();
      final firebaseFirestore = MockFirebaseFirestore();
      final manager = SyncManager(db, firebaseFirestore);
      expect(manager.syncAll, isNotNull);
    });

    test('has a syncUsers method', () {
      final db = MockAppDatabase();
      final firebaseFirestore = MockFirebaseFirestore();
      final manager = SyncManager(db, firebaseFirestore);
      expect(manager.syncUsers, isNotNull);
    });

    test('has a syncChallenges method', () {
      final db = MockAppDatabase();
      final firebaseFirestore = MockFirebaseFirestore();
      final manager = SyncManager(db, firebaseFirestore);
      expect(manager.syncChallenges, isNotNull);
    });

    test('has a syncHistory method', () {
      final db = MockAppDatabase();
      final firebaseFirestore = MockFirebaseFirestore();
      final manager = SyncManager(db, firebaseFirestore);
      expect(manager.syncHistory, isNotNull);
    });

    test('has a syncLeaderboard method', () {
      final db = MockAppDatabase();
      final firebaseFirestore = MockFirebaseFirestore();
      final manager = SyncManager(db, firebaseFirestore);
      expect(manager.syncLeaderboard, isNotNull);
    });

    test('has a syncSettings method', () {
      final db = MockAppDatabase();
      final firebaseFirestore = MockFirebaseFirestore();
      final manager = SyncManager(db, firebaseFirestore);
      expect(manager.syncSettings, isNotNull);
    });
  });
}