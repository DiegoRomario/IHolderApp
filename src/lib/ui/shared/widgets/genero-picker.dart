import 'package:flutter/material.dart';

class GeneroPicker extends StatefulWidget {
  @override
  GeneroPickerWidget createState() => GeneroPickerWidget();
}

class GeneroPickerWidget extends State {
  int id = 1;

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Radio(
              value: 1,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  id = 1;
                });
              },
            ),
            Text(
              'Feminino',
              style: new TextStyle(fontSize: 17.0),
            ),
            Radio(
              value: 2,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  id = 2;
                });
              },
            ),
            Text(
              'Masculino',
              style: new TextStyle(
                fontSize: 17.0,
              ),
            ),
            Radio(
              value: 3,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  id = 3;
                });
              },
            ),
            Text(
              'Outro',
              style: new TextStyle(fontSize: 17.0),
            ),
          ],
        ),
      ],
    );
  }
}
