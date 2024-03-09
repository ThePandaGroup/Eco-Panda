import 'package:floor/floor.dart';

@Entity(tableName: "Person")
class Person{

  @primaryKey
  final String userId;

  String username;
  final String picPath;
  final int ecoScore;
  final int routes;
  final int? rank;

  Person({
    required this.userId,
    required this.username,
    required this.picPath,
    required this.ecoScore,
    required this.routes,
    this.rank
  });
}

@Entity(tableName:"Challenge")
class Challenge{
  @primaryKey
  final String challengeId;

  final String title;
  final String challengeDescription;
  final int ecoReward;
  final int requirement;
  final String cType;

  Challenge({
    required this.challengeId,
    required this.title,
    required this.challengeDescription,
    required this.ecoReward,
    required this.requirement,
    required this.cType,
  });
}

@Entity(tableName: "ChallengeStatus")
class ChallengeStatus{
  @PrimaryKey(autoGenerate: true)
  final int? challengeStatusId;

  final String userId;
  final String challengeId;

  ChallengeStatus({
    this.challengeStatusId,
    required this.userId,
    required this.challengeId,
  });
}

@Entity(tableName:"History")
class History{
  @PrimaryKey(autoGenerate: true)
  final int? historyId;

  final String yearMonth;
  final int historyCarbonFootprint;
  final String userId;

  History({
    this.historyId,
    required this.yearMonth,
    required this.historyCarbonFootprint,
    required this.userId
  });
}

@Entity(tableName: "Destination")
class Destination{
  @PrimaryKey(autoGenerate: true)
  final int? destinationId;

  final String userId;
  final String address;
  final double latitude;
  final double longitude;
  final int carbonFootprintScore;


  Destination({
    this.destinationId,
    required this.userId,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this. carbonFootprintScore
  });
}