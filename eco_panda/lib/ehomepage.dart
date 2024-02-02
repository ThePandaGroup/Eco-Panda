
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './emap_nav.dart';
import './ecarbon_history.dart';
import './efriends.dart';

enum TransportMode { walking, biking, bus, carpooling }

class EPandaHomepage extends StatefulWidget {
  const EPandaHomepage({super.key});

  @override
  State<EPandaHomepage> createState() => _EPandaHomepageState();
}

class _EPandaHomepageState extends State<EPandaHomepage> {
  TransportMode? _selectedMode;

  Widget _buildTransportButton(String mode, TransportMode value) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedMode = value;
        });
        // Add additional logic for transportation mode selection here if needed
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedMode == value ? Color(0xFF3CC18F) : Colors.blueGrey[50],
      ),
      child: Text(mode, style: TextStyle(color: Colors.black),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
                children: [
                  CustomContainerCard(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/avatar.png'), // Placeholder for an user avatar
                          radius: 30,
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back, John!',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Your Eco Score: 85',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: OutlinedButton(
                                  onPressed: () {
                                    GoRouter.of(context).go('/carbon-history');
                                  },
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    side: BorderSide(color: Colors.grey),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('View Your Carbon Footprints History', style: TextStyle(fontSize: 12)),
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
                  ),
                  CustomContainerCard(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Plan Your Route',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Choose your environmentally friendly transportation mode',
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            children: [
                              Expanded(
                                child: Wrap(
                                  spacing: 8.0,
                                  children: TransportMode.values.map((mode) {
                                    return _buildTransportButton(mode.toString().split('.').last.capitalize(), mode);
                                  }).toList(),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => EMapNav()),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(' Plan route', style: TextStyle(fontSize: 12)),
                                    Icon(Icons.arrow_forward_ios, size: 16.0),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomContainerCard(
                    child: ListTile(
                      title: Text('Friends',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text('Connect with friends and challenge each other to be more eco-friendly',
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: OutlinedButton(
                        onPressed: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => EFriends()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(' Add Friends', style: TextStyle(fontSize: 11)),
                            Icon(Icons.arrow_forward_ios, size: 16.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
            ),
          ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class CustomContainerCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;

  const CustomContainerCard({
    Key? key,
    required this.child,
    this.margin = const EdgeInsets.symmetric(vertical: 10.0),
    this.padding = const EdgeInsets.all(9.0),
    this.borderColor = const Color(0xFFF5FBE5),
    this.borderWidth = 2.0,
    this.borderRadius = 4.0,
  }) : super(key: key);

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
      ),
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
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
