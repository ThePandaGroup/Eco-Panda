class Challenges {
  int id;
  String title;
  String description;
  String requirements;
  int rewardScore;

  Challenges({
    required this.id,
    required this.title,
    required this.description,
    required this.requirements,
    required this.rewardScore,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'requirements': requirements,
      'reward score': rewardScore,
    };
  }

}

