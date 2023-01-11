// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  List<Marker> _markers = <Marker>[];
  final List<Marker> _list = [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(22.3344, 91.8332),
        infoWindow: InfoWindow(title: 'My Current Location')),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(22.341900, 91.815536),
        infoWindow: InfoWindow(title: 'Another Location-1')),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(22.341900, 91.015536),
        infoWindow: InfoWindow(title: 'Another Location-2')),
  ];

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.3344, 91.8332),
    zoom: 15,
  );
  

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(23.8103, 90.4125),
      tilt: 59.440717697143555,
      zoom: 14.151926040649414);

  @override
  void initState() {
    super.initState();
    _markers.addAll(_list);
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _markers.add(Marker(
  //       markerId: MarkerId('1'),
  //       position: LatLng(37.42796133580664, -122.085749655962),
  //       infoWindow: InfoWindow(title: 'My Current Location')));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
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
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: FloatingActionButton(
          onPressed: _goToTheLake,
          child: const Icon(Icons.location_disabled_outlined),
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}