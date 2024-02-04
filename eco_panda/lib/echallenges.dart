import 'package:flutter/material.dart';

// delete this import
// Alex did it!
import './emap_nav.dart';

class EChallenges extends StatefulWidget {
  const EChallenges({super.key});

  @override
  State<EChallenges> createState() => _EChallengesState();
}

// Change things in here for the page
class _EChallengesState extends State<EChallenges> {

  static const String cTitle = 'Daily Challenge';
  static const String cDescrpt = 'First Eco route of the day';

  static const String cTitleA = 'New User Challenge';
  static const String cDescriptA = 'Plan your first route';

  static const String cTitleB = 'Weekly Challenge';
  static const String cDescripB = 'I planned 10 rountes in the app !';

  static const String cTitleC = 'Friendship Challenge';
  static const String cDescripC = 'Add your first friend';

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        child:Column(
            children: [
              ChallengeCard(title: cTitleA , description: cDescriptA ),
              ChallengeCard(title: cTitle, description: cDescrpt),
              ChallengeCard(title: cTitleB, description: cDescripB),
              ChallengeCard(title: cTitleC, description: cDescripC)
            ]
        )
    );
  }
}

// Visual Display of Challenge Card
class ChallengeCard extends StatelessWidget {
  final String title ;
  final String description ;

  const ChallengeCard({super.key, required this.title, required this.description});

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
          trailing: const CustomOutlinedButton(),
        ),
      ),
    );
  }
}


// The Join button
class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EMapNav()),
        );
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child:  const Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Join', style: TextStyle(fontSize: 11)),
          Icon(Icons.arrow_forward_ios, size: 16.0),
        ],
      ),
    );
  }
}


