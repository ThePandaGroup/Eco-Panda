# Eco-Panda

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Template for each widget:

import 'package:flutter/material.dart';
import './page_template.dart';

class ClassName extends StatefulWidget {
  const ClassName({super.key});

  @override
  State<ClassName> createState() => _ClassNameState();
}

class _ClassNameState extends State<ClassName> {
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
          // your content
          )
          
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

