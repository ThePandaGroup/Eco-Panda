import '../models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<User> users = List<User>.generate(
  20,
      (i) => User(
    id: i,
    username: 'User $i',
    carbonFootprintScore: i * 10,
    ecoScore: i * 20,
    history: [
      {'date': '2022-01', 'carbon score': i * 5},
      {'date': '2022-02', 'carbon score': i * 6},
    ],
  ),
);

void uploadUsers() {
  for (var user in users) {
    FirebaseFirestore.instance.collection('users').doc(user.id.toString()).set(user.toMap());
  }
}