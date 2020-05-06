import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/usuario.bloc.dart';
import 'package:iholder_app/models/usuario-view-model.dart';
import 'package:iholder_app/models/usuario.dart';
import 'package:iholder_app/ui/shared/widgets/genero-picker.dart';
import 'package:iholder_app/ui/shared/widgets/input-field.date.dart';
import 'package:iholder_app/ui/shared/widgets/input-field.widget.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class CadastroUsuarioScreen extends StatefulWidget {
  final f = new DateFormat('yyyy/MM/dd');
  @override
  _CadastroUsuarioScreenState createState() => _CadastroUsuarioScreenState();
}

class _CadastroUsuarioScreenState extends State<CadastroUsuarioScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var usuario = new Usuario();

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
                ptype: TextInputType.text,
                plabel: "Nome",
                picon: MdiIcons.smartCard,
                pValidador: (value) {
                  if (value.isEmpty) {
                    return 'Nome Inválido';
                  }
                  return null;
                },
                pOnSaved: (val) {
                  usuario.nome = val;
                },
              ),
              InputField(
                ptype: TextInputType.emailAddress,
                plabel: "E-mail",
                picon: MdiIcons.email,
                pValidador: (value) {
                  if (!value.contains("@")) {
                    return 'E-mail Inválido';
                  }
                  return null;
                },
                pOnSaved: (val) {
                  usuario.email = val;
                },
              ),
              InputField(
                ptype: TextInputType.visiblePassword,
                plabel: "Senha",
                picon: MdiIcons.accountKey,
                pValidador: (value) {
                  if (value.length < 6) {
                    return 'A senha deve conter 6 ou mais caracteres';
                  }
                  return null;
                },
                pOnSaved: (val) {
                  usuario.senha = val;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: GeneroPicker(
                  onSelect: (val) {
                    usuario.genero = val;
                  },
                ),
              ),
              Container(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: RaisedButton(
                    child: Text("Cadastrar"),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        create(context);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  create(BuildContext context) async {
    var bloc = Provider.of<UsuarioBloc>(context, listen: false);

    UsuarioViewModel response =
        await bloc.cadastrar(usuario).catchError((onError) {
      final snackBar = SnackBar(content: Text(onError.message));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    });

    if (response != null) {
      final snackBar = SnackBar(
          content:
              Text('Bem-vindo! ${response.nome}! Autentique-se, por favor'));
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context);
      });
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }
}
