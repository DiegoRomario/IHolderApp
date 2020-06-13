import 'package:flutter/material.dart';
import 'package:iholder_app/validators/Formatters.dart';

class DescricaoEValor extends StatelessWidget {
  final String descricao;
  final double valor;
  final String prefixo;
  final String sufixo;
  final TextStyle style;
  DescricaoEValor(this.descricao, this.valor,
      {this.prefixo = "R\$ ", this.style, this.sufixo = ""});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "$prefixo$descricao$sufixo",
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
