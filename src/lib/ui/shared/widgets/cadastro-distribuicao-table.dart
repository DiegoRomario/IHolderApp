import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iholder_app/blocs/Idistribuicao.bloc.dart';
import 'package:iholder_app/models/distribuicao-divisao.dart';
import 'package:iholder_app/models/distribuicao-view-model.dart';
import 'package:iholder_app/models/distribuicao.dart';
import 'package:iholder_app/validators/Formatters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'card-button.widget.dart';
import 'loader.widget.dart';

class CadastroDistribuicaoTable extends StatefulWidget {
  final IDistribuicaoBloc bloc;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;

  CadastroDistribuicaoTable(
      {@required this.bloc,
      @required this.formKey,
      @required this.scaffoldKey});

  @override
  _CadastroDistribuicaoTableState createState() =>
      _CadastroDistribuicaoTableState();
}

class _CadastroDistribuicaoTableState extends State<CadastroDistribuicaoTable> {
  List<DistribuicaoViewModel> distribuicoes;

  @override
  void initState() {
    super.initState();
    distribuicoes = widget.bloc.distribuicoes;
  }

  var _sending = false;
  double percentualObjetivo = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.77,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  sortColumnIndex: 0,
                  columns: [
                    DataColumn(
                      label: Icon(MdiIcons.wallet),
                    ),
                    DataColumn(
                      label: Text(
                        'Ticker',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 12.00),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        '% Objetivo',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 12.00),
                      ),
                    ),
                    DataColumn(
                      label: Text(''),
                    ),
                  ],
                  rows: distribuicoes
                      .map(
                        (item) => DataRow(
                          cells: [
                            DataCell(
                              item.estaNaCarteira
                                  ? Icon(MdiIcons.check, color: Colors.green)
                                  : Icon(MdiIcons.close,
                                      color: Colors.redAccent),
                            ),
                            DataCell(
                              Text(item.descricao),
                            ),
                            DataCell(
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, top: 8.0),
                                child: Container(
                                  width: 65,
                                  child: TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter.digitsOnly,
                                      PercentInputFormatter(maxDigits: 5)
                                    ],
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(13),
                                        border: new OutlineInputBorder(),
                                        filled: true,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        labelStyle: TextStyle(
                                            fontSize: 13,
                                            color: Theme.of(context)
                                                .primaryColorLight),
                                        labelText: (item.percentualObjetivo > 10
                                                ? " "
                                                : "  ") +
                                            Parser.toStringCurrency(
                                                item.percentualObjetivo)),
                                    textAlign: TextAlign.center,
                                    validator: (value) {
                                      if (Parser.toDoubleCurrency(value) >
                                          100) {
                                        return '% Inválido';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      percentualObjetivo =
                                          Parser.toDoubleCurrency(value);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              IconButton(
                                icon: Icon(Icons.save,
                                    color: Theme.of(context).primaryColorLight),
                                onPressed: _sending
                                    ? null
                                    : () {
                                        if (widget.formKey.currentState
                                            .validate()) {
                                          widget.formKey.currentState.save();
                                          salvar(
                                              context,
                                              new Distribuicao(
                                                  id: item.id,
                                                  tipoDistribuicaoId:
                                                      item.tipoDistribuicaoId,
                                                  percentualObjetivo:
                                                      percentualObjetivo));
                                        }
                                      },
                              ),
                            )
                          ],
                        ),
                      )
                      .toList(),
                ),
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
          Container(
            color: Theme.of(context).cardColor,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CardButton(
                    descricao: "Entre ativos em carteira",
                    icon: MdiIcons.divisionBox,
                    onClick: _sending
                        ? null
                        : () {
                            dividir(context, true);
                          },
                  ),
                  CardButton(
                    descricao: "Entre ativos cadastrados",
                    icon: MdiIcons.divisionBox,
                    onClick: _sending
                        ? null
                        : () {
                            dividir(context, false);
                          },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  salvar(BuildContext context, Distribuicao distribuicao) async {
    setState(() {
      _sending = true;
    });
    String response = await widget.bloc.salvar(distribuicao).whenComplete(
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
        widget.scaffoldKey.currentState.showSnackBar(snackBar);
      },
    );
    if (response != null) {
      final snackBar = SnackBar(
        content: Text(response),
      );
      widget.scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  dividir(BuildContext context, bool somenteItensEmCarteira) async {
    setState(() {
      _sending = true;
    });
    String response = await widget.bloc
        .dividir(new DistribuicaoDivisao(
            somenteItensEmCarteira: somenteItensEmCarteira))
        .whenComplete(
      () {
        distribuicoes = widget.bloc.distribuicoes;
        setState(
          () {
            _sending = false;
          },
        );
      },
    ).catchError(
      (onError) {
        final snackBar = SnackBar(content: Text(onError.message));
        widget.scaffoldKey.currentState.showSnackBar(snackBar);
      },
    );
    if (response != null) {
      final snackBar = SnackBar(
        content: Text(response),
      );
      widget.scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }
}
