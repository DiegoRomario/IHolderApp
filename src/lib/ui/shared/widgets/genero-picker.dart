import 'package:flutter/material.dart';

class GeneroPicker extends StatefulWidget {
  final Function(int id) onSelect;
  GeneroPicker({@required this.onSelect});
  @override
  GeneroPickerWidget createState() => GeneroPickerWidget();
}

class GeneroPickerWidget extends State<GeneroPicker> {
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
                widget.onSelect(1);
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
                widget.onSelect(2);
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
                widget.onSelect(3);
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
