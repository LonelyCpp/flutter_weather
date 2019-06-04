import 'package:flutter/material.dart';
import 'package:flutter_weather/src/model/weather.dart';
import 'package:flutter_weather/src/widgets/value_tile.dart';
import 'package:intl/intl.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  WeatherWidget({this.weather}) : assert(weather != null);

  @override
  Widget build(BuildContext context) {
    final celsius = weather.temperatureAsCelsius.floor();
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              weather.cityName.toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 5,
                  color: Theme.of(context).accentColor,
                  fontSize: 25),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              weather.description.toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.w100,
                  letterSpacing: 5,
                  fontSize: 15,
                  color: Theme.of(context).accentColor),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '$celsius°',
              style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.w100,
                  color: Theme.of(context).accentColor),
            ),
            Padding(
              child: Divider(
                color: Theme.of(context).accentColor.withAlpha(50),
              ),
              padding: EdgeInsets.all(10),
            ),
            Container(
              height: 70,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: this.weather.forecast.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 100,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  itemBuilder: (context, index) {
                    final item = weather.forecast[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: ValueTile(
                              DateFormat('h:m a, EE').format(DateTime.fromMillisecondsSinceEpoch(item.time * 1000)),
//                            item.time.toString(),
                              item.temperature.toString())),
                    );
                  }
                  ,
              ),
            ),
            Padding(
              child: Divider(
                color: Theme.of(context).accentColor.withAlpha(50),
              ),
              padding: EdgeInsets.all(10),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ValueTile("Max Temp", this.weather.maxTemperature.toString()),
                  ValueTile("Min Temp", this.weather.minTemperature.toString()),
                ])
          ],
        ),
      ),
    );
  }
}
