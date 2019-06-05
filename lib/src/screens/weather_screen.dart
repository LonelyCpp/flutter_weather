import 'package:flutter/material.dart';
import 'package:flutter_weather/src/api/weather_api_client.dart';
import 'package:flutter_weather/src/bloc/weather_bloc.dart';
import 'package:flutter_weather/src/bloc/weather_event.dart';
import 'package:flutter_weather/src/bloc/weather_state.dart';
import 'package:flutter_weather/src/repository/weather_repository.dart';
import 'package:flutter_weather/src/api/api_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/src/widgets/weather_widget.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  final WeatherRepository weatherRepository = WeatherRepository(
      weatherApiClient: WeatherApiClient(
          httpClient: http.Client(), apiKey: ApiKey.OPEN_WEATHER_MAP));
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherBloc _weatherBloc;
  String _cityName = 'bengaluru';

  @override
  void initState() {
    super.initState();
    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
    _weatherBloc.dispatch(FetchWeather(cityName: _cityName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                DateFormat('EEEE, MMMM yyyy').format(DateTime.now()),
                style: TextStyle(
                    color: Theme.of(context).accentColor.withAlpha(80),
                    fontSize: 14),
              )
            ],
          ),
          actions: <Widget>[
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Icon(
                  Icons.public,
                  color: Theme.of(context).accentColor,
                ),
              ),
              onTap: () {
                this.showCityChangeDialog();
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Material(
          color: Theme.of(context).accentColor,
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: BlocBuilder(
                bloc: _weatherBloc,
                builder: (_, WeatherState weatherState) {
                  if (weatherState is WeatherLoaded) {
                    return WeatherWidget(
                      weather: weatherState.weather,
                    );
                  } else if (weatherState is WeatherError ||
                      weatherState is WeatherEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.error_outline,
                          color: Colors.redAccent,
                          size: 24,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'There was an error fetching weather data',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                        FlatButton(
                          child: Text(
                            "Try Again",
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                          ),
                          onPressed: _fetchWeather,
                        )
                      ],
                    );
                  } else if (weatherState is WeatherLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    );
                  }
                }),
          ),
        ));
  }

  void showCityChangeDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Change city'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'ok',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  _fetchWeather();
                  Navigator.of(context).pop();
                },
              )
            ],
            content: TextField(
              autofocus: true,
              onChanged: (text) {
                _cityName = text;
              },
              decoration: InputDecoration(
                hintText: 'Enter the name of your city',
              ),
            ),
          );
        });
  }

  _fetchWeather() {
    _weatherBloc.dispatch(FetchWeather(cityName: _cityName));
  }
}
