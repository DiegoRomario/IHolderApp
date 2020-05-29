import 'dart:async';
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
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class CadastroAporteScreen extends StatefulWidget {
  final AporteViewModel aporteViewModel;
  final TextEditingController precoMedioCtrl = new TextEditingController();
  final TextEditingController dataAporte = new TextEditingController();
  final TextEditingController quantidadeCtrl = new TextEditingController();
  final TextEditingController ativoCtrl = new TextEditingController();
  final Aporte aporte = new Aporte();
  CadastroAporteScreen({this.aporteViewModel}) {
    if (aporteViewModel != null && quantidadeCtrl.text != null) {
      precoMedioCtrl.text = Parser.toStringCurrency(aporteViewModel.precoMedio);
      quantidadeCtrl.text = Parser.toStringCurrency(aporteViewModel.quantidade);
      dataAporte.text = aporteViewModel.dataAporte.toString();
      ativoCtrl.text = aporteViewModel.produtoDescricao;
      aporte.id = aporteViewModel.id;
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
              DateTimePickerFormField(
                resetIcon: MdiIcons.calendarRefresh,
                inputType: InputType.date,
                format: DateFormat("dd/MM/yyyy"),
                initialDate: DateTime.now(),
                editable: true,
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  icon: Icon(MdiIcons.calendar),
                  hintText: "dd/mm/aaaa",
                  labelText: "Data Aporte",
                ),
                onChanged: (dt) {
                  setState(() => widget.aporte.dataAporte = dt);
                  print('Selected date: ${widget.aporte.dataAporte}');
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
                  var cotacao = Parser.toDoubleCurrency(value);
                  if (cotacao < 0) {
                    return 'Quantidade inválida';
                  }
                  return null;
                },
                pOnSaved: (val) {
                  widget.aporte.quantidade = Parser.toDoubleCurrency(val);
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
