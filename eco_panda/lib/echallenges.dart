import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './floor_model/app_entity.dart';
import './floor_model/app_database.dart';

class EChallenges extends StatefulWidget {
  const EChallenges({super.key});

  @override
  State<EChallenges> createState() => _EChallengesState();
}

// Change things in here for the page
class _EChallengesState extends State<EChallenges> {
  List<Challenge> challengeList = [];
  Person? currentUser;
  Set<String> claimedChallengesIds = Set();

  @override
  void initState() {
    super.initState();
    _retrieveAllChallenge();
    _fetchCurrentUser();
  }

  void _retrieveAllChallenge() async {
    final database = Provider.of<AppDatabase>(context, listen: false);
    final currChallengeList = await database.challengeDao
        .retrieveAllChallenges();
    setState(() {
      challengeList = currChallengeList;
    });
  }

  void _fetchCurrentUser() async {
    final localDb = Provider.of<AppDatabase>(context, listen: false);
    final user = await localDb.personDao.findUserByUid(
        FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      currentUser = user;
    });
    _fetchClaimedChallenges();
  }

  void _fetchClaimedChallenges() async {
    final localDb = Provider.of<AppDatabase>(context, listen: false);
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final claimedChallenges = await localDb.challengeStatusDao.retrieveChallengeStatusByUid(userId);
    setState(() {
      claimedChallengesIds = Set.from(claimedChallenges.map((e) => e.challengeId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final ecoScore = currentUser?.ecoScore ?? 0;
    final routes = currentUser?.routes ?? 0;

    return SingleChildScrollView(
      child: Column(
        children: challengeList.map((challenge) {
          String currentProgress;
          bool isRequirementMet;

          if (challenge.cType == "ecopts") {
            currentProgress = "$ecoScore/${challenge.requirement}";
            isRequirementMet = ecoScore >= challenge.requirement;
          } else if (challenge.cType == "routes") {
            currentProgress = "$routes/${challenge.requirement}";
            isRequirementMet = routes >= challenge.requirement;
          } else {
            currentProgress = "N/A";
            isRequirementMet = false;
          }

          return ChallengeCard(
            title: challenge.title,
            description: challenge.challengeDescription,
            currentProgress: currentProgress,
            totalRequired: challenge.requirement,
            isRequirementMet: isRequirementMet,
          );
        }).toList(),
      ),
    );
  }
}

// Visual Display of Challenge Card
class ChallengeCard extends StatelessWidget {
  final String title;
  final String description;
  final String currentProgress;
  final int totalRequired;
  final bool isRequirementMet;
  final bool isClaimed;

  const ChallengeCard({
    super.key,
    required this.title,
    required this.description,
    required this.currentProgress,
    required this.totalRequired,
    this.isRequirementMet = false,
    this.isClaimed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFF5FBE5),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: ListTile(
          isThreeLine: true,
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(
            description,
            style: const TextStyle(fontSize: 12),
          ),
          trailing: isRequirementMet
              ? ElevatedButton(
                  onPressed: () {
                    // Handle claim logic here
                  },
                  child: Text('Claim'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: isClaimed
                  ? Text('Claimed', style: TextStyle(color: Colors.grey))
                  : Text(currentProgress,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                ),
        ),
      ),
    );
  }
}


/*
class ClaimButton extends StatelessWidget {

  const ClaimButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Colors.green,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child:ElevatedButton(
          onPressed: onPressed,
          child: child
      ),
      /*
      Text(
        "claim",
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),

       */

    );
  }
}

class CompleteButton extends StatelessWidget {

  const CompleteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 2.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: const Text(
        "claimed",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }
}
*/

