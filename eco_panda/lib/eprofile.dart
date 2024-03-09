import 'package:eco_panda/sync_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'floor_model/app_database.dart';
import 'floor_model/app_entity.dart';

class EProfile extends StatefulWidget {
  const EProfile({super.key});

  @override
  State<EProfile> createState() => _EProfileState();
}

class _EProfileState extends State<EProfile> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.all(12.0),
          child: Column(
            children: [ProfileSetting(), RecentDestinationHistory()],
          )
    );
  }
}

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({super.key});

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  final TextEditingController _nameController = TextEditingController();
  String currentAvatar = 'assets/avatar.png';
  final List<String> defaultAvatars = [
    'assets/avatar.png',
    'assets/avatar1.png',
    'assets/avatar2.jpeg',
    'assets/avatar3.jpeg',
    'assets/avatar4.jpeg',
    'assets/avatar5.jpeg',
  ];

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  void _fetchCurrentUser() async {
    final localDb = Provider.of<AppDatabase>(context, listen: false);
    final user = await localDb.personDao.findUserByUid(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      _nameController.text = user?.username ?? "N/A";
      currentAvatar = user?.picPath ?? 'assets/avatar.png';
    });
  }

  void _saveProfileName() async {
    bool isUpdated = await Provider.of<SyncManager>(context, listen: false).updateUsername(_nameController.text);
    if (isUpdated) {
      _fetchCurrentUser();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username successfully changed'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to change username'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showChangeUsernameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Username'),
          content: TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: "New Username",
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                _saveProfileName();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAvatarSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Avatar'),
          content: SingleChildScrollView(
            child: Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: defaultAvatars.map((String avatar) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      currentAvatar = avatar;
                      Provider.of<SyncManager>(context, listen: false).updatePicPath(avatar);
                    });
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage(avatar),
                    radius: 40,
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void _signOut(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Sign Out"),
          content: const Text("Are you sure you want to sign out?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Sign Out"),
              onPressed: () async {
                Navigator.of(context).pop();
                await FirebaseAuth.instance.signOut();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Center(
              child: Text(
                "Profile Setting",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _showAvatarSelectionDialog,
              child: CircleAvatar(
                backgroundImage: AssetImage(currentAvatar),
                radius: 50,
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: const Text("Username", style: TextStyle(fontSize: 16)),
            ),
            Container(
              padding: const EdgeInsets.only(left: 12, right: 3),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      _nameController.text,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: _showChangeUsernameDialog,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _signOut(context),
              icon: const Icon(Icons.logout),
              label: const Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}

class RecentDestinationHistory extends StatefulWidget {
  const RecentDestinationHistory({super.key});

  @override
  State<RecentDestinationHistory> createState() => _RecentDestinationHistoryState();
}

class _RecentDestinationHistoryState extends State<RecentDestinationHistory> {
  List<Destination> _recentDestinations = [];

  @override
  void initState() {
    super.initState();
    _loadDestinations();
  }

  void _loadDestinations() async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final destinations = await Provider.of<AppDatabase>(context, listen: false).destinationDao.retrieveDestinationsByUid(userId);
    setState(() {
      _recentDestinations = List.from(destinations.reversed.take(2));
    });
  }

  void _deleteDestination(Destination destination) async {
    await Provider.of<AppDatabase>(context, listen: false).destinationDao.deleteDestination(destination);
    _loadDestinations();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Recent Destinations',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
    _recentDestinations.isEmpty
            ? Center(child: Text("No recent destinations"))
            :SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _recentDestinations.length,
        itemBuilder: (context, index) {
          final destination = _recentDestinations[index];
          return ListTile(
            leading: Icon(Icons.location_pin),
            title: Text(destination.address),
            subtitle: Text("Earned Eco Score: ${destination.carbonFootprintScore}"),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteDestination(destination),
            ),
          );
        },
      ),
      ),

      ],
    );
  }
}

