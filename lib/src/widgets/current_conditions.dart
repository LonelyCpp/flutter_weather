import 'package:flutter/material.dart';
import 'package:flutter_weather/main.dart';
import 'package:flutter_weather/src/model/weather.dart';
import 'package:flutter_weather/src/widgets/value_tile.dart';

import '../utils/converters.dart';

/// Renders Weather Icon, current, min and max temperatures
class CurrentConditions extends StatelessWidget {
  final Weather weather;
  const CurrentConditions({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;
    TemperatureUnit unit = AppStateContainer.of(context).temperatureUnit;

    int currentTemp = this.weather.temperature.as(unit).round();
    int maxTemp = this.weather.maxTemperature.as(unit).round();
    int minTemp = this.weather.minTemperature.as(unit).round();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          weather.getIconData(),
          color: appTheme.accentColor,
          size: 70,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '$currentTemp°',
          style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.w100,
              color: appTheme.accentColor),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ValueTile("max", '$maxTemp'),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Center(
                child: Container(
              width: 1,
              height: 30,
              color: appTheme.accentColor.withAlpha(50),
            )),
          ),
          ValueTile("min", '$minTemp°'),
        ]),
      ],
    );
  }
}
