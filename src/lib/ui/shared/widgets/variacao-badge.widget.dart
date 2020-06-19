import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:iholder_app/validators/Formatters.dart';
import 'package:iholder_app/validators/widget-selector.dart';

class VariacaoBadge extends StatelessWidget {
  final double percentual;

  const VariacaoBadge({this.percentual});

  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeColor: Theme.of(context).backgroundColor,
      shape: BadgeShape.square,
      borderRadius: 20,
      toAnimate: true,
      badgeContent: Row(
        children: <Widget>[
          Text(
            Parser.toStringCurrency(percentual) + " %",
            style: TextStyle(
                color: WidgetSelector.corPorValor(percentual),
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
          Icon(
            WidgetSelector.iconPorValor(percentual),
            size: 12,
            color: WidgetSelector.corPorValor(percentual),
          )
        ],
      ),
    );
  }
}
