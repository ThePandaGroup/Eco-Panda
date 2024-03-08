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

  PersonDao? _personDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Person` (`userId` TEXT NOT NULL, `username` TEXT NOT NULL, `picPath` TEXT NOT NULL, `ecoScore` INTEGER NOT NULL, `rank` INTEGER, PRIMARY KEY (`userId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Challenge` (`challengeId` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `challengeDescription` TEXT NOT NULL, `ecoReward` INTEGER NOT NULL, `requirement` INTEGER NOT NULL, `progress` INTEGER NOT NULL, `userId` TEXT NOT NULL, `cType` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `History` (`historyId` INTEGER PRIMARY KEY AUTOINCREMENT, `yearMonth` TEXT NOT NULL, `historyCarbonFootprint` INTEGER NOT NULL, `userId` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Leaderboard` (`leaderboardId` INTEGER PRIMARY KEY AUTOINCREMENT, `rankScore` INTEGER NOT NULL, `rankerName` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Destination` (`destinationId` INTEGER PRIMARY KEY AUTOINCREMENT, `address` TEXT NOT NULL, `latitude` REAL NOT NULL, `longitude` REAL NOT NULL, `carbonFootprintScore` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Setting` (`settingType` TEXT NOT NULL, `on` INTEGER NOT NULL, PRIMARY KEY (`settingType`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PersonDao get personDao {
    return _personDaoInstance ??= _$PersonDao(database, changeListener);
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

class _$PersonDao extends PersonDao {
  _$PersonDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _personInsertionAdapter = InsertionAdapter(
            database,
            'Person',
            (Person item) => <String, Object?>{
                  'userId': item.userId,
                  'username': item.username,
                  'picPath': item.picPath,
                  'ecoScore': item.ecoScore,
                  'rank': item.rank
                }),
        _personDeletionAdapter = DeletionAdapter(
            database,
            'Person',
            ['userId'],
            (Person item) => <String, Object?>{
                  'userId': item.userId,
                  'username': item.username,
                  'picPath': item.picPath,
                  'ecoScore': item.ecoScore,
                  'rank': item.rank
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Person> _personInsertionAdapter;

  final DeletionAdapter<Person> _personDeletionAdapter;

  @override
  Future<List<Person>> retrieveOnlyUser() async {
    return _queryAdapter.queryList('SELECT * FROM Person',
        mapper: (Map<String, Object?> row) => Person(
            userId: row['userId'] as String,
            username: row['username'] as String,
            picPath: row['picPath'] as String,
            ecoScore: row['ecoScore'] as int,
            rank: row['rank'] as int?));
  }

  @override
  Future<Person?> findUserByUid(String uid) async {
    return _queryAdapter.query('SELECT * FROM Person WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => Person(
            userId: row['userId'] as String,
            username: row['username'] as String,
            picPath: row['picPath'] as String,
            ecoScore: row['ecoScore'] as int,
            rank: row['rank'] as int?),
        arguments: [uid]);
  }

  @override
  Future<void> updatePicPath(
    String userId,
    String picPath,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE Person SET picPath = ?2 WHERE userId = ?1',
        arguments: [userId, picPath]);
  }

  @override
  Future<void> updateEcoScore(
    String userId,
    int ecoScore,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE Person SET ecoScore = ?2 WHERE userId = ?1',
        arguments: [userId, ecoScore]);
  }

  @override
  Future<void> updateRank(
    String userId,
    int rank,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE Person SET rank = ?2 WHERE userId = ?1',
        arguments: [userId, rank]);
  }

  @override
  Future<void> updateUsername(
    String userId,
    String username,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE Person SET username = ?2 WHERE userId = ?1',
        arguments: [userId, username]);
  }

  @override
  Future<String?> retrievePicPath(String userId) async {
    return _queryAdapter.query('SELECT picPath FROM Person WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [userId]);
  }

  @override
  Future<int?> retrieveEcoScore(String userId) async {
    return _queryAdapter.query('SELECT ecoScore FROM Person WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [userId]);
  }

  @override
  Future<void> insertUser(Person user) async {
    await _personInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<int> removeUser(Person user) {
    return _personDeletionAdapter.deleteAndReturnChangedRows(user);
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
                  'title': item.title,
                  'challengeDescription': item.challengeDescription,
                  'ecoReward': item.ecoReward,
                  'requirement': item.requirement,
                  'progress': item.progress,
                  'userId': item.userId,
                  'cType': item.cType
                }),
        _challengeDeletionAdapter = DeletionAdapter(
            database,
            'Challenge',
            ['challengeId'],
            (Challenge item) => <String, Object?>{
                  'challengeId': item.challengeId,
                  'title': item.title,
                  'challengeDescription': item.challengeDescription,
                  'ecoReward': item.ecoReward,
                  'requirement': item.requirement,
                  'progress': item.progress,
                  'userId': item.userId,
                  'cType': item.cType
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
            title: row['title'] as String,
            challengeDescription: row['challengeDescription'] as String,
            ecoReward: row['ecoReward'] as int,
            requirement: row['requirement'] as int,
            progress: row['progress'] as int,
            cType: row['cType'] as String,
            userId: row['userId'] as String));
  }

  @override
  Future<List<Challenge>> findChallengesByUid(String uid) async {
    return _queryAdapter.queryList('SELECT * FROM Challenge WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => Challenge(
            challengeId: row['challengeId'] as int?,
            title: row['title'] as String,
            challengeDescription: row['challengeDescription'] as String,
            ecoReward: row['ecoReward'] as int,
            requirement: row['requirement'] as int,
            progress: row['progress'] as int,
            cType: row['cType'] as String,
            userId: row['userId'] as String),
        arguments: [uid]);
  }

  @override
  Future<Challenge?> retrieveChallengeById(int challengeId) async {
    return _queryAdapter.query('SELECT * FROM Challenge WHERE challengeId = ?1',
        mapper: (Map<String, Object?> row) => Challenge(
            challengeId: row['challengeId'] as int?,
            title: row['title'] as String,
            challengeDescription: row['challengeDescription'] as String,
            ecoReward: row['ecoReward'] as int,
            requirement: row['requirement'] as int,
            progress: row['progress'] as int,
            cType: row['cType'] as String,
            userId: row['userId'] as String),
        arguments: [challengeId]);
  }

  @override
  Future<List<Challenge>> retrieveChallengesByUserId(String userId) async {
    return _queryAdapter.queryList('SELECT * FROM Challenge WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => Challenge(
            challengeId: row['challengeId'] as int?,
            title: row['title'] as String,
            challengeDescription: row['challengeDescription'] as String,
            ecoReward: row['ecoReward'] as int,
            requirement: row['requirement'] as int,
            progress: row['progress'] as int,
            cType: row['cType'] as String,
            userId: row['userId'] as String),
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
    String userId,
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
  Future<List<History>> retrieveHistories() async {
    return _queryAdapter.queryList('SELECT * FROM History',
        mapper: (Map<String, Object?> row) => History(
            historyId: row['historyId'] as int?,
            yearMonth: row['yearMonth'] as String,
            historyCarbonFootprint: row['historyCarbonFootprint'] as int,
            userId: row['userId'] as int));
  }

  @override
  Future<int?> sumHistoryCarbonFootprint() async {
    return _queryAdapter.query(
        'SELECT COALESCE(SUM(historyCarbonFootprint), 0) FROM History',
        mapper: (Map<String, Object?> row) => row.values.first as int);
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
                  'address': item.address,
                  'latitude': item.latitude,
                  'longitude': item.longitude,
                  'carbonFootprintScore': item.carbonFootprintScore
                }),
        _destinationDeletionAdapter = DeletionAdapter(
            database,
            'Destination',
            ['destinationId'],
            (Destination item) => <String, Object?>{
                  'destinationId': item.destinationId,
                  'address': item.address,
                  'latitude': item.latitude,
                  'longitude': item.longitude,
                  'carbonFootprintScore': item.carbonFootprintScore
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Destination> _destinationInsertionAdapter;

  final DeletionAdapter<Destination> _destinationDeletionAdapter;

  @override
  Future<List<Destination>> retrievePastDestinations() async {
    return _queryAdapter.queryList('SELECT * FROM Destination',
        mapper: (Map<String, Object?> row) => Destination(
            destinationId: row['destinationId'] as int?,
            address: row['address'] as String,
            latitude: row['latitude'] as double,
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
