import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iholder_app/blocs/ativo.bloc.dart';
import 'package:iholder_app/models/ativo-view-model.dart';
import 'package:iholder_app/models/ativo.dart';
import 'package:iholder_app/services/ativo.service.dart';
import 'package:iholder_app/services/produto.service.dart';
import 'package:iholder_app/ui/shared/widgets/input-field.widget.dart';
import 'package:iholder_app/ui/shared/widgets/loader.widget.dart';
import 'package:iholder_app/ui/shared/widgets/type-ahead-field.widget.dart';
import 'package:iholder_app/validators/Formatters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class CadastroAtivoScreen extends StatefulWidget {
  final AtivoViewModel ativoViewModel;

  var ativoService = AtivoService();
  final TextEditingController descricaoCtrl = new TextEditingController();
  final TextEditingController tickerCtrl = new TextEditingController();
  final TextEditingController caracteristicasCtrl = new TextEditingController();
  final TextEditingController cotacaoCtrl = new TextEditingController();
  final TextEditingController produtoCtrl = new TextEditingController();
  final Ativo ativo = new Ativo();
  CadastroAtivoScreen({this.ativoViewModel}) {
    if (ativoViewModel != null && descricaoCtrl.text != null) {
      descricaoCtrl.text = ativoViewModel.descricao;
      caracteristicasCtrl.text = ativoViewModel.caracteristicas;
      tickerCtrl.text = ativoViewModel.ticker;
      cotacaoCtrl.text = Parser.toStringCurrency(ativoViewModel.cotacao);
      produtoCtrl.text = ativoViewModel.produtoDescricao;
      ativo.id = ativoViewModel.id;
    }
  }
  @override
  _CadastroAtivoScreenState createState() => _CadastroAtivoScreenState();
}

class _CadastroAtivoScreenState extends State<CadastroAtivoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var produtoService = ProdutoService();
  var _sending = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Cadastro de Ativos"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TypeAheadField(
                pcontroller: widget.produtoCtrl,
                pGetSuggestions: (val) {
                  return produtoService.obterSugestao(val);
                },
                plabel: "Produto",
                picon: MdiIcons.bulletinBoard,
                phint: "Ação, CDB, FII etc",
                pOnSaved: (val) {
                  widget.ativo.produtoId =
                      produtoService.obterPorDescricao(val);
                },
                pValidador: (value) {
                  widget.ativo.produtoId =
                      produtoService.obterPorDescricao(value);
                  if (widget.ativo.produtoId == null) {
                    return 'Produto inválido';
                  }
                  return null;
                },
              ),
              InputField(
                pcontroller: widget.descricaoCtrl,
                ptype: TextInputType.text,
                plabel: "Descrição",
                pMaxLength: 30,
                picon: MdiIcons.cardText,
                pValidador: (value) {
                  if (value.isEmpty) {
                    return 'Descrição inválida';
                  }
                  return null;
                },
                pOnSaved: (val) {
                  widget.ativo.descricao = val;
                },
              ),
              InputField(
                pcontroller: widget.tickerCtrl,
                ptype: TextInputType.text,
                plabel: "Ticket",
                pMaxLength: 30,
                picon: MdiIcons.alphabeticalVariant,
                pValidador: (value) {
                  if (value.isEmpty) {
                    return 'Ticker inválido';
                  }
                  return null;
                },
                pOnSaved: (val) {
                  widget.ativo.ticker = val;
                },
              ),
              InputField(
                pcontroller: widget.caracteristicasCtrl,
                ptype: TextInputType.multiline,
                plabel: "Características",
                picon: MdiIcons.scriptText,
                pOnSaved: (val) {
                  widget.ativo.caracteristicas = val;
                },
              ),
              InputField(
                pcontroller: widget.cotacaoCtrl,
                ptype: TextInputType.number,
                plabel: "Cotação",
                picon: MdiIcons.cashUsd,
                pSuffixIcon: MdiIcons.cashMarker,
                pOnSuffixIcon: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  widget.cotacaoCtrl.clear();
                  var ticker = widget.tickerCtrl.text;
                  if (ticker != "" && widget.ativo.produtoId != "") {
                    widget.ativoService.consutarCotacao(ticker).then((value) =>
                        widget.cotacaoCtrl.text =
                            Parser.toStringCurrency(value));
                  } else {
                    final snackBar = SnackBar(
                      content: Text('Ticker e/ou Produto não selecionados'),
                    );

                    _scaffoldKey.currentState.showSnackBar(snackBar);
                  }
                },
                pFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  CurrencyPtBrInputFormatter()
                ],
                pValidador: (value) {
                  var cotacao = Parser.toDoubleCurrency(value);
                  if (cotacao < 0) {
                    return 'Valor inválido';
                  }
                  return null;
                },
                pOnSaved: (val) {
                  widget.ativo.cotacao = Parser.toDoubleCurrency(val);
                },
              ),
              Container(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: RaisedButton(
                    child: Text("Salvar"),
                    onPressed: _sending
                        ? null
                        : () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              create(context);
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

  create(BuildContext context) async {
    var bloc = Provider.of<AtivoBloc>(context, listen: false);
    setState(() {
      _sending = true;
    });
    String response = await bloc.salvar(widget.ativo).whenComplete(
      () {
        setState(
          () {
            _sending = false;
          },
        );
      },
    ).catchError(
      (onError) {
        final snackBar = SnackBar(content: Text(onError.message));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      },
    );

    if (response != null) {
      final snackBar = SnackBar(
        content: Text(response),
      );
      Timer(
        Duration(milliseconds: 1500),
        () {
          Navigator.pop(context);
        },
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }
}
