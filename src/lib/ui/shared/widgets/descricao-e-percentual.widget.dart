import 'package:flutter/material.dart';
import 'package:iholder_app/validators/Formatters.dart';

class DescricaoEPercentual extends StatelessWidget {
  final descricao;
  final percentual;
  DescricaoEPercentual(
    this.descricao,
    this.percentual,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "% $descricao",
          style: TextStyle(fontSize: 11),
        ),
        Text(
          Parser.toStringPercent(percentual),
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
