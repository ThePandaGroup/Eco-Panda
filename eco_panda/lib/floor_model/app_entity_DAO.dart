import 'package:floor/floor.dart';
import 'app_entity.dart';

@dao
abstract class UserDao {
  @insert
  Future<void> insertUser(User user);

  @Query("UPDATE User SET picPath = :picPath WHERE userId = :userId")
  Future<void> updatePicPath(int userId, String picPath);

  @Query("UPDATE User SET ecoScore = :ecoScore WHERE userId = :userId")
  Future<void> updateEcoScore(int userId, int ecoScore);

  @Query("UPDATE User SET carbonFootprintScore = :carbonFt WHERE userId = :userId")
  Future<void> updateCarbonFootprintScore(int userId, int carbonFt);

  @Query('SELECT picPath FROM User WHERE userId = :userId')
  Future<String?> retrievePicPath(int userId);

  @Query('SELECT ecoScore FROM User WHERE userId = :userId')
  Future<int?> retrieveEcoScore(int userId);

  @Query('SELECT carbonFootprintScore FROM User WHERE userId = :userId')
  Future<int?> retrieveCarbonFootprintScore(int userId);

  @delete
  Future<int?>removeUser(User user);

}

@dao
abstract class ChallengeDao {
  // Insert a new challenge
  @insert
  Future<void> insertChallenge(Challenge challenge);

  // Retrieve all challenges from the table
  @Query('SELECT * FROM Challenge')
  Future<List<Challenge>> retrieveAllChallenges();

  // Retrieve a challenge by challengeId
  @Query('SELECT * FROM Challenge WHERE challengeId = :challengeId')
  Future<Challenge?> retrieveChallengeById(int challengeId);

  // Retrieve challenges based on userId
  @Query('SELECT * FROM Challenge WHERE userId = :userId')
  Future<List<Challenge>> retrieveChallengesByUserId(int userId);

  // Update ecoReward by challengeId
  @Query('UPDATE Challenge SET ecoReward = :ecoReward WHERE challengeId = :challengeId')
  Future<void> updateEcoReward(int challengeId, int ecoReward);

  // Update progress by challengeId and userId (assuming challengeId is unique and sufficient to identify a challenge, the userId condition may be redundant, but included as per request)
  @Query('UPDATE Challenge SET progress = :progress WHERE challengeId = :challengeId AND userId = :userId')
  Future<void> updateProgress(int challengeId, int userId, int progress);

  @delete
  Future<int?>removeChallenge(Challenge challenge);
}

@dao
abstract class HistoryDao {
  // Insert a new history record
  @insert
  Future<void> insertHistory(History history);

  // Retrieve history by yearMonth and userId
  @Query('SELECT * FROM History WHERE yearMonth = :yearMonth AND userId = :userId')
  Future<List<History>> retrieveHistoryByYearMonthAndUserId(String yearMonth, int userId);

  // Update historyCarbonFootprint by yearMonth and userId
  @Query('UPDATE History SET historyCarbonFootprint = :carbonFootprint WHERE yearMonth = :yearMonth AND userId = :userId')
  Future<void> updateHistoryCarbonFootprint(String yearMonth, int userId, int carbonFootprint);

  // Retrieve the last 12 history records in descending order of historyId
  @Query('SELECT * FROM History ORDER BY historyId DESC LIMIT 12')
  Future<List<History>> retrieveLast12Histories();
}

@dao
abstract class LeaderboardDao {
  // Insert a new leaderboard entry
  @insert
  Future<void> insertLeaderboard(Leaderboard leaderboard);

  // Retrieve the top 10 leaderboard entries ordered by rankScore in descending order
  @Query('SELECT * FROM Leaderboard ORDER BY rankScore DESC LIMIT 10')
  Future<List<Leaderboard>> retrieveTopLeaderboards();

  // Delete a leaderboard entry
  @delete
  Future<void> deleteLeaderboard(Leaderboard leaderboard);

  // Update a leaderboard entry by rankerName
  // Note: This assumes that rankerName is unique, or you might want to use leaderboardId or another unique identifier for updates.
  @Query('UPDATE Leaderboard SET rankScore = :rankScore WHERE rankerName = :rankerName')
  Future<void> updateLeaderboardByRankerName(String rankerName, int rankScore);
}

@dao
abstract class DestinationDao {
  // Insert a new destination
  @insert
  Future<void> insertDestination(Destination destination);

  // Retrieve the last 5 destinations ordered by destinationId in descending order
  @Query('SELECT * FROM Destination ORDER BY destinationId DESC LIMIT 5')
  Future<List<Destination>> retrieveDestinationsDescending();

  // Delete a destination
  @delete
  Future<void> deleteDestination(Destination destination);
}

@dao
abstract class SettingDao {
  // Insert a new setting or replace an existing one
  @insert
  Future<void> insertSetting(Setting setting);

  // Retrieve a setting by settingType
  @Query('SELECT * FROM Setting WHERE settingType = :settingType')
  Future<Setting?> retrieveSettingByType(String settingType);

  // Delete a setting
  @delete
  Future<void> deleteSetting(Setting setting);
}

/*
@Entity(tableName: "User")
class User{

  @PrimaryKey(autoGenerate: true)
  final int? userId;

  final String userName;
  final String picPath;
  final int carbonFootprintScore;
  final int ecoScore;
  final List<int> historyId;
  final List<int> challengeId;

  User({
    this.userId,
    required this.userName,
    required this.picPath,
    required this.carbonFootprintScore,
    required this.ecoScore,
    required this.historyId,
    required this.challengeId
  });
}

@Entity(tableName:"Challenge")
class Challenge{
  @PrimaryKey(autoGenerate: true)
  final int? challengeId;

  final String challengeDescription;
  final int ecoReward;
  final int progress;

  Challenge({
    this.challengeId,
    required this.challengeDescription,
    required this.ecoReward,
    required this.progress
  });
}

@Entity(tableName:"History")
class History{
  @PrimaryKey(autoGenerate: true)
  final int? historyId;

  final String yearMonth;
  final int historyCarbonFootprint;

  History({
    this.historyId,
    required this.yearMonth,
    required this.historyCarbonFootprint
  });
}

@Entity(tableName: "Leaderboard")
class Leaderboard{
  @PrimaryKey(autoGenerate: true)
  final int? leaderboardId;

  final int rankScore;
  final String rankerName;

  Leaderboard({
    this.leaderboardId,
    required this.rankerName,
    required this.rankScore
  });

}

@Entity(tableName: "Destination")
class Destination{
  @PrimaryKey(autoGenerate: true)
  final int? destinationId;

  final LatLng mapLocaltion;
  final int carbonFootprintScore;


  Destination({
    this.destinationId,
    required this.mapLocaltion,
    required this. carbonFootprintScore
  });
}

@Entity(tableName: "Setting")
class Setting{
  @primaryKey
  final String settingType;

  final bool on;


  Setting({
    required this.settingType,
    required this.on
  });
}





 */