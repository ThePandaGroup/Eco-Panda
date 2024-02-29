import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> getLeaderboard() async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('leaderboards').get();
  List<Map<String, dynamic>> leaderboard = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  leaderboard.sort((a, b) => b['ecoScore'].compareTo(a['ecoScore']));
  return leaderboard;
}


// Get a specific user's rank in the leaderboard
Future<int> getUserRank(String userId) async {
  List<Map<String, dynamic>> leaderboard = await getLeaderboard();
  for (int i = 0; i < leaderboard.length; i++) {
    if (leaderboard[i]['id'] == userId) {
      return i + 1;  // Rank is index + 1
    }
  }
  return -1;  // User not found in leaderboard
}

// Update a user's score in the leaderboard
Future<void> updateUserScore(String userId, int newScore) async {
  await FirebaseFirestore.instance.collection('leaderboards').doc(userId).update({'ecoScore': newScore});
}