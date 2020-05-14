import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DataLoader extends StatelessWidget {
  final object;
  final Function callback;

  DataLoader({@required this.object, this.callback});

  @override
  Widget build(BuildContext context) {
    if (object == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (object.length == 0) {
      return Center(
        child: Text("Nenhum item encontrado"),
      );
    }
    return callback();
  }
}
