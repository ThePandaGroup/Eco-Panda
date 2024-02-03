import 'package:flutter/material.dart';

class ELeaderboards extends StatefulWidget {
  const ELeaderboards({Key? key}) : super(key: key);

  @override
  State<ELeaderboards> createState() => _ELeaderboardsState();
}

class _ELeaderboardsState extends State<ELeaderboards> {
  Future<List<Map<String, dynamic>>> getGlobalLeaderboard() async {
    // need to change so that it'll pull from database
    return List.generate(10, (index) => {"name": "User ${index + 1}", "points": 100 - index});
  }

  Future<Map<String, dynamic>> getUserRank() async {
    // need to change so that it'll pull from database
    return {"name": "You", "points": 50};
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leaderboard')),
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
                            return ListTile(
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
