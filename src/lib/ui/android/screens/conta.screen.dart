import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/usuario.bloc.dart';
import 'package:iholder_app/ui/shared/widgets/usuario-autenticado.widget.card.dart';
import 'package:iholder_app/ui/shared/widgets/usuario-nao-autenticado.widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import 'configuracoes.screen.dart';

class ContaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<UsuarioBloc>(context);
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfiguracoesScreen(),
                  ),
                );
              },
              child: Icon(MdiIcons.themeLightDark),
            )
          ],
        ),
        body: bloc.usuario == null
            ? UsuarioNaoAutenticadoCard()
            : UsuarioAutenticadoCard());
  }
}
