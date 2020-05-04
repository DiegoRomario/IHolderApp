import 'package:flutter/material.dart';
import 'package:iholder_app/ui/android/screens/cadastro-usuario.screen.dart';
import 'package:iholder_app/ui/android/screens/login.screen.dart';

class UsuarioNaoAutenticadoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 60,
        ),
        FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
          child: Text("Entrar"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CadastroUsuarioScreen(),
              ),
            );
          },
          child: Text("Ainda não sou cadastrado"),
        ),
      ],
    );
  }
}
