// ignore_for_file: library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, prefer_const_declarations, avoid_unnecessary_containers, unused_local_variable, avoid_print, prefer_interpolation_to_compose_strings, unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class GeocoderConvertLatLangToAddress extends StatefulWidget {
  const GeocoderConvertLatLangToAddress({Key? key}) : super(key: key);

  @override
  _GeocoderConvertLatLangToAddressState createState() =>
      _GeocoderConvertLatLangToAddressState();
}

class _GeocoderConvertLatLangToAddressState
    extends State<GeocoderConvertLatLangToAddress> {
  String from_address = "";
  String query_address = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("From coordinates :${from_address}"),
            Text("From query :${query_address}"),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {
                List<Location> locations = await locationFromAddress(
                    "chittagong new market, Bangladesh");

                List<Placemark> placemarks = await placemarkFromCoordinates(
                    locations.last.latitude, locations.last.longitude);

                setState(() {
                  from_address = locations.last.latitude.toString() +
                      "   " +
                      locations.last.longitude.toString();
                  query_address = placemarks.reversed.last.country.toString();
                });
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurpleAccent),
                child: Center(
                    child: Text(
                  "Covert",
                  style: TextStyle(fontSize: 20),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}