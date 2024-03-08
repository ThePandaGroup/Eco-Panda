import 'package:eco_panda/sync_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './page_template.dart';
import './ecarbon_history.dart';
import 'floor_model/app_database.dart';

class EProfile extends StatefulWidget {
  const EProfile({super.key});

  @override
  State<EProfile> createState() => _EProfileState();
}

class _EProfileState extends State<EProfile> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.all(12.0),
          child: Column(
            children: [ProfileSetting(), AchievementSection(),EcoHistorySection()],
          )
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

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  void _fetchCurrentUser() async {
    final localDb = Provider.of<AppDatabase>(context, listen: false);
    final user = await localDb.personDao.findUserByUid(FirebaseAuth.instance.currentUser!.uid);
    if (mounted) {
      setState(() {
        _nameController.text = user?.username ?? "N/A";
      });
    }
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
            // ProfilePictureEditing(), // Uncomment this if you have implemented it.
            const SizedBox(height: 20),
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

class AchievementSection extends StatelessWidget {
  const AchievementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Your Eco-Profile Tracker',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10),
        HorizontalScrollableCards(),
      ],
    );
  }
}

class EcoHistorySection extends StatelessWidget{
  const EcoHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Your Eco-Profile (Carbon History)',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TemplateCard(backgroundImage: "assets/bluesky.png", actiontxt: "Go to Carbon History",resPage: ECarbonHistory(),)
      ],

    );
  }

}


class TemplateCard extends StatelessWidget {
  final String backgroundImage;
  final String actiontxt;
  final double width;
  final double height;
  final resPage;// Add height parameter

  const TemplateCard({
    super.key,
    required this.backgroundImage,
    required this.actiontxt,
    this.width = 400.0, // Default width
    this.height = 100.0,
    required this.resPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFF5FBE5),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: CustomOutlinedButton(pageName: actiontxt, resPage: resPage)
        )
      ),
    );
  }
}



// The Go button
class CustomOutlinedButton extends StatelessWidget {

  final String pageName;
  final resPage;
  const CustomOutlinedButton(
      {super.key,
        required this.pageName,
        required this.resPage}
      );

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => resPage),
        );
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,

      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(pageName, style: const TextStyle(fontSize: 11, color: Colors.black)),
          const Icon(Icons.arrow_forward_ios, size: 16.0),
        ],
      ),
    );
  }
}


// Utilized in Achievement section
class HorizontalScrollableCards extends StatelessWidget {
  const HorizontalScrollableCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // Adjust the height as needed
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const <Widget>[
          ImageBackgroundCard(backgroundImage: "assets/environmental_background.png", text: "First Challenge !!!"),
          ImageBackgroundCard(backgroundImage: "assets/environmental_background.png", text: "First Challenge !!!"),
          ImageBackgroundCard(backgroundImage: "assets/environmental_background.png", text: "First Challenge !!!"),
          ImageBackgroundCard(backgroundImage: "assets/environmental_background.png", text: "First Challenge !!!"),

        ],
      ),
    );
  }
}

/*
*
*
 */
// Utilized in Achievement Section
class ImageBackgroundCard extends StatelessWidget {
  final String backgroundImage;
  final String text;
  final double width; // This will now also determine the height to form a square
  final TextStyle textStyle;

  const ImageBackgroundCard({
    Key? key,
    required this.backgroundImage,
    required this.text,
    this.width = 200.0, // Default size for width and height
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 24), // Default text style
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}


/*
*Description: A card can contain background image
* notes: It is an inheritance from customContainer Card, it is a child class
* param: child widgets, background image
 */
// Utilized in profile section
class CustomContainerCardWithBackground extends CustomContainerCard {
  final String backgroundImage;

  const CustomContainerCardWithBackground({
    Key? key,
    required Widget child,
    EdgeInsets margin = const EdgeInsets.symmetric(vertical: 10.0),
    EdgeInsets padding = const EdgeInsets.all(9.0),
    Color borderColor = const Color(0xFFF5FBE5),
    double borderWidth = 2.0,
    double borderRadius = 4.0,
    required this.backgroundImage,
  }) : super(
    key: key,
    child: child,
    margin: margin,
    padding: padding,
    borderColor: borderColor,
    borderWidth: borderWidth,
    borderRadius: borderRadius,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}


