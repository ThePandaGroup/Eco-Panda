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

  static const String cTitle = 'Daily Challenge';
  static const String cDescrpt = 'First Eco route of the day';
  static const int cProgress = 0; //fetch from data base, placeholder value for now
  static const int cRequired = 1;

  static const String cTitleA = 'New User Challenge';
  static const String cDescriptA = 'Plan your first route';
  static const int cProgressA = 0; //fetch from data base, placeholder value for now
  static const int cRequiredA = 1;

  static const String cTitleB = 'Weekly Challenge';
  static const String cDescripB = 'I planned 10 rountes in the app !';
  static const int cProgressB = 0; //fetch from data base, placeholder value for now
  static const int cRequiredB = 10;


  @override
  void initState() {
    super.initState();
    _showChallenge();

  }

  void _showChallenge() async{
    final database = Provider.of<AppDatabase>(context, listen: false);
    final records = await database.challengeDao.retrieveAllChallenges();
    setState(() {
      challengeList = records;
    });
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:Column(
            /*children: [
              ChallengeCard(title: cTitleA, description: cDescriptA, currentProgress: cProgressA, totalRequired: cRequiredA),
              ChallengeCard(title: cTitle, description: cDescrpt, currentProgress: cProgress, totalRequired: cRequired),
              ChallengeCard(title: cTitleB, description: cDescripB, currentProgress: cProgressB, totalRequired: cRequiredB),
            ]
             */
          children: challengeList.asMap().entries.map((mapEntry) {
            int index = mapEntry.key;
            Challenge entry = mapEntry.value;
            return ChallengeCard(
                title: entry.title,
                description: entry.challengeDescription,
                currentProgress: entry.progress,
                totalRequired: 100
            );
          }).toList(),

        )
    );
  }
}

// Visual Display of Challenge Card
class ChallengeCard extends StatelessWidget {
  final String title ;
  final String description ;
  final int currentProgress;
  final int totalRequired;

  const ChallengeCard({
    super.key,
    required this.title,
    required this.description,
    required this.currentProgress,
    required this.totalRequired,
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
          title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(description,
            style: const TextStyle(fontSize: 12),
          ),
          trailing: ChallengeProgressIndicator(
            currentProgress: currentProgress,
            totalRequired: totalRequired,
          ),
        ),
      ),
    );
  }
}


// Challenge progress indicator
class ChallengeProgressIndicator extends StatelessWidget {
  final int currentProgress;
  final int totalRequired;

  const ChallengeProgressIndicator({
    super.key,
    required this.currentProgress,
    required this.totalRequired,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 2.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        '$currentProgress/$totalRequired',
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }
}