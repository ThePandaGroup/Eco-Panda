
import 'package:flutter/material.dart';
import './page_template.dart';
import './emap_nav.dart';

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFF5FBE5),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Card(
                      margin: EdgeInsets.all(5.0),
                      color: Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/avatar.png'), // Placeholder for an user avatar
                        ),
                        title: Text('Welcome back'),
                        subtitle: Text('Your Eco Score: 85'),
                        trailing: OutlinedButton(
                          onPressed: () {
                            // Handle view details action
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text('View Details', style: TextStyle(fontSize: 12)),
                              Icon(Icons.arrow_forward_ios, size: 16.0),
                            ],
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFF5FBE5),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: Colors.white,
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
                                    spacing: 8.0, // Space between the buttons
                                    children: TransportMode.values.map((mode) {
                                      return _buildTransportButton(mode.toString().split('.').last.capitalize(), mode);
                                    }).toList(),
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFF5FBE5),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: Colors.white,
                      child: ListTile(
                        title: Text('Friends',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Text('Connect with friends and challenge each other to be more eco-friendly',
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing: OutlinedButton(
                          onPressed: () {
                            // Handle add friends action
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFF5FBE5),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: Colors.white,
                      child: ListTile(
                        title: Text('Challenges',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Text('Join challenges and earn badges for eco-friendly achievements',
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing: OutlinedButton(
                          onPressed: () {
                            // Handle view all challenges action
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(' View All Challenges', style: TextStyle(fontSize: 11)),
                              Icon(Icons.arrow_forward_ios, size: 16.0),
                            ],
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                // Add other widgets for the rest of the body content
                ],
            ),
          ),
        ),
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

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}