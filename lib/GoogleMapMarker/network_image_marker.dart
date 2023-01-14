// ignore_for_file: unused_field, prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_declarations, unused_local_variable

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NetworkImageCustomMarker extends StatefulWidget {
  const NetworkImageCustomMarker({super.key});

  @override
  State<NetworkImageCustomMarker> createState() =>
      _NetworkImageCustomMarkerState();
}

class _NetworkImageCustomMarkerState extends State<NetworkImageCustomMarker> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = [];

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6939, 72.9771),
    zoom: 15,
  );

  List<LatLng> latlng = [
    LatLng(33.6939, 72.9771),
    LatLng(33.6910, 72.9807),
    LatLng(33.7036, 72.9785)
  ];

  List<String> images = [
    'images/car.png',
    'images/car2.png',
    'images/marker2.png',
    'images/marker3.png',
    'images/marker.png',
    'images/motorcycle.png',
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < latlng.length; i++) {
      Uint8List? image = await loadNetWorkImage(
          "https://cdn.pixabay.com/photo/2019/07/07/14/03/fiat-500-4322521_960_720.jpg");

      final ui.Codec codec = await ui.instantiateImageCodec(
          image.buffer.asUint8List(),
          targetHeight: 100,
          targetWidth: 100);
      final ui.FrameInfo fi = await codec.getNextFrame();
      final ByteData? byteData =
          await fi.image.toByteData(format: ui.ImageByteFormat.png);

      final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();

      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
            position: latlng[i],
            icon: BitmapDescriptor.fromBytes(resizedImageMarker),
            infoWindow:
                InfoWindow(title: "This is title markers: " + i.toString())),
      );
      setState(() {});
    }
  }

  Future<Uint8List> loadNetWorkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);

    image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));

    final imageInfo = await completer.future;
    final bytData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return bytData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
      ),
    );
  }
}