import 'package:flutter/material.dart';

class DescricaoEWidget extends StatelessWidget {
  final descricao;
  final Widget widget;
  DescricaoEWidget(
    this.descricao,
    this.widget,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          descricao,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: widget,
        ),
      ],
    );
  }
}
