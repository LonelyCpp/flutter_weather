import 'package:flutter_weather/src/api/WeatherApiClient.dart';
import 'package:flutter_weather/src/model/Weather.dart';
import 'package:meta/meta.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;
  WeatherRepository({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  Future<Weather> getWeather(String cityName) async {
    return await weatherApiClient.getWeatherData(cityName);
  }
}
