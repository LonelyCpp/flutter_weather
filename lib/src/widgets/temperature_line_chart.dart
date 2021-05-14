import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_weather/main.dart';
import 'package:flutter_weather/src/model/weather.dart';

/// Renders a line chart from forecast data
/// x axis - date
/// y axis - temperature
class TemperatureLineChart extends StatelessWidget {
  final List<Weather> weathers;
  final bool animate;

  TemperatureLineChart(this.weathers, {this.animate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: charts.TimeSeriesChart(
        [
          new charts.Series<Weather, DateTime>(
            id: 'Temperature',
            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
            domainFn: (Weather weather, _) =>
                DateTime.fromMillisecondsSinceEpoch(weather.time * 1000),
            measureFn: (Weather weather, _) => weather.temperature
                .as(AppStateContainer.of(context).temperatureUnit),
            data: weathers,
          )
        ],
        animate: animate,
        animationDuration: Duration(milliseconds: 500),
        primaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec: new charts.BasicNumericTickProviderSpec(
            zeroBound: false,
          ),
        ),
      ),
    );
  }
}
