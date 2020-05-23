import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/usuario.bloc.dart';
import 'package:iholder_app/models/usuario-login.dart';
import 'package:iholder_app/models/usuario-view-model.dart';
import 'package:iholder_app/ui/shared/widgets/input-field.widget.dart';
import 'package:iholder_app/ui/shared/widgets/loader.widget.dart';
import 'package:iholder_app/validators/CustomValidators.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var email = '';
  var senha = '';
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
                  email = val;
                },
                pValidador: (value) {
                  if (!CustomValidators.email(value)) {
                    return 'E-mail Inválido';
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
                  senha = val;
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
                    onPressed: _sending
                        ? null
                        : () {
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
    String validationMessage;
    var bloc = Provider.of<UsuarioBloc>(context, listen: false);

    setState(() {
      _sending = true;
    });

    UsuarioViewModel usuario = await bloc
        .login(
      new UsuarioLogin(
        email: email,
        senha: senha,
      ),
    )
        .whenComplete(() {
      setState(() {
        _sending = false;
      });
    }).catchError((onError) {
      validationMessage = onError.message;
    });

    if (usuario != null) {
      Navigator.pop(context);
      return;
    } else if (validationMessage == "") {
      validationMessage = 'Usuário ou senha invalidos';
    }

    final snackBar = SnackBar(content: Text(validationMessage));
    _scaffoldKey.currentState.showSnackBar(snackBar);
    validationMessage = "";
  }
}
