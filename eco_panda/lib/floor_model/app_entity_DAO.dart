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

  @Query("UPDATE Person SET routes = :newRoute WHERE userId = :userId")
  Future<void> updateRoute(String userId, int newRoute);

  @Query('SELECT picPath FROM Person WHERE userId = :userId')
  Future<String?> retrievePicPath(String userId);

  @Query('SELECT ecoScore FROM Person WHERE userId = :userId')
  Future<int?> retrieveEcoScore(String userId);

  @Query('SELECT routes FROM Person WHERE userId = :userId')
  Future<int?> retrieveRoute(String userId);

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
  Future<Challenge?> retrieveChallengeById(String challengeId);

  @Query('DELETE FROM Challenge')
  Future<void> deleteAllChallenges();

  @delete
  Future<int?>removeChallenge(Challenge challenge);
}

@dao
abstract class ChallengeStatusDao {
  @insert
  Future<void> insertChallengeStatus(ChallengeStatus challengeStatus);

  // Retrieve all challenge statuses
  @Query('SELECT * FROM ChallengeStatus')
  Future<List<ChallengeStatus>> retrieveAllChallengeStatuses();

  // Retrieve a challenge status by userId
  @Query('SELECT * FROM ChallengeStatus WHERE userId = :userId')
  Future<List<ChallengeStatus>> retrieveChallengeStatusByUid(String userId);

  @delete
  Future<void> deleteChallengeStatus(ChallengeStatus challengeStatus);
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