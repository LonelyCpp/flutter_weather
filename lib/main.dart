import 'package:flutter/material.dart';
import 'package:flutter_weather/src/screens/weather_screen.dart';
import 'package:bloc/bloc.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      theme: ThemeData(
        primarySwatch: MaterialColor(
          Colors.black.value,
          const <int, Color>{
            50: Colors.black12,
            100: Colors.black26,
            200: Colors.black38,
            300: Colors.black45,
            400: Colors.black54,
            500: Colors.black87,
            600: Colors.black87,
            700: Colors.black87,
            800: Colors.black87,
            900: Colors.black87,
          },
        ),
        accentColor: Colors.white,
      ),
      home: WeatherScreen(),
    );
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
