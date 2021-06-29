import 'package:flutter/cupertino.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/model/location.dart';
import 'package:weather_app/model/networking.dart';

const apiKey = 'd2978f2b278bc93912f526a4bdd8edec';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    print(' 1 $networkHelper');
    var weatherData = await networkHelper.getData();
    print(weatherData);
    return weatherData;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Color getColor(double temp) {
    if (temp >= 30) {
      return kYellow;
    } else if (temp > 20) {
      return kGreen;
    } else if (temp > 10) {
      return kBlue;
    } else {
      return kColdBlue;
    }
  }

  String? getPic(int condition) {
    if (condition <= 400) {
      return kRainyPic;
    } else if (condition == 800 || condition <= 804) {
      return kSunnyPic;
    } else {
      return kBadWeatherPic;
    }
  }
}

// https://api.openweathermap.org/data/2.5/weather?lat=13.1105&lon=80.2128&appid=d2978f2b278bc93912f526a4bdd8edec&units=metric

//
// String getWeatherIcon(int condition) {
//   if (condition < 300) {
//     return '🌩 ';
//   } else if (condition < 400) {
//     return '🌧';
//   } else if (condition < 600) {
//     return '☔️';
//   } else if (condition < 700) {
//     return '☃️';
//   } else if (condition < 800) {
//     return '🌫';
//   } else if (condition == 800) {
//     return '☀️';
//   } else if (condition <= 804) {
//     return '☁️';
//   } else {
//     return '🤷‍';
//   }
// }
