// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  ChallengeDao? _challengeDaoInstance;

  HistoryDao? _historyDaoInstance;

  LeaderboardDao? _leaderboardDaoInstance;

  DestinationDao? _destinationDaoInstance;

  SettingDao? _settingDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `User` (`userId` INTEGER PRIMARY KEY AUTOINCREMENT, `userName` TEXT NOT NULL, `picPath` TEXT NOT NULL, `carbonFootprintScore` INTEGER NOT NULL, `ecoScore` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Challenge` (`challengeId` INTEGER PRIMARY KEY AUTOINCREMENT, `challengeDescription` TEXT NOT NULL, `ecoReward` INTEGER NOT NULL, `progress` INTEGER NOT NULL, `userId` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `History` (`historyId` INTEGER PRIMARY KEY AUTOINCREMENT, `yearMonth` TEXT NOT NULL, `historyCarbonFootprint` INTEGER NOT NULL, `userId` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Leaderboard` (`leaderboardId` INTEGER PRIMARY KEY AUTOINCREMENT, `rankScore` INTEGER NOT NULL, `rankerName` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Destination` (`destinationId` INTEGER PRIMARY KEY AUTOINCREMENT, `lastitude` REAL NOT NULL, `longitude` REAL NOT NULL, `carbonFootprintScore` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Setting` (`settingType` TEXT NOT NULL, `on` INTEGER NOT NULL, PRIMARY KEY (`settingType`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  ChallengeDao get challengeDao {
    return _challengeDaoInstance ??= _$ChallengeDao(database, changeListener);
  }

  @override
  HistoryDao get historyDao {
    return _historyDaoInstance ??= _$HistoryDao(database, changeListener);
  }

  @override
  LeaderboardDao get leaderboardDao {
    return _leaderboardDaoInstance ??=
        _$LeaderboardDao(database, changeListener);
  }

  @override
  DestinationDao get destinationDao {
    return _destinationDaoInstance ??=
        _$DestinationDao(database, changeListener);
  }

  @override
  SettingDao get settingDao {
    return _settingDaoInstance ??= _$SettingDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'User',
            (User item) => <String, Object?>{
                  'userId': item.userId,
                  'userName': item.userName,
                  'picPath': item.picPath,
                  'carbonFootprintScore': item.carbonFootprintScore,
                  'ecoScore': item.ecoScore
                }),
        _userDeletionAdapter = DeletionAdapter(
            database,
            'User',
            ['userId'],
            (User item) => <String, Object?>{
                  'userId': item.userId,
                  'userName': item.userName,
                  'picPath': item.picPath,
                  'carbonFootprintScore': item.carbonFootprintScore,
                  'ecoScore': item.ecoScore
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<User> _userInsertionAdapter;

  final DeletionAdapter<User> _userDeletionAdapter;

  @override
  Future<void> updatePicPath(
    int userId,
    String picPath,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE User SET picPath = ?2 WHERE userId = ?1',
        arguments: [userId, picPath]);
  }

  @override
  Future<void> updateEcoScore(
    int userId,
    int ecoScore,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE User SET ecoScore = ?2 WHERE userId = ?1',
        arguments: [userId, ecoScore]);
  }

  @override
  Future<void> updateCarbonFootprintScore(
    int userId,
    int carbonFt,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE User SET carbonFootprintScore = ?2 WHERE userId = ?1',
        arguments: [userId, carbonFt]);
  }

  @override
  Future<String?> retrievePicPath(int userId) async {
    return _queryAdapter.query('SELECT picPath FROM User WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [userId]);
  }

  @override
  Future<int?> retrieveEcoScore(int userId) async {
    return _queryAdapter.query('SELECT ecoScore FROM User WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [userId]);
  }

  @override
  Future<int?> retrieveCarbonFootprintScore(int userId) async {
    return _queryAdapter.query(
        'SELECT carbonFootprintScore FROM User WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [userId]);
  }

  @override
  Future<void> insertUser(User user) async {
    await _userInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<int> removeUser(User user) {
    return _userDeletionAdapter.deleteAndReturnChangedRows(user);
  }
}

class _$ChallengeDao extends ChallengeDao {
  _$ChallengeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _challengeInsertionAdapter = InsertionAdapter(
            database,
            'Challenge',
            (Challenge item) => <String, Object?>{
                  'challengeId': item.challengeId,
                  'challengeDescription': item.challengeDescription,
                  'ecoReward': item.ecoReward,
                  'progress': item.progress,
                  'userId': item.userId
                }),
        _challengeDeletionAdapter = DeletionAdapter(
            database,
            'Challenge',
            ['challengeId'],
            (Challenge item) => <String, Object?>{
                  'challengeId': item.challengeId,
                  'challengeDescription': item.challengeDescription,
                  'ecoReward': item.ecoReward,
                  'progress': item.progress,
                  'userId': item.userId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Challenge> _challengeInsertionAdapter;

  final DeletionAdapter<Challenge> _challengeDeletionAdapter;

  @override
  Future<List<Challenge>> retrieveAllChallenges() async {
    return _queryAdapter.queryList('SELECT * FROM Challenge',
        mapper: (Map<String, Object?> row) => Challenge(
            challengeId: row['challengeId'] as int?,
            challengeDescription: row['challengeDescription'] as String,
            ecoReward: row['ecoReward'] as int,
            progress: row['progress'] as int,
            userId: row['userId'] as int));
  }

  @override
  Future<Challenge?> retrieveChallengeById(int challengeId) async {
    return _queryAdapter.query('SELECT * FROM Challenge WHERE challengeId = ?1',
        mapper: (Map<String, Object?> row) => Challenge(
            challengeId: row['challengeId'] as int?,
            challengeDescription: row['challengeDescription'] as String,
            ecoReward: row['ecoReward'] as int,
            progress: row['progress'] as int,
            userId: row['userId'] as int),
        arguments: [challengeId]);
  }

  @override
  Future<List<Challenge>> retrieveChallengesByUserId(int userId) async {
    return _queryAdapter.queryList('SELECT * FROM Challenge WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => Challenge(
            challengeId: row['challengeId'] as int?,
            challengeDescription: row['challengeDescription'] as String,
            ecoReward: row['ecoReward'] as int,
            progress: row['progress'] as int,
            userId: row['userId'] as int),
        arguments: [userId]);
  }

  @override
  Future<void> updateEcoReward(
    int challengeId,
    int ecoReward,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE Challenge SET ecoReward = ?2 WHERE challengeId = ?1',
        arguments: [challengeId, ecoReward]);
  }

  @override
  Future<void> updateProgress(
    int challengeId,
    int userId,
    int progress,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE Challenge SET progress = ?3 WHERE challengeId = ?1 AND userId = ?2',
        arguments: [challengeId, userId, progress]);
  }

  @override
  Future<void> insertChallenge(Challenge challenge) async {
    await _challengeInsertionAdapter.insert(
        challenge, OnConflictStrategy.abort);
  }

  @override
  Future<int> removeChallenge(Challenge challenge) {
    return _challengeDeletionAdapter.deleteAndReturnChangedRows(challenge);
  }
}

class _$HistoryDao extends HistoryDao {
  _$HistoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _historyInsertionAdapter = InsertionAdapter(
            database,
            'History',
            (History item) => <String, Object?>{
                  'historyId': item.historyId,
                  'yearMonth': item.yearMonth,
                  'historyCarbonFootprint': item.historyCarbonFootprint,
                  'userId': item.userId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<History> _historyInsertionAdapter;

  @override
  Future<List<History>> retrieveHistoryByYearMonthAndUserId(
    String yearMonth,
    int userId,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM History WHERE yearMonth = ?1 AND userId = ?2',
        mapper: (Map<String, Object?> row) => History(
            historyId: row['historyId'] as int?,
            yearMonth: row['yearMonth'] as String,
            historyCarbonFootprint: row['historyCarbonFootprint'] as int,
            userId: row['userId'] as int),
        arguments: [yearMonth, userId]);
  }

  @override
  Future<void> updateHistoryCarbonFootprint(
    String yearMonth,
    int userId,
    int carbonFootprint,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE History SET historyCarbonFootprint = ?3 WHERE yearMonth = ?1 AND userId = ?2',
        arguments: [yearMonth, userId, carbonFootprint]);
  }

  @override
  Future<List<History>> retrieveLast12Histories() async {
    return _queryAdapter.queryList(
        'SELECT * FROM History ORDER BY historyId DESC LIMIT 12',
        mapper: (Map<String, Object?> row) => History(
            historyId: row['historyId'] as int?,
            yearMonth: row['yearMonth'] as String,
            historyCarbonFootprint: row['historyCarbonFootprint'] as int,
            userId: row['userId'] as int));
  }

  @override
  Future<void> insertHistory(History history) async {
    await _historyInsertionAdapter.insert(history, OnConflictStrategy.abort);
  }
}

class _$LeaderboardDao extends LeaderboardDao {
  _$LeaderboardDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _leaderboardInsertionAdapter = InsertionAdapter(
            database,
            'Leaderboard',
            (Leaderboard item) => <String, Object?>{
                  'leaderboardId': item.leaderboardId,
                  'rankScore': item.rankScore,
                  'rankerName': item.rankerName
                }),
        _leaderboardDeletionAdapter = DeletionAdapter(
            database,
            'Leaderboard',
            ['leaderboardId'],
            (Leaderboard item) => <String, Object?>{
                  'leaderboardId': item.leaderboardId,
                  'rankScore': item.rankScore,
                  'rankerName': item.rankerName
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Leaderboard> _leaderboardInsertionAdapter;

  final DeletionAdapter<Leaderboard> _leaderboardDeletionAdapter;

  @override
  Future<List<Leaderboard>> retrieveTopLeaderboards() async {
    return _queryAdapter.queryList(
        'SELECT * FROM Leaderboard ORDER BY rankScore DESC LIMIT 10',
        mapper: (Map<String, Object?> row) => Leaderboard(
            leaderboardId: row['leaderboardId'] as int?,
            rankerName: row['rankerName'] as String,
            rankScore: row['rankScore'] as int));
  }

  @override
  Future<void> updateLeaderboardByRankerName(
    String rankerName,
    int rankScore,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE Leaderboard SET rankScore = ?2 WHERE rankerName = ?1',
        arguments: [rankerName, rankScore]);
  }

  @override
  Future<void> insertLeaderboard(Leaderboard leaderboard) async {
    await _leaderboardInsertionAdapter.insert(
        leaderboard, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteLeaderboard(Leaderboard leaderboard) async {
    await _leaderboardDeletionAdapter.delete(leaderboard);
  }
}

class _$DestinationDao extends DestinationDao {
  _$DestinationDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _destinationInsertionAdapter = InsertionAdapter(
            database,
            'Destination',
            (Destination item) => <String, Object?>{
                  'destinationId': item.destinationId,
                  'lastitude': item.lastitude,
                  'longitude': item.longitude,
                  'carbonFootprintScore': item.carbonFootprintScore
                }),
        _destinationDeletionAdapter = DeletionAdapter(
            database,
            'Destination',
            ['destinationId'],
            (Destination item) => <String, Object?>{
                  'destinationId': item.destinationId,
                  'lastitude': item.lastitude,
                  'longitude': item.longitude,
                  'carbonFootprintScore': item.carbonFootprintScore
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Destination> _destinationInsertionAdapter;

  final DeletionAdapter<Destination> _destinationDeletionAdapter;

  @override
  Future<List<Destination>> retrieveDestinationsDescending() async {
    return _queryAdapter.queryList(
        'SELECT * FROM Destination ORDER BY destinationId DESC LIMIT 5',
        mapper: (Map<String, Object?> row) => Destination(
            destinationId: row['destinationId'] as int?,
            lastitude: row['lastitude'] as double,
            longitude: row['longitude'] as double,
            carbonFootprintScore: row['carbonFootprintScore'] as int));
  }

  @override
  Future<void> insertDestination(Destination destination) async {
    await _destinationInsertionAdapter.insert(
        destination, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteDestination(Destination destination) async {
    await _destinationDeletionAdapter.delete(destination);
  }
}

class _$SettingDao extends SettingDao {
  _$SettingDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _settingInsertionAdapter = InsertionAdapter(
            database,
            'Setting',
            (Setting item) => <String, Object?>{
                  'settingType': item.settingType,
                  'on': item.on ? 1 : 0
                }),
        _settingDeletionAdapter = DeletionAdapter(
            database,
            'Setting',
            ['settingType'],
            (Setting item) => <String, Object?>{
                  'settingType': item.settingType,
                  'on': item.on ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Setting> _settingInsertionAdapter;

  final DeletionAdapter<Setting> _settingDeletionAdapter;

  @override
  Future<Setting?> retrieveSettingByType(String settingType) async {
    return _queryAdapter.query('SELECT * FROM Setting WHERE settingType = ?1',
        mapper: (Map<String, Object?> row) => Setting(
            settingType: row['settingType'] as String,
            on: (row['on'] as int) != 0),
        arguments: [settingType]);
  }

  @override
  Future<void> insertSetting(Setting setting) async {
    await _settingInsertionAdapter.insert(setting, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSetting(Setting setting) async {
    await _settingDeletionAdapter.delete(setting);
  }
}