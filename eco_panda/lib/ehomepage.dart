import 'package:eco_panda/floor_model/app_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './emap_nav.dart';
import './ecarbon_history.dart';
import './page_template.dart';
import './eleaderboards.dart';
import 'floor_model/app_entity.dart';

enum TransportMode { walk, bicycle, transit, drive }

class EPandaHomepage extends StatefulWidget {
  const EPandaHomepage({super.key});

  @override
  State<EPandaHomepage> createState() => _EPandaHomepageState();
}

class _EPandaHomepageState extends State<EPandaHomepage> {
  Person? currentUser;
  TransportMode? _selectedMode;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  void _fetchCurrentUser() async {
    final localDb = Provider.of<AppDatabase>(context, listen: false);
    final user = await localDb.personDao.findUserByUid(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      currentUser = user;
    });
  }

  Widget _buildTransportButton(String mode, TransportMode value) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedMode = value;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedMode == value ? Color(0xFF3CC18F) : Colors.blueGrey[50],
      ),
      child: Text(mode, style: TextStyle(color: Colors.black),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
                children: [
                  CustomContainerCard(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(currentUser?.picPath ?? 'assets/avatar.png'),
                          radius: 30,
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back, ${currentUser?.username ?? "user"}!',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Your Eco Score: ${currentUser?.ecoScore ?? 0} points',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => ECarbonHistory()),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    side: BorderSide(color: Colors.grey),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('View Your Carbon Footprints History', style: TextStyle(fontSize: 12)),
                                      Icon(Icons.arrow_forward_ios, size: 16.0),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomContainerCard(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Plan Your Route',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Choose your environmentally friendly transportation mode',
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            children: [
                              Expanded(
                                child: Wrap(
                                  spacing: 8.0,
                                  children: TransportMode.values.map((mode) {
                                    return _buildTransportButton(mode.toString().split('.').last.capitalize(), mode);
                                  }).toList(),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  print('selected mode sent: ${_selectedMode}');
                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => EMapNav(selectedMode: _selectedMode)),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(' Plan route', style: TextStyle(fontSize: 12)),
                                    Icon(Icons.arrow_forward_ios, size: 16.0),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  CustomContainerCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Rank',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.leaderboard, color: Colors.green),
                            const SizedBox(width: 8),
                            Text("${currentUser?.rank ?? "??"}. ${currentUser?.username} - ${currentUser?.ecoScore} points", style: TextStyle(fontSize: 14, color: Colors.black)),
                          ],
                        ),

                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ELeaderboards()),
                              );
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('See All Leaderboards'),
                                Icon(Icons.arrow_forward_ios, size: 16.0),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
            ),
          ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}