import 'package:flutter/material.dart';
import 'package:iholder_app/validators/Formatters.dart';

class DescricaoEValor extends StatelessWidget {
  final String descricao;
  final double valor;
  final String prefixo;
  final TextStyle style;
  DescricaoEValor(this.descricao, this.valor,
      {this.prefixo = "R\$ ", this.style});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "$prefixo$descricao",
          style: TextStyle(fontSize: 11),
        ),
        Text(
          Parser.toStringCurrency(valor),
          style: style == null ? TextStyle(fontWeight: FontWeight.w500) : style,
        ),
      ],
    );
  }
}
