import 'package:flutter/material.dart';
import './page_template.dart';
import './ecarbon_history.dart';

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
      children: [ProfileSection()],
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
                        MaterialPageRoute(builder: (context) => ECarbonHistory()),
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

/*
*Description: A card can contain background image
* notes: It is an inheritance from customContainer Card, it is a child class
* param: child widgets, background image
 */
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
