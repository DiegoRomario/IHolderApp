import 'package:flutter/material.dart';

class PainelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Text(
          "Painel",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ));
  }
}
