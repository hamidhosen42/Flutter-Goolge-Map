// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerWithNetworkImage extends StatefulWidget {
  const CustomMarkerWithNetworkImage({super.key});

  @override
  State<CustomMarkerWithNetworkImage> createState() =>
      _CustomMarkerWithNetworkImageState();
}

class _CustomMarkerWithNetworkImageState
    extends State<CustomMarkerWithNetworkImage> {
  final Completer<GoogleMapController> _controller = Completer();
  List<String> images = [
    'images/car.png',
    'images/car2.png',
    'images/marker2.png',
    'images/marker3.png',
    'images/marker.png',
    'images/motorcycle.png',
  ];

  late Uint8List markerImage;

  final List<Marker> _markers = <Marker>[
    // Marker(markerId: MarkerId('1'), position: LatLng(33.6941, 72.9734)),
    // Marker(markerId: MarkerId('2'), position: LatLng(33.7008, 72.9682)),
    // Marker(markerId: MarkerId('3'), position: LatLng(33.6992, 72.9744)),
    // Marker(markerId: MarkerId('4'), position: LatLng(33.6939, 72.9771)),
    // Marker(markerId: MarkerId('5'), position: LatLng(33.6910, 72.9807)),
    // Marker(markerId: MarkerId('6'), position: LatLng(33.7036, 72.9785)),
  ];

  List<LatLng> _latLang = [
    LatLng(33.6941, 72.9734),
    LatLng(33.7008, 72.9682),
    LatLng(33.6992, 72.9744),
    LatLng(33.6939, 72.9771),
    LatLng(33.6910, 72.9807),
    LatLng(33.7036, 72.9785)
  ];

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6941, 72.9734),
    zoom: 15,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
  }

  Future<Uint8List> getBytesFromAssets(String path,int width) async
  {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),targetHeight: width);
    ui.FrameInfo fi=await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  loadData() async{
    for (int i = 0; i < images.length; i++) {

      final Uint8List markerIcon = await getBytesFromAssets(images[i], 100);
      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
            position: _latLang[i],
            icon: BitmapDescriptor.fromBytes(markerIcon),
            infoWindow:
                InfoWindow(title: "This is title markers: " + i.toString())),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}