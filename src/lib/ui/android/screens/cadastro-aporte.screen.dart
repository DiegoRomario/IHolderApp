import 'dart:async';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iholder_app/blocs/aporte.bloc.dart';
import 'package:iholder_app/models/aporte-view-model.dart';
import 'package:iholder_app/models/aporte.dart';
import 'package:iholder_app/services/ativo.service.dart';
import 'package:iholder_app/ui/shared/widgets/input-field.widget.dart';
import 'package:iholder_app/ui/shared/widgets/loader.widget.dart';
import 'package:iholder_app/ui/shared/widgets/type-ahead-field.widget.dart';
import 'package:iholder_app/validators/Formatters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CadastroAporteScreen extends StatefulWidget {
  final DateFormat dateFormatter = new DateFormat('dd/MM/yyyy');
  final AporteViewModel aporteViewModel;
  final TextEditingController precoMedioCtrl = new TextEditingController();
  final TextEditingController precoTotalCtrl = new TextEditingController();
  final TextEditingController dataAporteCtrl = new TextEditingController();
  final TextEditingController quantidadeCtrl = new TextEditingController();
  final TextEditingController ativoCtrl = new TextEditingController();
  final Aporte aporte = new Aporte();

  double calcularValorTotal(double precoMedio, double quantidade) =>
      precoMedio * quantidade;

  CadastroAporteScreen({this.aporteViewModel}) {
    if (aporteViewModel != null && quantidadeCtrl.text != null) {
      precoMedioCtrl.text = Parser.toStringCurrency(aporteViewModel.precoMedio);
      quantidadeCtrl.text = Parser.toStringCurrency(aporteViewModel.quantidade);
      dataAporteCtrl.text = dateFormatter.format(aporteViewModel.dataAporte);
      ativoCtrl.text =
          "${aporteViewModel.ativoTicker} - ${aporteViewModel.ativoDescricao}";
      aporte.id = aporteViewModel.id;
      precoTotalCtrl.text = Parser.toStringCurrency(calcularValorTotal(
          aporteViewModel.precoMedio, aporteViewModel.quantidade));
    }
  }

  @override
  _CadastroAporteScreenState createState() => _CadastroAporteScreenState();
}

class _CadastroAporteScreenState extends State<CadastroAporteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var ativoService = AtivoService();
  var _sending = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Cadastro de Aportes"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TypeAheadField(
                pcontroller: widget.ativoCtrl,
                pGetSuggestions: (val) {
                  return ativoService.obterSugestao(val);
                },
                plabel: "Ativo",
                picon: MdiIcons.basket,
                phint: "PETR4, TSLA, KNRI11 etc...",
                pOnSaved: (val) {
                  widget.aporte.ativoId = ativoService.obterPorTicker(val);
                },
                pValidador: (value) {
                  String ativoId = ativoService.obterPorTicker(value);
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
                controller: widget.dataAporteCtrl,
                format: DateFormat("dd/MM/yyyy"),
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  icon: Icon(MdiIcons.calendar),
                  hintText: "dd/mm/aaaa",
                  labelText: "Data Aporte",
                ),
                onSaved: (dt) {
                  widget.aporte.dataAporte = dt;
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
                  widget.aporte.precoMedio = Parser.toDoubleCurrency(val);
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
                    widget.aporte.quantidade = Parser.toDoubleCurrency(val);
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
    var bloc = Provider.of<AporteBloc>(context, listen: false);
    setState(() {
      _sending = true;
    });
    String response = await bloc.salvar(widget.aporte).whenComplete(
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
