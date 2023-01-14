// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_goolge_map/Convert%20Latlang%20to%20Address/Geocoder_convert_latlang_to_address.dart';
import 'package:flutter_goolge_map/Convert%20Latlang%20to%20Address/convert_latlang_to_address.dart';
import 'package:flutter_goolge_map/HomePage/home_screen.dart';
import 'package:flutter_goolge_map/Location/user_current_location.dart';
import 'package:flutter_goolge_map/Polygone/polygone_screen.dart';
import 'package:flutter_goolge_map/Polygone/polyline_screen.dart';

import 'GoogleMapMarker/custom_marker_info_window.dart';
import 'GoogleMapMarker/custom_marker_with_network_image.dart';
import 'GoogleMapMarker/network_image_marker.dart';
import 'Location/google_search_places_api.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      // home: ConvertLatLangToAddress(),
      // home: GeocoderConvertLatLangToAddress(),
      // home: GetUserCurrentLocation(),
      // home: GoogleSearchPlacesApi(),
      // home: CustomMarkerWithNetworkImage(),
      // home: CustomMarkerInfoWindowScreen(),
      // home: PolygoneScreen(),
      // home: PolylineScreen(),
      home: NetworkImageCustomMarker(),
    );
  }
}