import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/usuario.bloc.dart';
import 'package:iholder_app/models/usuario-view-model.dart';
import 'package:iholder_app/models/usuario.dart';
import 'package:iholder_app/ui/shared/widgets/input-field.widget.dart';
import 'package:iholder_app/ui/shared/widgets/type-ahead-field.widget.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../../../data.dart';

class CadastroAtivoScreen extends StatefulWidget {
  final f = new DateFormat('yyyy/MM/dd');
  @override
  _CadastroAtivoScreenState createState() => _CadastroAtivoScreenState();
}

class _CadastroAtivoScreenState extends State<CadastroAtivoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var usuario = new Usuario();
  var produtoId = '';

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
              TypeAheadField(
                pGetSuggestions: (val) {
                  return ProdutosService.getSuggestions(val);
                },
                plabel: "Produto",
                picon: MdiIcons.bulletinBoard,
                phint: "Ação, CDB, FII etc",
                pOnSaved: (val) {
                  produtoId = ProdutosService.getByDescription(val);
                  print(produtoId);
                },
                pValidador: (value) {
                  String produtoId = ProdutosService.getByDescription(value);
                  if (produtoId == null) {
                    return 'Produto inválido';
                  }
                  return null;
                },
              ),
              InputField(
                ptype: TextInputType.text,
                plabel: "Descrição",
                picon: MdiIcons.scriptText,
                pValidador: (value) {
                  if (value.isEmpty) {
                    return 'Descrição inválida';
                  }
                  return null;
                },
                pOnSaved: (val) {
                  usuario.nome = val;
                },
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
