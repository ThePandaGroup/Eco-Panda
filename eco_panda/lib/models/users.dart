class User {
  int id;
  String username;
  int carbonFootprintScore;
  int ecoScore;
  List<Map<String, dynamic>> history;



  User({
    required this.id,
    required this.username,
    required this.carbonFootprintScore,
    required this.ecoScore,
    required this.history,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'carbonFootprintScore': carbonFootprintScore,
      'ecoScore': ecoScore,
      'history': history,
    };
  }
}

