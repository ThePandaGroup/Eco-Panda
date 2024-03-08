import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_panda/page_template.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'floor_model/app_database.dart';
import 'floor_model/app_entity.dart';

class ELeaderboards extends StatefulWidget {
  const ELeaderboards({Key? key}) : super(key: key);

  @override
  State<ELeaderboards> createState() => _ELeaderboardsState();
}

class _ELeaderboardsState extends State<ELeaderboards> {
  late Future<List<Map<String, dynamic>>> _leaderboardData;
  late Future<Person?> _currentUser;

  @override
  void initState() {
    super.initState();
    _leaderboardData = getGlobalLeaderboard();
    _currentUser = _fetchCurrentUser();
  }

  Future<Person?> _fetchCurrentUser() async {
    final localDb = Provider.of<AppDatabase>(context, listen: false);
    return await localDb.personDao.findUserByUid(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<List<Map<String, dynamic>>> getGlobalLeaderboard() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('ecoScore', descending: true)
        .limit(10)
        .get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
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
              future: _leaderboardData,
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
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Top 10 Leaderboard',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: Icon(Icons.refresh),
                              onPressed: () {
                                setState(() {
                                  _leaderboardData = getGlobalLeaderboard();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
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
                            } else {
                              leadingIcon = Text('${index + 1}');
                            }
                            return ListTile(
                              leading: leadingIcon,
                              title: Text(entry["username"]),
                              trailing: Text('${entry["ecoScore"]} pts'),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          FutureBuilder<Person?>(
            future: _currentUser,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError || snapshot.data == null) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Error: Unable to fetch user data",
                    style: TextStyle(
                      color: Colors.red,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                );
              } else {
                return Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your Rank', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black,),),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.person, color: Colors.blueGrey),
                                  SizedBox(width: 8),
                                  Text(
                                    snapshot.data?.username ?? "N/A",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text('Eco Score: ${snapshot.data?.ecoScore}', style: TextStyle(fontSize: 16),),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Rank: ${snapshot.data?.rank ?? "Not ranked"}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}