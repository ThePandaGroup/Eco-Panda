import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'app_entity.dart';
import 'app_entity_DAO.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [Person, Challenge, ChallengeStatus, History, Destination])
abstract class AppDatabase extends FloorDatabase {
  PersonDao get personDao;
  ChallengeDao get challengeDao;
  ChallengeStatusDao get challengeStatusDao;
  HistoryDao get historyDao;
  DestinationDao get destinationDao;
}
