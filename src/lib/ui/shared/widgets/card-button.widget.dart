import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final String descricao;
  final IconData icon;
  final Function onClick;

  const CardButton({this.descricao, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).accentColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onClick,
        child: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Icon(icon, color: Colors.black),
              SizedBox(
                height: 8,
              ),
              Text(
                descricao,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
