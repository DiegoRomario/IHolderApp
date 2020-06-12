import 'package:flutter/material.dart';
import 'package:iholder_app/models/distribuicao-view-model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'descricao-e-percentual.widget.dart';
import 'descricao-e-valor.widget.dart';

class DistribuicaoGrid extends StatefulWidget {
  final List<DistribuicaoViewModel> distribuicoes;

  const DistribuicaoGrid({@required this.distribuicoes});
  @override
  _DistribuicaoGridState createState() => _DistribuicaoGridState();
}

class _DistribuicaoGridState extends State<DistribuicaoGrid> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          itemCount: widget.distribuicoes.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.2),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Card(
                elevation: 5,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  child: SingleChildScrollView(
                                    child: ListTile(
                                      title: Text(
                                        widget.distribuicoes[index].descricao,
                                      ),
                                      leading: Container(
                                        child: Tooltip(
                                          message: widget
                                              .distribuicoes[index].orientacao,
                                          child: iconePorOrientacao(widget
                                              .distribuicoes[index].orientacao),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: Divider(color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                DescricaoEPercentual(
                                    "Objetivo",
                                    widget.distribuicoes[index]
                                        .percentualObjetivo),
                                DescricaoEPercentual(
                                    "Atual",
                                    widget
                                        .distribuicoes[index].percentualAtual),
                                DescricaoEPercentual(
                                    "Diferença",
                                    widget.distribuicoes[index]
                                        .percentualDiferenca),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                DescricaoEValor("Atual",
                                    widget.distribuicoes[index].valorAtual),
                                DescricaoEValor("Diferença",
                                    widget.distribuicoes[index].valorDiferenca),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Icon iconePorOrientacao(String orientacao) {
    switch (orientacao) {
      case "Buy":
        return Icon(MdiIcons.cashPlus, color: Colors.green);
        break;
      case "Hold":
        return Icon(MdiIcons.timerSand, color: Colors.blueAccent);
        break;
      default:
        return Icon(MdiIcons.cashMinus, color: Colors.redAccent);
    }
  }
}
