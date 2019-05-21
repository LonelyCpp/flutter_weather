import 'package:flutter/material.dart';
import 'package:flutter_weather/src/model/weather.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  WeatherWidget({this.weather}) : assert(weather != null);

  @override
  Widget build(BuildContext context) {
    print(weather);
    final celsius = weather.temperatureAsCelsius.floor();
    return Container(
      decoration: BoxDecoration(gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment(0.0, 0.0),
        colors: [Colors.white, Colors.cyan],
      )),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              weather.cityName.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 5),
            ),
            SizedBox(height: 20,),
            Text(
              '$celsius°',
              style: TextStyle(fontSize: 100, fontWeight: FontWeight.w200),

            ),
            SizedBox(height: 20,),
            Text(
              weather.description.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 5),
            ),
          ],
        ),
      ),
    );
  }
}
