import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iholder_app/blocs/ativo.bloc.dart';
import 'package:iholder_app/blocs/produto.bloc.dart';
import 'package:iholder_app/models/ativo-view-model.dart';
import 'package:iholder_app/models/ativo.dart';
import 'package:iholder_app/ui/shared/widgets/input-field.widget.dart';
import 'package:iholder_app/ui/shared/widgets/loader.widget.dart';
import 'package:iholder_app/ui/shared/widgets/type-ahead-field.widget.dart';
import 'package:iholder_app/validators/Formatters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CadastroAtivoScreen extends StatefulWidget {
  final AtivoViewModel ativoViewModel;
  final AtivoBloc bloc;
  final ProdutoBloc produtoBloc;
  final TextEditingController descricaoCtrl = new TextEditingController();
  final TextEditingController tickerCtrl = new TextEditingController();
  final TextEditingController caracteristicasCtrl = new TextEditingController();
  final TextEditingController cotacaoCtrl = new TextEditingController();
  final TextEditingController produtoCtrl = new TextEditingController();
  final Ativo ativo = new Ativo();
  CadastroAtivoScreen(this.bloc, this.produtoBloc, {this.ativoViewModel}) {
    if (ativoViewModel != null && descricaoCtrl.text != null) {
      descricaoCtrl.text = ativoViewModel.descricao;
      caracteristicasCtrl.text = ativoViewModel.caracteristicas;
      tickerCtrl.text = ativoViewModel.ticker;
      cotacaoCtrl.text = Parser.toStringCurrency(ativoViewModel.cotacao);
      produtoCtrl.text = ativoViewModel.produtoDescricao;
      ativo.produtoId = ativoViewModel.produtoId;
      ativo.id = ativoViewModel.id;
      ativo.dataReferenciaSituacao = ativoViewModel.dataReferenciaSituacao;
      ativo.situacao = ativoViewModel.situacao;
    }
  }
  @override
  _CadastroAtivoScreenState createState() => _CadastroAtivoScreenState();
}

class _CadastroAtivoScreenState extends State<CadastroAtivoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
                pGetSuggestions: (val) async {
                  return await widget.produtoBloc.obterSugestao(val);
                },
                plabel: "Produto",
                picon: MdiIcons.bulletinBoard,
                phint: "Ação, CDB, FII etc",
                pOnSaved: (val) {
                  widget.produtoBloc
                      .obterPorDescricao(val)
                      .then((value) => widget.ativo.produtoId = value);
                },
                pValidador: (value) {
                  widget.produtoBloc
                      .obterPorDescricao(value)
                      .then((value) => widget.ativo.produtoId = value);
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
                pSuffixIcon: _sending ? null : MdiIcons.cashMarker,
                pOnSuffixIcon: () => consultarCotacao(context),
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
    setState(() {
      _sending = true;
    });
    String response = await widget.bloc.salvar(widget.ativo).whenComplete(
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

  Future<dynamic> consultarCotacao(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    widget.cotacaoCtrl.clear();
    var ticker = widget.tickerCtrl.text;
    var produtoDescricao = widget.produtoCtrl.text;
    String mensagem;
    if (ticker != "" && produtoDescricao != "") {
      setState(() {
        _sending = true;
      });
      await widget.bloc
          .consutarCotacao(ticker, produtoDescricao)
          .then((value) =>
              widget.cotacaoCtrl.text = Parser.toStringCurrency(value.preco))
          .whenComplete(
        () {
          setState(
            () {
              _sending = false;
            },
          );
        },
      ).catchError((onError) {
        mensagem = onError.message;
      });
    } else {
      mensagem = "Ticker e/ou Produto não selecionados";
    }

    if (mensagem != null) {
      final snackBar = SnackBar(
        content: Text(mensagem),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }
}
