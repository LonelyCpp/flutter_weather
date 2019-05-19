import 'package:flutter/material.dart';
import 'package:flutter_weather/src/api/WeatherApiClient.dart';
import 'package:flutter_weather/src/api/ApiKey.dart';
import 'package:flutter_weather/src/model/Weather.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Weather> weatherFuture = WeatherApiClient(
  httpClient: http.Client(), apiKey: ApiKey.OPEN_WEATHER_MAP)
      .getWeatherData('udupi');
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
          child: FutureBuilder(
        future: weatherFuture,
        builder: (context, AsyncSnapshot<Weather> snapShot) {
          if(snapShot.connectionState == ConnectionState.done){
            return Text(snapShot.data.description);
          } else {
            return CircularProgressIndicator();
          }
        },
      )),
    );
  }
}
