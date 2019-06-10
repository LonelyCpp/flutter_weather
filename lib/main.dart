import 'package:flutter/material.dart';
import 'package:flutter_weather/src/screens/weather_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_weather/src/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(AppStateContainer(child: WeatherApp()));
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      theme: AppStateContainer.of(context).theme,
      home: WeatherScreen(),
    );
  }
}

/// top level widget to hold application state
/// state is passed down with an inherited widget
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
  ThemeData _theme = Themes.getTheme(Themes.DARK_THEME_CODE);

  @override
  initState() {
    super.initState();
    SharedPreferences.getInstance().then((sharedPref) {
      int themeCode =
          sharedPref.getInt(Themes.SHARED_PREF_KEY) ?? Themes.DARK_THEME_CODE;
      setState(() {
        this._theme = Themes.getTheme(themeCode);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(theme.accentColor);
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }

  ThemeData get theme => _theme;

  updateTheme(int themeCode) {
    setState(() {
      _theme = Themes.getTheme(themeCode);
    });
    SharedPreferences.getInstance().then((sharedPref) {
      sharedPref.setInt(Themes.SHARED_PREF_KEY, themeCode);
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
  bool updateShouldNotify(_InheritedStateContainer oldWidget) => true;
}
