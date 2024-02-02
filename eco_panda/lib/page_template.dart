import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './ehomepage.dart';
import './eprofile.dart';
import './echallenges.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF5FBE5),
      title: Row(
        children: <Widget>[
          Image.asset(
            'assets/ecopanda_nobg.png',
            fit: BoxFit.cover,
            height: 50.0,
          ),
          SizedBox(width: 5),
          Text(
            'ECO-Panda',
            style: const TextStyle(fontWeight: FontWeight.bold,),
          ),
        ],
      ),
    );
  }
}

class EPageTemplate extends StatefulWidget {
  const EPageTemplate({super.key});

  @override
  State<EPageTemplate> createState() => _EPageTemplateState();
}

class _EPageTemplateState extends State<EPageTemplate> {
  int _selectedIndex = 0;

  final List<String> _routePaths = [
    '/home', // Home
    '/challenges', // Challenges
    '/profile', // Profile
  ];

  void _onItemTapped(int index) {
    GoRouter.of(context).go(_routePaths[index]);
  }

  @override
  Widget build(BuildContext context) {
    String currentLocation = GoRouter.of(context).location;
    _selectedIndex = _routePaths.indexOf(currentLocation);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: CustomAppBar(),
      // You can use a switch or if-else statements to decide which widget to show based on the currentLocation
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          EPandaHomepage(),
          EChallenges(),
          EProfile(),
          // other pages...
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Challenges',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}