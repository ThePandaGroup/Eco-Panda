import 'package:flutter/material.dart';
import './page_template.dart';

class ECarbonHistory extends StatefulWidget {
  const ECarbonHistory({super.key});

  @override
  State<ECarbonHistory> createState() => _ECarbonHistoryState();
}

class _ECarbonHistoryState extends State<ECarbonHistory> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Carbon History'));
  }
}