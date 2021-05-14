import 'package:flutter/material.dart';
import 'package:flutter_weather/main.dart';
import 'package:flutter_weather/src/themes.dart';
import 'package:flutter_weather/src/utils/converters.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appTheme.primaryColor,
        title: Text("Settings"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 15),
        color: appTheme.primaryColor,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Theme",
                style: TextStyle(
                  color: appTheme.accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                color: AppStateContainer.of(context)
                    .theme
                    .accentColor
                    .withOpacity(0.1),
              ),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Dark",
                    style: TextStyle(color: appTheme.accentColor),
                  ),
                  Radio(
                    value: Themes.DARK_THEME_CODE,
                    groupValue: AppStateContainer.of(context).themeCode,
                    onChanged: (value) {
                      AppStateContainer.of(context).updateTheme(value);
                    },
                    activeColor: appTheme.accentColor,
                  )
                ],
              ),
            ),
            Divider(
              color: appTheme.primaryColor,
              height: 1,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                color: AppStateContainer.of(context)
                    .theme
                    .accentColor
                    .withOpacity(0.1),
              ),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Light",
                    style: TextStyle(color: appTheme.accentColor),
                  ),
                  Radio(
                    value: Themes.LIGHT_THEME_CODE,
                    groupValue: AppStateContainer.of(context).themeCode,
                    onChanged: (value) {
                      AppStateContainer.of(context).updateTheme(value);
                    },
                    activeColor: appTheme.accentColor,
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 15, left: 8, right: 8, bottom: 8),
              child: Text(
                "Unit",
                style: TextStyle(
                  color: appTheme.accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                color: AppStateContainer.of(context)
                    .theme
                    .accentColor
                    .withOpacity(0.1),
              ),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Celsius",
                    style: TextStyle(color: appTheme.accentColor),
                  ),
                  Radio(
                    value: TemperatureUnit.celsius.index,
                    groupValue:
                        AppStateContainer.of(context).temperatureUnit.index,
                    onChanged: (value) {
                      AppStateContainer.of(context)
                          .updateTemperatureUnit(TemperatureUnit.values[value]);
                    },
                    activeColor: appTheme.accentColor,
                  )
                ],
              ),
            ),
            Divider(
              color: appTheme.primaryColor,
              height: 1,
            ),
            Container(
              color: AppStateContainer.of(context)
                  .theme
                  .accentColor
                  .withOpacity(0.1),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Fahrenheit",
                    style: TextStyle(color: appTheme.accentColor),
                  ),
                  Radio(
                    value: TemperatureUnit.fahrenheit.index,
                    groupValue:
                        AppStateContainer.of(context).temperatureUnit.index,
                    onChanged: (value) {
                      AppStateContainer.of(context)
                          .updateTemperatureUnit(TemperatureUnit.values[value]);
                    },
                    activeColor: appTheme.accentColor,
                  )
                ],
              ),
            ),
            Divider(
              color: appTheme.primaryColor,
              height: 1,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                color: AppStateContainer.of(context)
                    .theme
                    .accentColor
                    .withOpacity(0.1),
              ),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Kelvin",
                    style: TextStyle(color: appTheme.accentColor),
                  ),
                  Radio(
                    value: TemperatureUnit.kelvin.index,
                    groupValue:
                        AppStateContainer.of(context).temperatureUnit.index,
                    onChanged: (value) {
                      AppStateContainer.of(context)
                          .updateTemperatureUnit(TemperatureUnit.values[value]);
                    },
                    activeColor: appTheme.accentColor,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
