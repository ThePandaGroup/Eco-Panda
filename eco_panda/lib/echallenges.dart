import 'package:eco_panda/sync_manager.dart';
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
    final currChallengeList = await database.challengeDao.retrieveAllChallenges();
    setState(() {
      challengeList = currChallengeList;
    });
  }

  void _fetchCurrentUser() async {
    final database = Provider.of<AppDatabase>(context, listen: false);
    final user = await database.personDao.findUserByUid(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      currentUser = user;
    });
    _fetchClaimedChallenges();
  }

  void _fetchClaimedChallenges() async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final database = Provider.of<AppDatabase>(context, listen: false);
    final claimedChallenges = await database.challengeStatusDao.retrieveChallengeStatusByUid(userId);
    setState(() {
      claimedChallengesIds = Set.from(claimedChallenges.map((e) => e.challengeId));
    });
  }

  void claimChallenge(Challenge challenge) async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final database = Provider.of<AppDatabase>(context, listen: false);

    await Provider.of<SyncManager>(context, listen: false).incrementUserEcoscore(challenge.ecoReward);
    await database.challengeStatusDao.insertChallengeStatus(ChallengeStatus(userId: userId, challengeId: challenge.challengeId));

    _fetchClaimedChallenges();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${challenge.title} completed! Reward: ${challenge.ecoReward} points')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: challengeList.map((challenge) {
          String currentProgress;
          bool isRequirementMet;

          if (challenge.cType == "ecopts") {
            currentProgress = "${currentUser?.ecoScore}/${challenge.requirement}";
            isRequirementMet = (currentUser?.ecoScore ?? 0) >= challenge.requirement;
          } else if (challenge.cType == "routes") {
            currentProgress = "${currentUser?.routes}/${challenge.requirement}";
            isRequirementMet = (currentUser?.routes ?? 0) >= challenge.requirement;
          } else {
            currentProgress = "N/A";
            isRequirementMet = false;
          }

          bool isClaimed = claimedChallengesIds.contains(challenge.challengeId);

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
                  challenge.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(
                  challenge.challengeDescription,
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: isRequirementMet && !isClaimed
                    ? ElevatedButton(
                  onPressed: () => claimChallenge(challenge),
                  child: const Text('Claim'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                )
                    : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    isClaimed ? 'Claimed' : currentProgress,
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
        }).toList(),
      ),
    );
  }
}


// Visual Display of Challenge Card
// class ChallengeCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final String currentProgress;
//   final int totalRequired;
//   final bool isRequirementMet;
//   final bool isClaimed;
//
//   const ChallengeCard({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.currentProgress,
//     required this.totalRequired,
//     this.isRequirementMet = false,
//     this.isClaimed = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: const Color(0xFFF5FBE5),
//           width: 2.0,
//         ),
//         borderRadius: BorderRadius.circular(4.0),
//       ),
//       child: Card(
//         margin: EdgeInsets.zero,
//         color: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(4.0),
//         ),
//         child: ListTile(
//           isThreeLine: true,
//           title: Text(
//             title,
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//           subtitle: Text(
//             description,
//             style: const TextStyle(fontSize: 12),
//           ),
//           trailing: isRequirementMet
//               ? ElevatedButton(
//                   onPressed: () {
//                     // Handle claim logic here
//                   },
//                   child: Text('Claim'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     foregroundColor: Colors.white,
//                   ),
//                 )
//               : Container(
//                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.green, width: 2),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: isClaimed
//                   ? Text('Claimed', style: TextStyle(color: Colors.grey))
//                   : Text(currentProgress,
//                       style: const TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green,
//                       ),
//                     ),
//                 ),
//         ),
//       ),
//     );
//   }
// }
//

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

