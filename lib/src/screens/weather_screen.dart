import 'package:flutter/material.dart';
import 'package:flutter_weather/main.dart';
import 'package:flutter_weather/src/api/weather_api_client.dart';
import 'package:flutter_weather/src/bloc/weather_bloc.dart';
import 'package:flutter_weather/src/bloc/weather_event.dart';
import 'package:flutter_weather/src/bloc/weather_state.dart';
import 'package:flutter_weather/src/repository/weather_repository.dart';
import 'package:flutter_weather/src/api/api_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/src/themes.dart';
import 'package:flutter_weather/src/widgets/weather_widget.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

enum OptionsMenu { changeCity, nightMode, lightMode }

class WeatherScreen extends StatefulWidget {
  final WeatherRepository weatherRepository = WeatherRepository(
      weatherApiClient: WeatherApiClient(
          httpClient: http.Client(), apiKey: ApiKey.OPEN_WEATHER_MAP));
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with TickerProviderStateMixin {
  WeatherBloc _weatherBloc;
  String _cityName = 'bengaluru';
  AnimationController _fadeController;
  Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
    _weatherBloc.dispatch(FetchWeather(cityName: _cityName));
    _fadeController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppStateContainer.of(context).theme.primaryColor,
          elevation: 0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                DateFormat('EEEE, MMMM yyyy').format(DateTime.now()),
                style: TextStyle(
                    color: AppStateContainer.of(context)
                        .theme
                        .accentColor
                        .withAlpha(80),
                    fontSize: 14),
              )
            ],
          ),
          actions: <Widget>[
            PopupMenuButton<OptionsMenu>(
                child: Icon(
                  Icons.more_vert,
                  color: AppStateContainer.of(context).theme.accentColor,
                ),
                onSelected: this._onOptionMenuItemSelected,
                itemBuilder: (context) => <PopupMenuEntry<OptionsMenu>>[
                      PopupMenuItem<OptionsMenu>(
                        value: OptionsMenu.changeCity,
                        child: Text("change city"),
                      ),
                      PopupMenuItem<OptionsMenu>(
                        value: OptionsMenu.nightMode,
                        child: Text("night mode"),
                      ),
                      PopupMenuItem<OptionsMenu>(
                        value: OptionsMenu.lightMode,
                        child: Text("light mode"),
                      ),
                    ])
          ],
        ),
        backgroundColor: Colors.white,
        body: Material(
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                color: AppStateContainer.of(context).theme.primaryColor),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: BlocBuilder(
                  bloc: _weatherBloc,
                  builder: (_, WeatherState weatherState) {
                    if (weatherState is WeatherLoaded) {
                      _fadeController.reset();
                      _fadeController.forward();
                      return WeatherWidget(
                        weather: weatherState.weather,
                      );
                    } else if (weatherState is WeatherError ||
                        weatherState is WeatherEmpty) {
                      String errorText =
                          'There was an error fetching weather data';
                      if (weatherState is WeatherError) {
                        if (weatherState.errorCode == 404) {
                          errorText =
                              'We have trouble fetching weather for $_cityName';
                        }
                      }
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
                            errorText,
                            style: TextStyle(
                                color: AppStateContainer.of(context)
                                    .theme
                                    .accentColor),
                          ),
                          FlatButton(
                            child: Text(
                              "Try Again",
                              style: TextStyle(
                                  color: AppStateContainer.of(context)
                                      .theme
                                      .accentColor),
                            ),
                            onPressed: _fetchWeather,
                          )
                        ],
                      );
                    } else if (weatherState is WeatherLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor:
                              AppStateContainer.of(context).theme.primaryColor,
                        ),
                      );
                    }
                  }),
            ),
          ),
        ));
  }

  void _showCityChangeDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Change city', style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'ok',
                  style: TextStyle(color: Colors.black),
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
                hintStyle: TextStyle(color: Colors.black),
              ),
              style: TextStyle(color: Colors.black),
            ),
          );
        });
  }

  _onOptionMenuItemSelected(OptionsMenu item) {
    switch (item) {
      case OptionsMenu.changeCity:
        this._showCityChangeDialog();
        break;
      case OptionsMenu.nightMode:
        AppStateContainer.of(context).updateTheme(Themes.DARK_THEME_CODE);
        break;
      case OptionsMenu.lightMode:
        AppStateContainer.of(context).updateTheme(Themes.LIGHT_THEME_CODE);
        break;
    }
  }

  _fetchWeather() {
    _weatherBloc.dispatch(FetchWeather(cityName: _cityName));
  }
}
