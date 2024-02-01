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
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: CustomAppBar(),
          // temp: to show which page I am on
          body: Text('Carbon Footprint History Page'),

        ),
    );
  }
}