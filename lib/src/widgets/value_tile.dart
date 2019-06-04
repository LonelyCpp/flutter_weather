import 'package:flutter/material.dart';

class ValueTile extends StatelessWidget {
  final String label;
  final String value;

  ValueTile(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          this.label,
          style: TextStyle(color: Theme.of(context).accentColor.withAlpha(80)),
        ),
        SizedBox(height: 10,),
        Text(
          this.value,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ],
    );
  }
}
