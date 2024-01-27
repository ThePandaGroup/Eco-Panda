import 'package:flutter/material.dart';
import './page_template.dart';

class EProfile extends StatefulWidget {
  const EProfile({super.key});

  @override
  State<EProfile> createState() => _EProfileState();
}

class _EProfileState extends State<EProfile> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Profile Page'));
  }
}