import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UsuarioNaoAutorizado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              MdiIcons.accountLock,
              size: 56,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Text("Não autorizado!"),
            )
          ],
        ),
      ),
    );
  }
}
