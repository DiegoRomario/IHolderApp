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
              InputField(
                ptype: TextInputType.text,
                plabel: "CPF",
                picon: MdiIcons.cardText,
                pValidador: (value) {
                  if (value.length < 11) {
                    return 'CPF Inválido';
                  }
                  return null;
                },
                pOnSaved: (val) {
                  usuario.cpf = val;
                  usuario.genero = 1;
                },
              ),
              InputField(
                ptype: TextInputType.text,
                plabel: "Celular",
                picon: MdiIcons.cellphone,
                pValidador: (value) {
                  if (value.length < 2) {
                    return 'Celular Inválido';
                  }
                  return null;
                },
                pOnSaved: (val) {
                  usuario.celular = val;
                },
              ),
              InputFieldDate(
                plabel: "Data nascimento",
                pValidador: (value) {
                  if (value.length < 10) {
                    return 'Data Inválido';
                  }
                  return null;
                },
                pOnSaved: (val) {
                  var ano = int.parse(val.substring(6, 10));
                  var dia = int.parse(val.substring(0, 2));
                  var mes = int.parse(val.substring(3, 5));
                  usuario.data_nascimento =
                      new DateTime.utc(ano, dia, mes).toString();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: GeneroPicker(),
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
