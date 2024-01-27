import 'package:flutter/material.dart';
import './page_template.dart';

class ESettings extends StatefulWidget {
  const ESettings({super.key});

  @override
  State<ESettings> createState() => _ESettingsState();
}

class _ESettingsState extends State<ESettings> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Setting Page'));
  }
}