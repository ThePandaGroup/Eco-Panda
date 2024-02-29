class User {
  int id;
  String username;
  int carbonFootprintScore;
  int ecoScore;
  List<Map<String, dynamic>> history;
  List<Map<String, dynamic>> challengesCompleted;



  User({
    required this.id,
    required this.username,
    required this.carbonFootprintScore,
    required this.ecoScore,
    required this.history,
    required this.challengesCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'carbon footprint score': carbonFootprintScore,
      'ecoScore': ecoScore,
      'history': history,
      'challenges completed': challengesCompleted,
    };
  }
}

