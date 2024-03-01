import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_panda/page_template.dart';
import 'package:flutter/material.dart';

class ELeaderboards extends StatefulWidget {
  const ELeaderboards({Key? key}) : super(key: key);

  @override
  State<ELeaderboards> createState() => _ELeaderboardsState();
}

class _ELeaderboardsState extends State<ELeaderboards> {
  // Future<List<Map<String, dynamic>>> getGlobalLeaderboard() async {
  //   return List.generate(10, (index) => {"name": "User ${index + 1}", "points": 100 - index});
  // }

  Future<List<Map<String, dynamic>>> getGlobalLeaderboard() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('ecoScore', descending: true)
        .limit(10)
        .get();
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return {
        'name': data['username'] ?? 'N/A',
        'points': data['ecoScore'] ?? 0,
      };
    }).toList();
  }

  Future<Map<String, dynamic>> getUserRank() async {
    return {"name": "You", "points": 50};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: getGlobalLeaderboard(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Top 10 Users', style: Theme.of(context).textTheme.headline6),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            var entry = snapshot.data![index];
                            Widget? leadingIcon;
                            if (index == 0) {
                              leadingIcon = Icon(Icons.emoji_events, color: Colors.amber);
                            } else if (index == 1) {
                              leadingIcon = Icon(Icons.emoji_events, color: Colors.grey);
                            } else if (index == 2) {
                              leadingIcon = Icon(Icons.emoji_events, color: Colors.brown);
                            }
                            return ListTile(
                              leading: leadingIcon,
                              title: Text(entry["name"]),
                              trailing: Text('${entry["points"]} pts'),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Your Rank', style: Theme.of(context).textTheme.titleLarge),
          ),
          FutureBuilder<Map<String, dynamic>>(
            future: getUserRank(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return ListTile(
                  title: Text(snapshot.data?["name"] ?? "N/A"),
                  trailing: Text('${snapshot.data?["points"] ?? 0} pts'),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}