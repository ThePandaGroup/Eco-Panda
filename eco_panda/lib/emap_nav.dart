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
  late GoogleMapController mapController;
  final LatLng _defaultCenter = const LatLng(-23.5557714, -46.6395571);
  final TextEditingController _destinationController = TextEditingController();

  List<String> _autocompleteSuggestions = [];
  bool _showAutocompleteSuggestions = false;

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

  Future<String?> fetchUrl(Uri uri, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  void placeAutocomplete(String query) async {
    if (query.isEmpty) {
      setState(() {
        _autocompleteSuggestions = [];
      });
      return;
    }

    Uri uri = Uri.https("maps.googleapis.com",
        'maps/api/place/autocomplete/json',
        {
          "input": query,
          "key": "AIzaSyAtQi-0iBagmCc7MwUiEmgWDb_pF1abWeY",
        });

    String? response = await fetchUrl(uri);
    if (response != null) {
      final jsonResponse = json.decode(response);
      final predictions = jsonResponse['predictions'];
      setState(() {
        _autocompleteSuggestions = List<String>.from(predictions.map((p) => p['description']));
        _showAutocompleteSuggestions = _autocompleteSuggestions.isNotEmpty;
      });
    } else {
      setState(() {
        _autocompleteSuggestions = [];
        _showAutocompleteSuggestions = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          _autocompleteSuggestions = [];
        });
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
                  suffixIcon: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        _destinationController.clear();
                        _autocompleteSuggestions = [];
                        _showAutocompleteSuggestions = false;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                onChanged: (value) {
                  placeAutocomplete(value);
                },
              ),
            ),
            if (_showAutocompleteSuggestions)
              Expanded(
                child: ListView.separated(
                  itemCount: _autocompleteSuggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_autocompleteSuggestions[index]),
                      onTap: () {
                        _destinationController.text = _autocompleteSuggestions[index];
                        setState(() {
                          _autocompleteSuggestions = [];
                          _showAutocompleteSuggestions = false;
                        });
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(); // Add a one-line divider
                  },
                ),
              ),
            ElevatedButton(
              onPressed: () {
                placeAutocomplete("Seattle");
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