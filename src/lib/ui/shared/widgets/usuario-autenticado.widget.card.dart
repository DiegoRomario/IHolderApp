import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/usuario.bloc.dart';
import 'package:provider/provider.dart';

class UsuarioAutenticadoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<UsuarioBloc>(context);
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: new NetworkImage(
                      "https://cdn.clipart.email/fcc8ead276ddb30d657f23845cd2e028_avatar-icon-of-flat-style-available-in-svg-png-eps-ai-icon-_512-512.png"),
                  fit: BoxFit.fill,
                ),
                color: Theme.of(context).primaryColor,
                border: Border.all(
                  width: 4.0,
                  color: const Color(0xFFFFFFFF),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(200),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Bem-vindo, ${bloc.usuario.nome}"),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              onPressed: bloc.logout,
              child: Text("Sair"),
            )
          ],
        ),
      ),
    );
  }
}
