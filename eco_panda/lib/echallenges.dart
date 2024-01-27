import 'package:flutter/material.dart';
import './page_template.dart';

class EChallenges extends StatefulWidget {
  const EChallenges({super.key});

  @override
  State<EChallenges> createState() => _EChallengesState();
}

class _EChallengesState extends State<EChallenges> {
  @override
  Widget build(BuildContext context) {
    return Center(child:Text('Challenges Page'));
  }
}