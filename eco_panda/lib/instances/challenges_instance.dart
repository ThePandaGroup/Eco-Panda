import '../models/challenges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<Challenges> challenges = List<Challenges>.generate(
  20,
      (i) => Challenges(
    id: i + 1,
    title: 'Challenge ${i + 1}',
    description: 'This is the description for Challenge ${i + 1}',
    requirements: 'These are the requirements for Challenge ${i + 1}',
    rewardScore: (i + 1) * 10,
  ),
);

void uploadChallenges() {
  for (var challenge in challenges) {
    FirebaseFirestore.instance.collection('challenges').doc(challenge.id.toString()).set(challenge.toMap());
  }
}