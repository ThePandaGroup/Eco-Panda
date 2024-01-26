
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF5FBE5),
      automaticallyImplyLeading: false,
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

class QuickToolbar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onItemSelected;

  const QuickToolbar({
    Key? key,
    required this.currentIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  _QuickToolbarState createState() => _QuickToolbarState();
}

class _QuickToolbarState extends State<QuickToolbar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onItemSelected,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        // Add more items as needed
      ],
    );
  }
}