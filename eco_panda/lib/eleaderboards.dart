import 'package:flutter/material.dart';
import './page_template.dart';

// Alex is doing it
class ELeaderboards extends StatefulWidget {
  const ELeaderboards({super.key});

  @override
  State<ELeaderboards> createState() => _ELeaderboardsState();
}

class _ELeaderboardsState extends State<ELeaderboards> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Leaderboards page'));
  }
}