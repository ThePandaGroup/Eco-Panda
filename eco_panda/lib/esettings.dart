import 'package:flutter/material.dart';
import './page_template.dart';

// Alex is doing it
class ESettings extends StatefulWidget {
  const ESettings({super.key});

  @override
  State<ESettings> createState() => _ESettingsState();
}

class _ESettingsState extends State<ESettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body:const SingleChildScrollView(
        child: Column(
          children: [

            NotificationSetting(),
            AccessPrivilegeSetting()
          ],
        ),
      ),
    );
  }
}

class ProfileSetting extends StatelessWidget{
  const ProfileSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class NotificationSetting extends StatelessWidget{
  const NotificationSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0), // Add some padding inside the container
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue, // Set the color of the border
          width: 2.0, // Set the width of the border
        ),
        color: Colors.green,
        borderRadius: BorderRadius.circular(10), // Optional: if you want rounded corners
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min, // Use min to fit content
        children: <Widget>[
          Center(child: Text("Notifications")),
          SizedBox(height: 10), // Add some space between the text and the first toggle
          ToggleContainerCard(featureText: "Pop-up Notification"),
          ToggleContainerCard(featureText: "Email Notification")
        ],
      ),
    );
  }
}

class AccessPrivilegeSetting extends StatelessWidget{
  const AccessPrivilegeSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0), // Add some padding inside the container
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue, // Set the color of the border
          width: 2.0, // Set the width of the border
        ),
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(10), // Optional: if you want rounded corners
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min, // Use min to fit content
        children: <Widget>[
          Center(child: Text("Permission Access")),
          SizedBox(height: 10), // Add some space between the text and the first toggle
          ToggleContainerCard(featureText: "Camera"),
          ToggleContainerCard(featureText: "GPS"),
          ToggleContainerCard(featureText: "Contacts"),
          ToggleContainerCard(featureText: "Other Features"),
        ],
      ),
    );
  }
}



class ToggleContainerCard extends StatefulWidget {
  final String featureText; // Add featureText as a parameter

  const ToggleContainerCard({Key? key, required this.featureText}) : super(key: key); // Include it in the constructor

  @override
  _ToggleContainerState createState() => _ToggleContainerState();
}

class _ToggleContainerState extends State<ToggleContainerCard> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      // Optionally add decoration to the Container
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            widget.featureText, // Use the featureText parameter
            style: const TextStyle(fontSize: 16),
          ),
          Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }
}