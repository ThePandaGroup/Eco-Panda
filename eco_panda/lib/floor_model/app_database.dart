import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'app_entity.dart';
import 'app_entity_DAO.dart'; // Ensure this import path is correct and includes all DAOs

part 'app_database.g.dart'; // Generated code

@Database(version: 1, entities: [User, Challenge, History, Leaderboard, Destination, Setting])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
  ChallengeDao get challengeDao;
  HistoryDao get historyDao;
  LeaderboardDao get leaderboardDao;
  DestinationDao get destinationDao;
  SettingDao get settingDao;
}
