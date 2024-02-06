import 'package:flutter/material.dart';
import './page_template.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Import dart:io for file handling

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
            ProfileSetting(),
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
    return Container(
      padding: const EdgeInsets.all(16.0), // Add some padding inside the container
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue, // Set the color of the border
          width: 2.0, // Set the width of the border
        ),
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(10), // Optional: if you want rounded corners
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min, // Use min to fit content
        children: <Widget>[
          Center(child:Text("Profile Setting",
            style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            )),
          ),
          SizedBox(height: 10),
          ProfilePictureEditing(),
          ProfileNameSetting(),
        ],
      ),
    );
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
          Center(child: Text("Notifications",
            style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            ),),
          ),
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
          Center(child: Text("Permission Access",
            style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            ),)
          ),
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

class ProfilePictureEditing extends StatefulWidget {
  const ProfilePictureEditing({Key? key}) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePictureEditing> {
  File? _image; // Variable to hold the selected image

  // Method to handle image selection from gallery
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    // If an image is picked, update the state with the new image
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: (_image != null ? FileImage(_image!) : AssetImage('assets/avatar.png')) as ImageProvider<Object>,
            radius: 30,
          ),
          ElevatedButton(
            onPressed: _pickImage,
            child: const Text('Upload'),
          ),
        ],
      ),
    );
  }
}

class ProfileNameSetting extends StatefulWidget {
  const ProfileNameSetting({super.key});

  @override
  _ProfileNameSettingState createState() => _ProfileNameSettingState();
}

class _ProfileNameSettingState extends State<ProfileNameSetting> {
  final TextEditingController _nameController = TextEditingController();
  String _profileName = "John Hougland"; // Initial profile name

  @override
  void dispose() {
    _nameController.dispose(); // Don't forget to dispose of the controller
    super.dispose();
  }

  void _saveProfileName() {
    setState(() {
      _profileName = _nameController.text; // Update profile name with input value
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Current Name: $_profileName", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "New Profile Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfileName,
              child: Text("Save"),
            ),
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