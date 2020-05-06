import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/usuario.bloc.dart';
import 'package:iholder_app/models/usuario-login.dart';
import 'package:iholder_app/models/usuario-view-model.dart';
import 'package:iholder_app/ui/shared/widgets/input-field.widget.dart';
import 'package:iholder_app/ui/shared/widgets/loader.widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var username = '';
  var password = '';
  var _sending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              InputField(
                ptype: TextInputType.emailAddress,
                plabel: "E-mail",
                picon: Icons.email,
                pOnSaved: (val) {
                  username = val;
                },
                pValidador: (value) {
                  if (value.isEmpty) {
                    return 'Usuário Inválido';
                  }
                  return null;
                },
              ),
              InputField(
                ptype: TextInputType.visiblePassword,
                plabel: "Senha",
                picon: MdiIcons.key,
                pObscureText: true,
                pOnSaved: (val) {
                  password = val;
                },
                pValidador: (value) {
                  if (value.isEmpty) {
                    return 'Senha Inválida';
                  }
                  return null;
                },
              ),
              Container(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: RaisedButton(
                    child: Text("Entrar"),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        authenticate(context);
                      }
                    },
                  ),
                ),
              ),
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Loader(),
                ),
                visible: _sending,
              ),
            ],
          ),
        ),
      ),
    );
  }

  authenticate(BuildContext context) async {
    var bloc = Provider.of<UsuarioBloc>(context, listen: false);

    setState(() {
      _sending = true;
    });

    UsuarioViewModel user = await bloc
        .login(
      new UsuarioLogin(
        login: username,
        password: password,
      ),
    )
        .whenComplete(() {
      setState(() {
        _sending = false;
      });
    });

    if (user != null) {
      Navigator.pop(context);
      return;
    }

    final snackBar = SnackBar(content: Text('Usuário ou senha invalidos'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
