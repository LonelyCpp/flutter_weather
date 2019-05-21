import 'package:bloc/bloc.dart';
import 'package:flutter_weather/src/model/weather.dart';
import 'package:meta/meta.dart';

import 'package:flutter_weather/src/bloc/weather_event.dart';
import 'package:flutter_weather/src/bloc/weather_state.dart';
import 'package:flutter_weather/src/repository/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository}):assert(weatherRepository!=null);

  @override
  WeatherState get initialState {
    return WeatherEmpty();
  }

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if(event is FetchWeather) {
      yield WeatherLoading();
      try{
        final Weather weather = await weatherRepository.getWeather(event.cityName);
        yield WeatherLoaded(weather: weather);
      } catch (error){
        yield WeatherError();
      }
    }
  }
}