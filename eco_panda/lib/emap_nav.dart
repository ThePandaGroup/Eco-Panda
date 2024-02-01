import 'package:flutter/material.dart';
import './page_template.dart';

class EMapNav extends StatefulWidget {
  const EMapNav({super.key});

  @override
  State<EMapNav> createState() => _EMapNavState();
}

class _EMapNavState extends State<EMapNav> {
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
          body: Text('Map Navigation Page'),
          // body: SingleChildScrollView(

        ),
    );
  }
}
