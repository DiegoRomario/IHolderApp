import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/usuario.bloc.dart';
import 'package:iholder_app/ui/shared/widgets/usuario-autenticado.widget.card.dart';
import 'package:iholder_app/ui/shared/widgets/usuario-nao-autenticado.widget.dart';
import 'package:provider/provider.dart';

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
                    builder: (context) => UsuarioAutenticadoCard(),
                  ),
                );
              },
              child: Icon(Icons.settings),
            )
          ],
        ),
        body: bloc.usuario?.token == null
            ? UsuarioNaoAutenticadoCard()
            : UsuarioAutenticadoCard());
  }
}
