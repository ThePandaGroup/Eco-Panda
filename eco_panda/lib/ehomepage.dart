
import 'package:flutter/material.dart';

class EPandaHomepage extends StatefulWidget {
  const EPandaHomepage({super.key});

  @override
  State<EPandaHomepage> createState() => _EPandaHomepageState();
}

class _EPandaHomepageState extends State<EPandaHomepage> {
  // Widget _buildTransportButton(String mode) {
  //   return ElevatedButton(
  //     onPressed: () {
  //       // Handle transportation mode selection
  //     },
  //     child: Text(mode),
  //   );
  // }
// test
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5FBE5),
          title: Row(
            children: <Widget>[
              Image.asset(
                'assets/ecopanda_nobg.png', // Replace with your actual logo asset path
                fit: BoxFit.cover,
                height: 50.0, // You can adjust the size to fit your design
              ),
              SizedBox(width: 5),
              // Provides some space between the logo and the text
              Text('ECO-Panda',
                style: const TextStyle(fontWeight: FontWeight.bold,),
              ),
            ],
          ),
        ),
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
                              Text('View Details', style: TextStyle(fontSize: 11)),
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
      ),
    );
  }
}