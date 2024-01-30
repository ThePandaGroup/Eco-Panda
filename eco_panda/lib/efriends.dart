import 'package:flutter/material.dart';
import './page_template.dart';

// Alex is doing it
class EFriends extends StatefulWidget {
  const EFriends({super.key});

  @override
  State<EFriends> createState() => _EFriendsState();
}

class _EFriendsState extends State<EFriends> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Friends Page'));
  }
}