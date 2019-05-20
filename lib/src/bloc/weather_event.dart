import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class WeatherEvent extends Equatable {
  WeatherEvent([List props = const []]) : super(props);
}

class FetchWeather extends WeatherEvent {
  final String cityName;

  FetchWeather({@required this.cityName})
      : assert(cityName != null),
        super([cityName]);
}
