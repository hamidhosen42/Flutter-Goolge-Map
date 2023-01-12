// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields, unnecessary_null_comparison, non_constant_identifier_names, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GoogleSearchPlacesApi extends StatefulWidget {
  const GoogleSearchPlacesApi({super.key});

  @override
  State<GoogleSearchPlacesApi> createState() => _GoogleSearchPlacesApiState();
}

class _GoogleSearchPlacesApiState extends State<GoogleSearchPlacesApi> {
  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyAT1-PB-awAjPkum67C4mYiOg4YiaGaLaM";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
        // print("sds"+"${request}");

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    // print(request);

    // print(response.body.toString());

    if (response.statusCode == 200) {
      setState(() {
        _placeList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Search Places Api"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: "Search in places with name",
              focusColor: Colors.white,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Icon(Icons.map),
              suffixIcon: IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  _controller.clear();
                },
              ),
            ),
          ),
          ListView.builder(
            // physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _placeList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  List<Location> location = await locationFromAddress(_placeList[index]['description']);
                },
                child: ListTile(
                  title: Text(_placeList[index]["description"]),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}