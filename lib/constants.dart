import 'package:flutter/material.dart';

Color kYellow = Colors.yellow;
Color kGreen = Colors.greenAccent;
Color kBlue = Colors.blueGrey.shade400;
Color kColdBlue = Colors.lightBlue;

String kSunnyPic = 'assets/images/sunny.png';
String kRainyPic = 'assets/images/rainy.png';
String kBadWeatherPic = 'assets/images/bad_weather.png';

const kTextFieldInputDecoration =InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);
