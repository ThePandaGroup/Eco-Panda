import 'package:floor/floor.dart';
import 'app_entity.dart';

@dao
abstract class PersonDao {
  @insert
  Future<void> insertUser(Person user);

  @Query("SELECT * FROM Person")
  Future<List<Person>> retrieveOnlyUser();

  @Query('SELECT * FROM Person WHERE userId = :uid')
  Future<Person?> findUserByUid(String uid);

  @Query("UPDATE Person SET picPath = :picPath WHERE userId = :userId")
  Future<void> updatePicPath(String userId, String picPath);

  @Query("UPDATE Person SET ecoScore = :ecoScore WHERE userId = :userId")
  Future<void> updateEcoScore(String userId, int ecoScore);

  @Query("UPDATE Person SET rank = :rank WHERE userId = :userId")
  Future<void> updateRank(String userId, int rank);

  @Query("UPDATE Person SET username = :username WHERE userId = :userId")
  Future<void> updateUsername(String userId, String username);

  @Query('SELECT picPath FROM Person WHERE userId = :userId')
  Future<String?> retrievePicPath(String userId);

  @Query('SELECT ecoScore FROM Person WHERE userId = :userId')
  Future<int?> retrieveEcoScore(String userId);

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

  @Query('SELECT * FROM Challenge WHERE userId = :uid')
  Future<List<Challenge>> findChallengesByUid(String uid);

  // Retrieve a challenge by challengeId
  @Query('SELECT * FROM Challenge WHERE challengeId = :challengeId')
  Future<Challenge?> retrieveChallengeById(int challengeId);

  // Retrieve challenges based on userId
  @Query('SELECT * FROM Challenge WHERE userId = :userId')
  Future<List<Challenge>> retrieveChallengesByUserId(String userId);

  // Update ecoReward by challengeId
  @Query('UPDATE Challenge SET ecoReward = :ecoReward WHERE challengeId = :challengeId')
  Future<void> updateEcoReward(int challengeId, int ecoReward);

  // Update progress by challengeId and userId (assuming challengeId is unique and sufficient to identify a challenge, the userId condition may be redundant, but included as per request)
  @Query('UPDATE Challenge SET progress = :progress WHERE challengeId = :challengeId AND userId = :userId')
  Future<void> updateProgress(int challengeId, String userId, int progress);

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

  // Retrieve all history records by userId
  @Query('SELECT * FROM History WHERE userId = :userId')
  Future<List<History>> retrieveHistoriesByUserId(String userId);

  // Sum all historyCarbonFootprint values in the History table
  @Query('SELECT COALESCE(SUM(historyCarbonFootprint), 0) FROM History')
  Future<int?> sumHistoryCarbonFootprint();

}

@dao
abstract class DestinationDao {
  // Insert a new destination
  @insert
  Future<void> insertDestination(Destination destination);

  // Retrieve all records
  @Query('SELECT * FROM Destination')
  Future<List<Destination>> retrievePastDestinations();

  // Retrieve a destination by userId
  @Query('SELECT * FROM Destination WHERE userId = :userId')
  Future<List<Destination>> retrieveDestinationsByUid(String userId);

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

  // Retrieve all settings by userId
  @Query('SELECT * FROM Setting WHERE userId = :userId')
  Future<List<Setting>> retrieveSettingsByUid(String userId);

  // Delete a setting
  @delete
  Future<void> deleteSetting(Setting setting);
}