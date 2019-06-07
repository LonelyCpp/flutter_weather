import 'package:flutter/material.dart';
import 'package:flutter_weather/src/screens/weather_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_weather/src/themes.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(RootWidget());
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class RootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppStateContainer(child: WeatherApp());
  }
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppStateContainer(
        child: MaterialApp(
      title: 'Flutter Weather App',
      theme: AppStateContainer.of(context).theme,
      home: WeatherScreen(),
    ));
  }
}

class AppStateContainer extends StatefulWidget {
  final Widget child;

  AppStateContainer({@required this.child});

  @override
  _AppStateContainerState createState() => _AppStateContainerState();

  static _AppStateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }
}

class _AppStateContainerState extends State<AppStateContainer> {
  ThemeData _theme = Themes.light;

  @override
  Widget build(BuildContext context) {
    print(theme.accentColor);
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }

  ThemeData get theme => _theme;

  updateTheme(ThemeData value) {
    setState(() {
      _theme = value;
      Theme.of(context).copyWith(
        primaryColor: value.primaryColor,
        accentColor: value.accentColor,
      );
    });
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final _AppStateContainerState data;

  const _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer oldWidget) {
    print('updateShouldNotify');
    return true;
  }
}
