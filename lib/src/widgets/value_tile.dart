import 'package:flutter/material.dart';
import 'package:flutter_weather/src/widgets/empty_widget.dart';

class ValueTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData iconData;

  ValueTile(this.label, this.value, {this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          this.label,
          style: TextStyle(color: Theme.of(context).accentColor.withAlpha(80)),
        ),
        SizedBox(
          height: 5,
        ),
        this.iconData != null ? Icon(iconData, color: Theme.of(context).accentColor, size: 20,) : EmptyWidget(),
        SizedBox(
          height: 10,
        ),
        Text(
          this.value,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ],
    );
  }
}
