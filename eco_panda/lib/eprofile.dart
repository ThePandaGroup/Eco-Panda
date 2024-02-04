import 'package:flutter/material.dart';
import './page_template.dart';
import './ecarbon_history.dart';
import './emap_nav.dart';
import './esettings.dart';

// Alex is doing it lmao
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
      children: [ProfileSection(), AchievementSection(),EcoHistorySection(), SettingSection()],
    )
    )
    );
  }
}

class ProfileSection extends StatelessWidget{
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context){
    return CustomContainerCardWithBackground(
      backgroundImage: "assets/environmental_background.png",
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/avatar.png'), // Placeholder for an user avatar
            radius: 30,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'John Hougland',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Your Eco Score: 85',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ESettings()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: const BorderSide(color: Colors.grey),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Edit Profile',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12)
                        ),
                        Icon(Icons.arrow_forward_ios, size: 16.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AchievementSection extends StatelessWidget {
  const AchievementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column( // Changed from Row to Column
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0), // Adjust as needed
          child: Text(
            'Your Eco-Profile Tracker',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10), // Add some spacing
        HorizontalScrollableCards(), // This will now be below the text
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
          padding: EdgeInsets.symmetric(horizontal: 8.0), // Adjust as needed
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


class SettingSection extends StatelessWidget{
  const SettingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0), // Adjust as needed
          child: Text(
            'Setting',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TemplateCard(backgroundImage: "assets/machinery.png", actiontxt: "Go to Setting",resPage: ESettings())
      ],

    );
  }

}


class TemplateCard extends StatelessWidget {
  final String backgroundImage; // Add backgroundImage parameter
  final String actiontxt;
  final double width; // Add width parameter
  final double height;
  final resPage;// Add height parameter

  const TemplateCard({
    super.key,
    required this.backgroundImage,
    required this.actiontxt,
    this.width = 400.0, // Default width
    this.height = 100.0,
    required this.resPage, // Default height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Set the width
      height: height, // Set the height
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFF5FBE5),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
        image: DecorationImage(
          image: AssetImage(backgroundImage), // Use the backgroundImage
          fit: BoxFit.cover, // Cover the container bounds
        ),
      ),
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.transparent, // Make the Card background transparent to show the Container's background
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(pageName, style: const TextStyle(fontSize: 11)),
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
          // Add more cards as needed
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
      clipBehavior: Clip.antiAlias, // Ensures the image is clipped to the card's border radius
      child: Container(
        width: width,
        height: width, // Set height equal to width to make it a square
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
    // Use the same structure but add a BoxDecoration with an image
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
        color: Colors.transparent, // Make card background transparent
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


