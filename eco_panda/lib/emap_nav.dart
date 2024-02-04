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
  String mapsApiKey = "AIzaSyAtQi-0iBagmCc7MwUiEmgWDb_pF1abWeY";
  late GoogleMapController mapController;
  final LatLng _defaultCenter = const LatLng(-23.5557714, -46.6395571);
  final TextEditingController _destinationController = TextEditingController();
  Map<MarkerId, Marker> markers = {};

  Position? _currentPosition;

  List<SuggestionWithDistance> _autocompleteSuggestions = [];
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

    _currentPosition = await Geolocator.getCurrentPosition();
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
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
          "key": mapsApiKey,
        });

    String? response = await fetchUrl(uri);
    if (response != null) {
      final jsonResponse = json.decode(response);
      final predictions = jsonResponse['predictions'] as List;

      List<SuggestionWithDistance> tempSuggestions = predictions.map((p) {
        return SuggestionWithDistance(p['description'], 0);
      }).toList();

      for (var i = 0; i < tempSuggestions.length && i < 5; i++) {
        final coords = await getDestinationCoordinates(tempSuggestions[i].suggestion);
        if (coords != null && _currentPosition != null) {
          final distance = Geolocator.distanceBetween(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
            coords.latitude,
            coords.longitude,
          );
          tempSuggestions[i] = SuggestionWithDistance(tempSuggestions[i].suggestion, distance);
        }
      }

      tempSuggestions.sort((a, b) => a.distance.compareTo(b.distance));

      setState(() {
        _autocompleteSuggestions = tempSuggestions.take(5).toList(); // Keep top 5 sorted by distance
        _showAutocompleteSuggestions = _autocompleteSuggestions.isNotEmpty;
      });
    } else {
      setState(() {
        _autocompleteSuggestions = [];
        _showAutocompleteSuggestions = false;
      });
    }
  }

  Future<LatLng?> getDestinationCoordinates(String address) async {
    final queryParameters = {
      'address': address,
      'key': mapsApiKey,
    };
    final uri = Uri.https(
      'maps.googleapis.com',
      '/maps/api/geocode/json',
      queryParameters,
    );

    try {
      final response = await http.get(uri);
      final body = json.decode(response.body);
      if (body['status'] == 'OK') {
        final result = body['results'].first;
        final location = result['geometry']['location'];
        return LatLng(location['lat'], location['lng']);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  void onSuggestionTap(String suggestion) async {
    final coordinates = await getDestinationCoordinates(suggestion);
    print('coordinates: $coordinates');
    if (coordinates != null) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: coordinates,
          zoom: 14.0,
        ),
      ));
      addDestinationMarker(coordinates);
    }
  }

  Future<void> addDestinationMarker(LatLng destinationCoords) async {
    final markerId = MarkerId('destination_marker');

    final marker = Marker(
      markerId: markerId,
      position: destinationCoords,
      infoWindow: InfoWindow(
        title: 'Destination',
        snippet: 'Your destination point',
      ),
    );

    setState(() {
      markers.clear();
      markers[markerId] = marker;
    });
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
                markers: Set<Marker>.of(markers.values),
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
                    final suggestion = _autocompleteSuggestions[index];
                    return ListTile(
                      title: Text(suggestion.suggestion),
                      subtitle: Text('${(suggestion.distance / 1000).toStringAsFixed(2)} km'),
                      onTap: () {
                        _destinationController.text = suggestion.suggestion;
                        onSuggestionTap(suggestion.suggestion);
                        setState(() {
                          _autocompleteSuggestions = [];
                          _showAutocompleteSuggestions = false;
                        });
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
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

// Placeholder for a suggestion object that includes distance
class SuggestionWithDistance {
  final String suggestion;
  final double distance;

  SuggestionWithDistance(this.suggestion, this.distance);
}