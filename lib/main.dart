// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_goolge_map/Convert%20Latlang%20to%20Address/convert_latlang_to_address.dart';
import 'package:flutter_goolge_map/HomePage/home_screen.dart';

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
      home: ConvertLatLangToAddress(),
    );
  }
}