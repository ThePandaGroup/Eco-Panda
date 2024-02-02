import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import './page_template.dart';

class EMapNav extends StatefulWidget {
  const EMapNav({super.key});

  @override
  State<EMapNav> createState() => _EMapNavState();
}

class _EMapNavState extends State<EMapNav> {
  late GoogleMapController mapController;
  final LatLng _defaultCenter = const LatLng(-23.5557714, -46.6395571); // Default fallback location

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _locateMe();
  }

  Future<void> _locateMe() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location permission denied. Returning to the homepage...'),
          duration: Duration(seconds: 3),
        ),
      );
      await Future.delayed(Duration(seconds: 3));
      Navigator.of(context).pop();
      return;
    }

    // When permissions are granted, get the current position
    Position position = await Geolocator.getCurrentPosition();
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 15.0,
      ),
    ));
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
        body: GoogleMap(
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
    );
  }
}
