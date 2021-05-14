import 'dart:convert';
import 'package:flutter_weather/src/api/http_exception.dart';
import 'package:flutter_weather/src/model/weather.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

/// Wrapper around the open weather map api
/// https://openweathermap.org/current
class WeatherApiClient {
  static const baseUrl = 'http://api.openweathermap.org';
  final apiKey;
  final http.Client httpClient;

  WeatherApiClient({@required this.httpClient, this.apiKey})
      : assert(httpClient != null),
        assert(apiKey != null);

  Uri _buildUri(String endpoint, Map<String, dynamic> queryParameters) {
    var query = {'appid': apiKey};
    if (queryParameters != null) {
      query = query..addAll(queryParameters);
    }

    var uri = Uri(
      scheme: 'http',
      host: 'api.openweathermap.org',
      path: 'data/2.5/$endpoint',
      queryParameters: query,
    );

    print('fetching $uri');

    return uri;
  }

  Future<String> getCityNameFromLocation(
      {double latitude, double longitude}) async {
    final uri = _buildUri('weather', {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
    });

    final res = await this.httpClient.get(uri);

    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }

    final weatherJson = json.decode(res.body);
    return weatherJson['name'];
  }

  Future<Weather> getWeatherData(String cityName) async {
    final uri = _buildUri('weather', {'q': cityName});

    final res = await this.httpClient.get(uri);

    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }

    final weatherJson = json.decode(res.body);
    return Weather.fromJson(weatherJson);
  }

  Future<List<Weather>> getForecast(String cityName) async {
    final uri = _buildUri('forecast', {'q': cityName});

    final res = await this.httpClient.get(uri);

    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }

    final forecastJson = json.decode(res.body);
    List<Weather> weathers = Weather.fromForecastJson(forecastJson);
    return weathers;
  }
}
