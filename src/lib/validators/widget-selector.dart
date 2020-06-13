import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Selector {
  static ColorSwatch<int> corPorValor(double valor) {
    if (valor > 0)
      return Colors.green;
    else if (valor < 0)
      return Colors.redAccent;
    else
      return Colors.yellow;
  }

  static IconData iconPorValor(double valor) {
    if (valor > 0)
      return MdiIcons.arrowUp;
    else if (valor < 0)
      return MdiIcons.arrowDown;
    else
      return MdiIcons.arrowLeftRight;
  }
}
