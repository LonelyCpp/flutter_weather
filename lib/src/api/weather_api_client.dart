import 'dart:convert';
import 'package:flutter_weather/src/model/weather.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {
  static const baseUrl = 'http://api.openweathermap.org';
  final apiKey;
  final http.Client httpClient;

  WeatherApiClient({@required this.httpClient, this.apiKey})
      : assert(httpClient != null),
        assert(apiKey != null);

  Future<Weather> getWeatherData(String cityName) async {
    final url = '$baseUrl/data/2.5/weather?q=$cityName&appid=$apiKey';
    print('fetching $url');
    final res = await this.httpClient.get(url);
    if (res.statusCode != 200) {
      throw Exception('error getting locationId for city');
    }
    final weatherJson = json.decode(res.body);
    return Weather.fromJson(weatherJson);
  }
}
