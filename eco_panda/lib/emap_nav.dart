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
          // body: SingleChildScrollView(
          bottomNavigationBar: QuickToolbar(
            currentIndex: 0, // The index for the current page
            onItemSelected: (index) {
              // Handle item tap
            },
          ),

        ),
    );
  }
}
