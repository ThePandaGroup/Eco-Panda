import 'package:floor/floor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@Entity(tableName: "User")
class User{

  @PrimaryKey(autoGenerate: true)
  final int? userId;

  final String userName;
  final String picPath;
  final int carbonFootprintScore;
  final int ecoScore;

  User({
    this.userId,
    required this.userName,
    required this.picPath,
    required this.carbonFootprintScore,
    required this.ecoScore
  });
}

@Entity(tableName:"Challenge")
class Challenge{
  @PrimaryKey(autoGenerate: true)
  final int? challengeId;

  final String challengeDescription;
  final int ecoReward;
  final int progress;
  final int userId;

  Challenge({
    this.challengeId,
    required this.challengeDescription,
    required this.ecoReward,
    required this.progress,
    required this.userId
  });
}

@Entity(tableName:"History")
class History{
  @PrimaryKey(autoGenerate: true)
  final int? historyId;

  final String yearMonth;
  final int historyCarbonFootprint;
  final int userId;

  History({
    this.historyId,
    required this.yearMonth,
    required this.historyCarbonFootprint,
    required this.userId
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

  final double lastitude;
  final double longitude;
  final int carbonFootprintScore;


  Destination({
    this.destinationId,
    required this.lastitude,
    required this.longitude,
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




