import 'package:flutter/material.dart';

class _IconData extends IconData {
  const _IconData(int codePoint)
      : super(
          codePoint,
          fontFamily: 'WeatherIcons',
        );
}
/// Exposes specific weather icons
/// Has all weather conditions specified by open weather maps API
/// https://openweathermap.org/weather-conditions
// hex values and ttf file from https://erikflowers.github.io/weather-icons/
class WeatherIcons {
  static const IconData clear_day = const _IconData(0xf00d);
  static const IconData clear_night = const _IconData(0xf02e);

  static const IconData few_clouds_day = const _IconData(0xf002);
  static const IconData few_clouds_night = const _IconData(0xf081);

  static const IconData clouds_day = const _IconData(0xf07d);
  static const IconData clouds_night = const _IconData(0xf080);

  static const IconData shower_rain_day = const _IconData(0xf009);
  static const IconData shower_rain_night = const _IconData(0xf029);

  static const IconData rain_day = const _IconData(0xf008);
  static const IconData rain_night = const _IconData(0xf028);

  static const IconData thunder_storm_day = const _IconData(0xf010);
  static const IconData thunder_storm_night = const _IconData(0xf03b);

  static const IconData snow_day = const _IconData(0xf00a);
  static const IconData snow_night = const _IconData(0xf02a);

  static const IconData mist_day = const _IconData(0xf003);
  static const IconData mist_night = const _IconData(0xf04a);


}
