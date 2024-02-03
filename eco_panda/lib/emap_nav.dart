import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './page_template.dart';

class EMapNav extends StatefulWidget {
  const EMapNav({super.key});

  @override
  State<EMapNav> createState() => _EMapNavState();
}

class _EMapNavState extends State<EMapNav> {
  static const mapsApiKey = String.fromEnvironment('GOOGLE_MAPS_API_KEY');
  late GoogleMapController mapController;
  final LatLng _defaultCenter = const LatLng(-23.5557714, -46.6395571);
  final TextEditingController _destinationController = TextEditingController();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _locateMe();
  }

  Future<void> _locateMe() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text('Location permission denied. Returning to the homepage...'),
        ),
        duration: Duration(seconds: 3),
        ),
      );
      await Future.delayed(Duration(seconds: 3));
      Navigator.of(context).pop();
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 15.0,
      ),
    ));
  }

  List<String> _autocompleteResults = [];

  Future<void> _getAutocomplete(String search) async {
    final String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?'
        'input=$search&'
        'key=$mapsApiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final predictions = jsonResponse['predictions'] as List;
        setState(() {
          _autocompleteResults = predictions.map((p) => p['description'] as String).toList();
        });
      } else {
        // Handle error or no results
      }
    } catch (e) {
      // Handle network error
    }
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
        body: Column(
          children: [
            Expanded(
              child: GoogleMap(
                zoomControlsEnabled: true,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _defaultCenter,
                  zoom: 15.0,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _destinationController,
                decoration: InputDecoration(
                  hintText: 'Enter destination',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _getAutocomplete(value); // Get suggestions on text change
                  } else {
                    setState(() {
                      _autocompleteResults = []; // Clear results if input is cleared
                    });
                  }
                },
              ),
            ),
            // Conditional rendering based on whether there are autocomplete results
            if (_destinationController.text.isNotEmpty && _autocompleteResults.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _autocompleteResults.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_autocompleteResults[index]),
                      onTap: () {
                        _destinationController.text = _autocompleteResults[index];
                        setState(() {
                          _autocompleteResults = [];
                        });
                      },
                    );
                  },
                ),
              ),
            ElevatedButton(
              onPressed: () {
                // Trigger navigation to the entered destination
              },
              child: Text('Navigate'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed from the widget tree
    _destinationController.dispose();
    super.dispose();
  }
}