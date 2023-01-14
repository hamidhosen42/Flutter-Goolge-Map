// ignore_for_file: library_private_types_in_public_api, prefer_final_fields, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({Key? key}) : super(key: key);

  @override
  _PolylineScreenState createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.738045, 73.084488),
    zoom: 10,
  );

  List<LatLng> latlng = [
    LatLng(33.738045, 73.084488),
    LatLng(33.567997728, 72.635997456),
    LatLng(33.6941, 72.9734),
    LatLng(33.7008, 72.9682),
    LatLng(33.6992, 72.9744),
    LatLng(33.6939, 72.9771),
    LatLng(33.6910, 72.9807),
    LatLng(33.7036, 72.9785)
  ];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < latlng.length; i++) {
      setState(() {
        _markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: latlng[i],
          infoWindow: InfoWindow(
            title: 'Really cool place',
            snippet: '5 Star Rating',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ));
        _polyline.add(Polyline(
          polylineId: PolylineId(i.toString()),
          visible: true,
          points: latlng,
          color: Colors.blue,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Polyline Screen"),
            centerTitle: true,
          ),
          body: GoogleMap(
            polylines: _polyline,
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            myLocationEnabled: true,
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
          )),
    );
  }
}
