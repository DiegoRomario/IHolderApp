import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/usuario.bloc.dart';
import 'package:iholder_app/models/usuario-view-model.dart';
import 'package:iholder_app/models/usuario.dart';
import 'package:iholder_app/ui/shared/widgets/input-field.widget.dart';
import 'package:iholder_app/validators/CustomValidators.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class CadastroUsuarioScreen extends StatefulWidget {
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
        padding: EdgeInsets.all(20),
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
              FlatButton(
                child: Text("Cadastrar"),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    create(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  create(BuildContext context) async {
    var bloc = Provider.of<UsuarioBloc>(context, listen: false);
    UsuarioViewModel response = await bloc.cadastrar(usuario);

    if (response == null) {
      final snackBar =
          SnackBar(content: Text('Não foi possível realizar seu cadastro'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
          content:
              Text('Bem-vindo! ${response.nome}! Autentique-se, por favor'));
      Timer(Duration(seconds: 1), () {
        Navigator.pop(context);
      });

      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }
}
