import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './ehomepage.dart';
import './eprofile.dart';
import './echallenges.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize;

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
  String uid = FirebaseAuth.instance.currentUser?.uid ?? "null";

  static const List<Widget> _pageWidgets = <Widget>[
    EPandaHomepage(),
    EChallenges(),
    EProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: CustomAppBar(),
        body: _pageWidgets.elementAt(_selectedIndex),
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
      ),
    );
  }
}

class CustomContainerCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;

  const CustomContainerCard({
    Key? key,
    required this.child,
    this.margin = const EdgeInsets.symmetric(vertical: 10.0),
    this.padding = const EdgeInsets.all(9.0),
    this.borderColor = const Color(0xFFF5FBE5),
    this.borderWidth = 2.0,
    this.borderRadius = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}