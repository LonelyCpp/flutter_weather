import 'package:flutter/material.dart';
import 'package:flutter_weather/main.dart';
import 'package:flutter_weather/src/model/weather.dart';
import 'package:flutter_weather/src/widgets/current_conditions.dart';
import 'package:flutter_weather/src/widgets/empty_widget.dart';
import 'package:flutter_weather/src/widgets/forecast_horizontal_widget.dart';
import 'package:flutter_weather/src/widgets/line_chart.dart';
import 'package:flutter_weather/src/widgets/value_tile.dart';
import 'package:intl/intl.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class WeatherWidget extends StatelessWidget {
  final Weather weather;
  final temperatureData;

  WeatherWidget({this.weather})
      : temperatureData = [
          new charts.Series<Weather, DateTime>(
            id: 'Temperature',
            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
            domainFn: (Weather weather, _) =>
                DateTime.fromMillisecondsSinceEpoch(weather.time * 1000),
            measureFn: (Weather weather, _) => weather.temperature.celsius,
            data: weather.forecast,
          )
        ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            this.weather.cityName.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: 5,
                color: AppStateContainer.of(context).theme.accentColor,
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
                color: AppStateContainer.of(context).theme.accentColor),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: Swiper(
              itemCount: 2,
              index: 0,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return CurrentConditions(
                    weather: weather,
                  );
                } else if (index == 1) {
                  return PointsLineChart(temperatureData, animate: true,);
                }
                return EmptyWidget();
              },
              pagination: new SwiperPagination(
                  margin: new EdgeInsets.all(5.0),
                  builder: new DotSwiperPaginationBuilder(
                      size: 5,
                      activeSize: 5,
                      color: AppStateContainer.of(context)
                          .theme
                          .accentColor
                          .withOpacity(0.4),
                      activeColor:
                          AppStateContainer.of(context).theme.accentColor)),
            ),
          ),
          Padding(
            child: Divider(
              color:
                  AppStateContainer.of(context).theme.accentColor.withAlpha(50),
            ),
            padding: EdgeInsets.all(10),
          ),
          ForecastHorizontal(weathers: weather.forecast),
          Padding(
            child: Divider(
              color:
                  AppStateContainer.of(context).theme.accentColor.withAlpha(50),
            ),
            padding: EdgeInsets.all(10),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            ValueTile("wind speed", '${this.weather.windSpeed} m/s'),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
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
              padding: const EdgeInsets.only(left: 20, right: 20),
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
              padding: const EdgeInsets.only(left: 20, right: 20),
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
