import 'dart:async';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iholder_app/blocs/ativo-em-carteira.bloc.dart';
import 'package:iholder_app/blocs/ativo.bloc.dart';
import 'package:iholder_app/models/ativo-em-carteira-view-model.dart';
import 'package:iholder_app/models/ativo-em-carteira.dart';
import 'package:iholder_app/ui/shared/widgets/input-field.widget.dart';
import 'package:iholder_app/ui/shared/widgets/loader.widget.dart';
import 'package:iholder_app/ui/shared/widgets/type-ahead-field.widget.dart';
import 'package:iholder_app/validators/Formatters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';

class CadastroAtivoEmCarteiraScreen extends StatefulWidget {
  final AtivoEmCarteiraBloc bloc;
  final AtivoBloc ativoBloc;
  final DateFormat dateFormatter = new DateFormat('dd/MM/yyyy');
  final AtivoEmCarteiraViewModel ativoEmCarteiraViewModel;
  final TextEditingController precoMedioCtrl = new TextEditingController();
  final TextEditingController precoTotalCtrl = new TextEditingController();
  final TextEditingController dataAtivoEmCarteiraCtrl =
      new TextEditingController();
  final TextEditingController quantidadeCtrl = new TextEditingController();
  final TextEditingController ativoCtrl = new TextEditingController();
  final AtivoEmCarteira ativoEmCarteira = new AtivoEmCarteira();

  double calcularValorTotal(double precoMedio, double quantidade) =>
      precoMedio * quantidade;

  CadastroAtivoEmCarteiraScreen(this.bloc, this.ativoBloc,
      {this.ativoEmCarteiraViewModel}) {
    if (ativoEmCarteiraViewModel != null && quantidadeCtrl.text != null) {
      precoMedioCtrl.text =
          Parser.toStringCurrency(ativoEmCarteiraViewModel.precoMedio);
      quantidadeCtrl.text =
          Parser.toStringCurrency(ativoEmCarteiraViewModel.quantidade);
      dataAtivoEmCarteiraCtrl.text =
          dateFormatter.format(ativoEmCarteiraViewModel.dataPrimeiroAporte);
      ativoCtrl.text =
          "${ativoEmCarteiraViewModel.ativoTicker} - ${ativoEmCarteiraViewModel.ativoDescricao}";
      ativoEmCarteira.id = ativoEmCarteiraViewModel.id;
      precoTotalCtrl.text = Parser.toStringCurrency(calcularValorTotal(
          ativoEmCarteiraViewModel.precoMedio,
          ativoEmCarteiraViewModel.quantidade));
    }
  }

  @override
  _CadastroAtivoEmCarteiraScreenState createState() =>
      _CadastroAtivoEmCarteiraScreenState();
}

class _CadastroAtivoEmCarteiraScreenState
    extends State<CadastroAtivoEmCarteiraScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _sending = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Cadastro de ativos em carteira"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TypeAheadField(
                pcontroller: widget.ativoCtrl,
                pGetSuggestions: (val) async {
                  return await widget.ativoBloc.obterSugestao(val);
                },
                plabel: "Ativo",
                picon: MdiIcons.basket,
                phint: "PETR4, TSLA, KNRI11 etc...",
                pOnSaved: (val) {
                  widget.ativoEmCarteira.ativoId =
                      widget.ativoBloc.obterPorTicker(val);
                },
                pValidador: (value) {
                  String ativoId = widget.ativoBloc.obterPorTicker(value);
                  if (ativoId == null) {
                    return 'Ativo inválido';
                  }
                  return null;
                },
              ),
              DateTimeField(
                resetIcon: Icon(MdiIcons.close),
                initialValue: DateTime.now(),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
                controller: widget.dataAtivoEmCarteiraCtrl,
                format: DateFormat("dd/MM/yyyy"),
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  icon: Icon(MdiIcons.calendar),
                  hintText: "dd/mm/aaaa",
                  labelText: "Data Primeiro Aporte",
                ),
                onSaved: (dt) {
                  widget.ativoEmCarteira.dataPrimeiroAporte = dt;
                },
              ),
              InputField(
                pcontroller: widget.precoMedioCtrl,
                ptype: TextInputType.number,
                plabel: "R\$ Médio",
                picon: MdiIcons.cashUsd,
                pFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  CurrencyPtBrInputFormatter()
                ],
                pValidador: (value) {
                  var medio = Parser.toDoubleCurrency(value);
                  if (medio < 0) {
                    return 'Valor inválido';
                  }
                  return null;
                },
                pOnSaved: (val) {
                  widget.ativoEmCarteira.precoMedio =
                      Parser.toDoubleCurrency(val);
                },
                pOnChange: (value) {
                  widget.precoTotalCtrl.text = Parser.toStringCurrency(
                      widget.calcularValorTotal(
                          Parser.toDoubleCurrency(widget.quantidadeCtrl.text),
                          Parser.toDoubleCurrency(value)));
                },
              ),
              InputField(
                  pcontroller: widget.quantidadeCtrl,
                  ptype: TextInputType.number,
                  plabel: "Quantidade",
                  picon: MdiIcons.counter,
                  pFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    CurrencyPtBrInputFormatter()
                  ],
                  pValidador: (value) {
                    var quantidade = Parser.toDoubleCurrency(value);
                    if (quantidade < 0) {
                      return 'Quantidade inválida';
                    }
                    widget.precoTotalCtrl.text = Parser.toStringCurrency(
                        widget.calcularValorTotal(
                            quantidade,
                            Parser.toDoubleCurrency(
                                widget.precoMedioCtrl.text)));
                    return null;
                  },
                  pOnSaved: (val) {
                    widget.ativoEmCarteira.quantidade =
                        Parser.toDoubleCurrency(val);
                  },
                  pOnChange: (value) {
                    widget.precoTotalCtrl.text = Parser.toStringCurrency(
                        widget.calcularValorTotal(
                            Parser.toDoubleCurrency(value),
                            Parser.toDoubleCurrency(
                                widget.precoMedioCtrl.text)));
                  }),
              InputField(
                pcontroller: widget.precoTotalCtrl,
                ptype: TextInputType.number,
                plabel: "R\$ Total",
                picon: MdiIcons.cashUsd,
                pEnabled: false,
                pFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  CurrencyPtBrInputFormatter()
                ],
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
    String response =
        await widget.bloc.salvar(widget.ativoEmCarteira).whenComplete(
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
