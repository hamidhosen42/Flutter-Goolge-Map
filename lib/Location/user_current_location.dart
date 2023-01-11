// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields, unused_element, avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable

import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocation extends StatefulWidget {
  const GetUserCurrentLocation({super.key});

  @override
  State<GetUserCurrentLocation> createState() => _GetUserCurrentLocationState();
}

class _GetUserCurrentLocationState extends State<GetUserCurrentLocation> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.3344, 91.8332),
    zoom: 15,
  );

  List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(22.3344, 91.8332),
        infoWindow: InfoWindow(title: "This is my location"))
  ];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print(error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }

  loadData() {
    getUserCurrentLocation().then((value) async {
      print("My current location");
      print(value.latitude.toString() + "  " + value.longitude.toString());

      _markers.add(Marker(
          markerId: MarkerId('2'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(
            title: 'My current location',
          )));

      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 10,
      );

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        // mapType: MapType.normal,
        // zoomControlsEnabled: true,
        // zoomGesturesEnabled: true,
        // myLocationButtonEnabled: true,
        // myLocationEnabled: true,
        // trafficEnabled: true,
        // rotateGesturesEnabled: true,
        // buildingsEnabled: true,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: FloatingActionButton(
          onPressed: () {
            loadData();
          },
          child: Icon(Icons.local_activity),
        ),
      ),
    );
  }
}