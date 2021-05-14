import 'package:flutter/material.dart';
import 'package:flutter_weather/main.dart';
import 'package:flutter_weather/src/model/weather.dart';
import 'package:flutter_weather/src/widgets/forecast_horizontal_widget.dart';
import 'package:flutter_weather/src/widgets/value_tile.dart';
import 'package:flutter_weather/src/widgets/weather_swipe_pager.dart';
import 'package:intl/intl.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  WeatherWidget({this.weather}) : assert(weather != null);

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            this.weather.cityName.toUpperCase(),
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 5,
              color: appTheme.accentColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 20),
          Text(
            this.weather.description.toUpperCase(),
            style: TextStyle(
              fontSize: 15,
              letterSpacing: 5,
              fontWeight: FontWeight.w100,
              color: appTheme.accentColor,
            ),
          ),
          WeatherSwipePager(weather: weather),
          Padding(
            child: Divider(
              color: appTheme.accentColor.withAlpha(50),
            ),
            padding: EdgeInsets.all(10),
          ),
          ForecastHorizontal(weathers: weather.forecast),
          Padding(
            child: Divider(
              color: appTheme.accentColor.withAlpha(50),
            ),
            padding: EdgeInsets.all(10),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            ValueTile("wind speed", '${this.weather.windSpeed} m/s'),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: Container(
                width: 1,
                height: 30,
                color: AppStateContainer.of(context)
                    .theme
                    .accentColor
                    .withAlpha(50),
              )),
            ),
            ValueTile(
                "sunrise",
                DateFormat('h:m a').format(DateTime.fromMillisecondsSinceEpoch(
                    this.weather.sunrise * 1000))),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: Container(
                width: 1,
                height: 30,
                color: AppStateContainer.of(context)
                    .theme
                    .accentColor
                    .withAlpha(50),
              )),
            ),
            ValueTile(
                "sunset",
                DateFormat('h:m a').format(DateTime.fromMillisecondsSinceEpoch(
                    this.weather.sunset * 1000))),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: Container(
                width: 1,
                height: 30,
                color: AppStateContainer.of(context)
                    .theme
                    .accentColor
                    .withAlpha(50),
              )),
            ),
            ValueTile("humidity", '${this.weather.humidity}%'),
          ]),
        ],
      ),
    );
  }
}
