import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/model/weather.dart';

import 'city_screen.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  final locationWeather;
  const HomePage({Key? key, required this.locationWeather}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel weather = WeatherModel();
  bool dataFetched = false;
  int? temperature;
  String? picture;
  // Icon? weatherIcon;
  Color? color;
  String? cityName;
  String? weatherMessage;
  String? humidity;
  String? description;
  String? pressure;
  String? windSpeed;

  void updateUI(dynamic weatherData) async {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        // weatherIcon = Icon(Icons.error_outline);
        weatherMessage = 'Error';
        cityName = '';
        return;
      }
      dataFetched = true;
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      color = weather.getColor(temp);
      var id = weatherData['weather'][0]['id'];
      weatherMessage = weatherData['weather'][0]['main'];
      picture = weather.getPic(id);
      cityName = weatherData['name'];
      humidity = weatherData['main']['humidity'].toString();
      description = weatherData['weather'][0]['description'];
      pressure = weatherData['main']['pressure'].toString();
      windSpeed = weatherData['wind']['speed'].toString();
    });
  }

  @override
  void initState() {
    updateUI(widget.locationWeather);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dataFetched? color: Colors.redAccent,
      appBar: AppBar(
        title: Text('Weather App', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.location_on, color: Colors.black,),
          onPressed: () async {
            var weatherData = await weather.getLocationWeather();
            updateUI(weatherData);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search_outlined, color: Colors.black,),
            onPressed: () async {
              var typedName = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CityScreen();
                  },
                ),
              );
              if (typedName != null) {
                var weatherData = await weather.getCityWeather(typedName);
                updateUI(weatherData);
              }
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 12.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('$temperature°C',
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w200,
                                        fontSize: 72),
                                  )),
                              Text(
                                "$cityName",
                              ),
                            ],
                          ),
                          Text(
                            "$weatherMessage",
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w200,
                                fontSize: 38,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1.5, color: Colors.black)),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(18),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Description'),
                                Text('Humidity'),
                                Text('Pressure'),
                                Text('Wind Speed'),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(18),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(':'),
                                Text(':'),
                                Text(':'),
                                Text(':'),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(18),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('$description'),
                                Text('$humidity %'),
                                Text('$pressure'),
                                Text('$windSpeed km/h'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: double.infinity,
              child: Image.asset(
                dataFetched? '$picture': 'assets/images/bad_weather.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
