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
  WeatherRepository weatherRepository = WeatherRepository(
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
          backgroundColor: Colors.white,
          elevation: 0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Weather',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                DateFormat('EEEE, MMMM yyyy').format(DateTime.now()),
                style: TextStyle(color: Colors.black45, fontSize: 14),
              )
            ],
          ),
          actions: <Widget>[
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Icon(
                  Icons.public,
                  color: Colors.black,
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
          color: Colors.white,
          child: BlocBuilder(
              bloc: _weatherBloc,
              builder: (_, WeatherState weatherState) {
                if (weatherState is WeatherEmpty) {
                  return Text('empty');
                } else if (weatherState is WeatherLoaded) {
                  return WeatherWidget(
                    weather: weatherState.weather,
                  );
                } else if (weatherState is WeatherError) {
                  return Text('error');
                } else if (weatherState is WeatherLoading) {
                  return CircularProgressIndicator();
                }
              }),
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
                child: Text('ok', style: TextStyle(color: Theme.of(context).accentColor),),
                onPressed: (){
                  _weatherBloc.dispatch(FetchWeather(cityName: _cityName));
                  Navigator.of(context).pop();
                },
              )
            ],
            content: TextField(
              onChanged: (text){
                _cityName = text;
              },
              decoration: InputDecoration(
                hintText: 'Enter the name of your city',
              ),
            ),
          );
        });
  }
}
