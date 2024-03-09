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

  ChallengeStatusDao? _challengeStatusDaoInstance;

  HistoryDao? _historyDaoInstance;

  DestinationDao? _destinationDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Person` (`userId` TEXT NOT NULL, `username` TEXT NOT NULL, `picPath` TEXT NOT NULL, `ecoScore` INTEGER NOT NULL, `routes` INTEGER NOT NULL, `rank` INTEGER, PRIMARY KEY (`userId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Challenge` (`challengeId` TEXT NOT NULL, `title` TEXT NOT NULL, `challengeDescription` TEXT NOT NULL, `ecoReward` INTEGER NOT NULL, `requirement` INTEGER NOT NULL, `cType` TEXT NOT NULL, PRIMARY KEY (`challengeId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ChallengeStatus` (`challengeStatusId` INTEGER PRIMARY KEY AUTOINCREMENT, `userId` TEXT NOT NULL, `challengeId` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `History` (`historyId` INTEGER PRIMARY KEY AUTOINCREMENT, `yearMonth` TEXT NOT NULL, `historyCarbonFootprint` INTEGER NOT NULL, `userId` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Destination` (`destinationId` INTEGER PRIMARY KEY AUTOINCREMENT, `userId` TEXT NOT NULL, `address` TEXT NOT NULL, `latitude` REAL NOT NULL, `longitude` REAL NOT NULL, `carbonFootprintScore` INTEGER NOT NULL)');

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
  ChallengeStatusDao get challengeStatusDao {
    return _challengeStatusDaoInstance ??=
        _$ChallengeStatusDao(database, changeListener);
  }

  @override
  HistoryDao get historyDao {
    return _historyDaoInstance ??= _$HistoryDao(database, changeListener);
  }

  @override
  DestinationDao get destinationDao {
    return _destinationDaoInstance ??=
        _$DestinationDao(database, changeListener);
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
                  'routes': item.routes,
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
                  'routes': item.routes,
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
            routes: row['routes'] as int,
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
            routes: row['routes'] as int,
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
  Future<void> updateRoute(
    String userId,
    int newRoute,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE Person SET routes = ?2 WHERE userId = ?1',
        arguments: [userId, newRoute]);
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
  Future<int?> retrieveRoute(String userId) async {
    return _queryAdapter.query('SELECT routes FROM Person WHERE userId = ?1',
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
            challengeId: row['challengeId'] as String,
            title: row['title'] as String,
            challengeDescription: row['challengeDescription'] as String,
            ecoReward: row['ecoReward'] as int,
            requirement: row['requirement'] as int,
            cType: row['cType'] as String));
  }

  @override
  Future<Challenge?> retrieveChallengeById(String challengeId) async {
    return _queryAdapter.query('SELECT * FROM Challenge WHERE challengeId = ?1',
        mapper: (Map<String, Object?> row) => Challenge(
            challengeId: row['challengeId'] as String,
            title: row['title'] as String,
            challengeDescription: row['challengeDescription'] as String,
            ecoReward: row['ecoReward'] as int,
            requirement: row['requirement'] as int,
            cType: row['cType'] as String),
        arguments: [challengeId]);
  }

  @override
  Future<void> deleteAllChallenges() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Challenge');
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

class _$ChallengeStatusDao extends ChallengeStatusDao {
  _$ChallengeStatusDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _challengeStatusInsertionAdapter = InsertionAdapter(
            database,
            'ChallengeStatus',
            (ChallengeStatus item) => <String, Object?>{
                  'challengeStatusId': item.challengeStatusId,
                  'userId': item.userId,
                  'challengeId': item.challengeId
                }),
        _challengeStatusDeletionAdapter = DeletionAdapter(
            database,
            'ChallengeStatus',
            ['challengeStatusId'],
            (ChallengeStatus item) => <String, Object?>{
                  'challengeStatusId': item.challengeStatusId,
                  'userId': item.userId,
                  'challengeId': item.challengeId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ChallengeStatus> _challengeStatusInsertionAdapter;

  final DeletionAdapter<ChallengeStatus> _challengeStatusDeletionAdapter;

  @override
  Future<List<ChallengeStatus>> retrieveAllChallengeStatuses() async {
    return _queryAdapter.queryList('SELECT * FROM ChallengeStatus',
        mapper: (Map<String, Object?> row) => ChallengeStatus(
            challengeStatusId: row['challengeStatusId'] as int?,
            userId: row['userId'] as String,
            challengeId: row['challengeId'] as String));
  }

  @override
  Future<List<ChallengeStatus>> retrieveChallengeStatusByUid(
      String userId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ChallengeStatus WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => ChallengeStatus(
            challengeStatusId: row['challengeStatusId'] as int?,
            userId: row['userId'] as String,
            challengeId: row['challengeId'] as String),
        arguments: [userId]);
  }

  @override
  Future<void> insertChallengeStatus(ChallengeStatus challengeStatus) async {
    await _challengeStatusInsertionAdapter.insert(
        challengeStatus, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteChallengeStatus(ChallengeStatus challengeStatus) async {
    await _challengeStatusDeletionAdapter.delete(challengeStatus);
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
            userId: row['userId'] as String),
        arguments: [yearMonth, userId]);
  }

  @override
  Future<void> updateHistoryCarbonFootprint(
    String yearMonth,
    String userId,
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
            userId: row['userId'] as String));
  }

  @override
  Future<List<History>> retrieveHistoriesByUid(String userId) async {
    return _queryAdapter.queryList('SELECT * FROM History WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => History(
            historyId: row['historyId'] as int?,
            yearMonth: row['yearMonth'] as String,
            historyCarbonFootprint: row['historyCarbonFootprint'] as int,
            userId: row['userId'] as String),
        arguments: [userId]);
  }

  @override
  Future<History?> retrieveHistoryByYearMonth(
    String yearMonth,
    String userId,
  ) async {
    return _queryAdapter.query(
        'SELECT * FROM History WHERE yearMonth = ?1 AND userId = ?2',
        mapper: (Map<String, Object?> row) => History(
            historyId: row['historyId'] as int?,
            yearMonth: row['yearMonth'] as String,
            historyCarbonFootprint: row['historyCarbonFootprint'] as int,
            userId: row['userId'] as String),
        arguments: [yearMonth, userId]);
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
                  'userId': item.userId,
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
                  'userId': item.userId,
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
            userId: row['userId'] as String,
            address: row['address'] as String,
            latitude: row['latitude'] as double,
            longitude: row['longitude'] as double,
            carbonFootprintScore: row['carbonFootprintScore'] as int));
  }

  @override
  Future<List<Destination>> retrieveDestinationsByUid(String userId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Destination WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => Destination(
            destinationId: row['destinationId'] as int?,
            userId: row['userId'] as String,
            address: row['address'] as String,
            latitude: row['latitude'] as double,
            longitude: row['longitude'] as double,
            carbonFootprintScore: row['carbonFootprintScore'] as int),
        arguments: [userId]);
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
