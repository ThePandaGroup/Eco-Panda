import 'package:floor/floor.dart';

@Entity(tableName: "Person")
class Person{

  @primaryKey
  final String userId;

  String username;
  final String picPath;
  final int ecoScore;
  final int? rank;

  Person({
    required this.userId,
    required this.username,
    required this.picPath,
    required this.ecoScore,
    this.rank
  });
}

@Entity(tableName:"Challenge")
class Challenge{
  @PrimaryKey(autoGenerate: true)
  final int? challengeId;

  final String title;
  final String challengeDescription;
  final int ecoReward;
  final int requirement;
  final int progress;
  final String userId;
  final String cType;

  Challenge({
    this.challengeId,
    required this.title,
    required this.challengeDescription,
    required this.ecoReward,
    required this.requirement,
    required this.progress,
    required this.cType,
    required this.userId
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

@Entity(tableName: "Setting")
class Setting{
  @primaryKey
  final String settingType;

  final bool on;
  final String userId;

  Setting({
    required this.settingType,
    required this.on,
    required this.userId
  });
}




