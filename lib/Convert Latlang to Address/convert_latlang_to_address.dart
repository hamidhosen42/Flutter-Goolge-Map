// ignore_for_file: library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, prefer_const_declarations, avoid_unnecessary_containers, unused_local_variable, avoid_print, prefer_interpolation_to_compose_strings, unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';

class ConvertLatLangToAddress extends StatefulWidget {
  const ConvertLatLangToAddress({Key? key}) : super(key: key);

  @override
  _ConvertLatLangToAddressState createState() =>
      _ConvertLatLangToAddressState();
}

class _ConvertLatLangToAddressState extends State<ConvertLatLangToAddress> {


  String from_address="";
  String query_address="";

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
                // From a query
                final query = "chittagong new market, Bangladesh";
                var addresses =
                    await Geocoder.local.findAddressesFromQuery(query);
                var first1 = addresses.first;
                print("${first1.featureName} : ${first1.coordinates}");

                // From coordinates
                final coordinates = new Coordinates(22.3344, 91.8332);
                var address = await Geocoder.local
                    .findAddressesFromCoordinates(coordinates);
                var first = address.first;
                print("${first.featureName} : ${first.addressLine}");

                setState(() {
                  from_address=first.featureName.toString()+""+first.addressLine.toString();
                  query_address=first1.featureName.toString()+""+first1.addressLine.toString()+"CODE"+first1.countryName.toString();
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