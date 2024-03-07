import 'package:floor/floor.dart';
import 'app_entity.dart';

@dao
abstract class PersonDao {
  @insert
  Future<void> insertUser(Person user);

  @Query("SELECT * FROM User")
  Future<List<Person>> retrieveOnlyUser();

  @Query('SELECT * FROM User WHERE userId = :uid')
  Future<Person?> findUserByUid(String uid);

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
  Future<int?>removeUser(Person user);

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

  // Retrieve all history records
  @Query('SELECT * FROM History')
  Future<List<History>> retrieveHistories();

  // Sum all historyCarbonFootprint values in the History table
  @Query('SELECT COALESCE(SUM(historyCarbonFootprint), 0) FROM History')
  Future<int?> sumHistoryCarbonFootprint();

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

  // Retrieve all records
  @Query('SELECT * FROM Destination')
  Future<List<Destination>> retrievePastDestinations();

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