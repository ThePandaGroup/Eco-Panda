import 'package:eco_panda/sync_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './page_template.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'floor_model/app_database.dart';
import 'floor_model/app_entity.dart';

// Alex is doing it
class ESettings extends StatefulWidget {
  const ESettings({super.key});

  @override
  State<ESettings> createState() => _ESettingsState();
}

class _ESettingsState extends State<ESettings> {
  Person? currentUser;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  void _fetchCurrentUser() async {
    final localDb = Provider.of<AppDatabase>(context, listen: false);
    final user = await localDb.personDao.findUserByUid(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileSetting(currentUser: currentUser),
            NotificationSetting(),
            AccessPrivilegeSetting()
          ],
        ),
      ),
    );
  }
}

class ProfileSetting extends StatelessWidget{
  final Person? currentUser;
  const ProfileSetting({super.key, this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
          width: 2.0,
        ),
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(child:Text("Profile Setting",
            style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            )),
          ),
          SizedBox(height: 10),
          ProfilePictureEditing(),
          ProfileNameSetting(currentUser: currentUser),
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
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
          width: 2.0,
        ),
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
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
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
          width: 2.0,
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
          SizedBox(height: 10),
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
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

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
  final Person? currentUser;

  const ProfileNameSetting({super.key, this.currentUser});

  @override
  _ProfileNameSettingState createState() => _ProfileNameSettingState();
}

class _ProfileNameSettingState extends State<ProfileNameSetting> {
  final TextEditingController _nameController = TextEditingController();
  late String _profileName;

  @override
  void initState() {
    super.initState();
    _profileName = widget.currentUser?.username ?? "N/A";
    _nameController.text = _profileName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveProfileName() async {
    setState(() {
      _profileName = _nameController.text;
    });
    bool isUpdated = await Provider.of<SyncManager>(context, listen: false).updateUsername(_nameController.text);
    if (isUpdated) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Username successfully changed to $_profileName'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to change username'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                labelText: "New Username",
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
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            widget.featureText,
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