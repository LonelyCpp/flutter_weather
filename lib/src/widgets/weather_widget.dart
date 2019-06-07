import 'package:flutter/material.dart';
import 'package:flutter_weather/src/model/weather.dart';
import 'package:flutter_weather/src/widgets/forecast_horizontal_widget.dart';
import 'package:flutter_weather/src/widgets/value_tile.dart';
import 'package:intl/intl.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  WeatherWidget({this.weather}) : assert(weather != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              this.weather.cityName.toUpperCase(),
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
              this.weather.description.toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.w100,
                  letterSpacing: 5,
                  fontSize: 15,
                  color: Theme.of(context).accentColor),
            ),
            SizedBox(
              height: 20,
            ),
            Icon(weather.getIconData(), color: Theme.of(context).accentColor, size: 70,),
            SizedBox(
              height: 20,
            ),
            Text(
              '${this.weather.temperature.celsius.round()}°',
              style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.w100,
                  color: Theme.of(context).accentColor),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              ValueTile(
                  "max", '${this.weather.maxTemperature.celsius.round()}°'),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Center(
                    child: Container(
                  width: 1,
                  height: 30,
                  color: Theme.of(context).accentColor.withAlpha(50),
                )),
              ),
              ValueTile(
                  "min", '${this.weather.minTemperature.celsius.round()}°'),
            ]),
            Padding(
              child: Divider(
                color: Theme.of(context).accentColor.withAlpha(50),
              ),
              padding: EdgeInsets.all(10),
            ),
            ForecastHorizontal(weathers: weather.forecast),
            Padding(
              child: Divider(
                color: Theme.of(context).accentColor.withAlpha(50),
              ),
              padding: EdgeInsets.all(10),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              ValueTile(
                  "sunrise",
                  DateFormat('h:m a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          this.weather.sunrise * 1000))),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Center(
                    child: Container(
                  width: 1,
                  height: 30,
                  color: Theme.of(context).accentColor.withAlpha(50),
                )),
              ),
              ValueTile(
                  "sunset",
                  DateFormat('h:m a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          this.weather.sunset * 1000))),
            ]),
          ],
        ),
      ),
    );
  }
}
