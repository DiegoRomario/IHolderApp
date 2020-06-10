import 'package:flutter/material.dart';
import 'package:iholder_app/models/distribuicao-view-model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DistribuicaoGrid extends StatefulWidget {
  final List<DistribuicaoViewModel> distribuicoes;

  const DistribuicaoGrid({@required this.distribuicoes});
  @override
  _DistribuicaoGridState createState() =>
      _DistribuicaoGridState();
}

class _DistribuicaoGridState
    extends State<DistribuicaoGrid> {
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
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)),
                                      leading: corPorOrientacao(widget
                                          .distribuicoes[index].orientacao),
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
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "Objetivo",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    Text(
                                      widget.distribuicoes[index]
                                              .percentualObjetivo
                                              .toString() +
                                          "%",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "Atual",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    Text(
                                      widget.distribuicoes[index]
                                              .percentualAtual
                                              .toString() +
                                          "%",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "Diferença",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    Text(
                                      widget.distribuicoes[index]
                                              .percentualDiferenca
                                              .toString() +
                                          "%",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "Objetivo",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    Text(
                                      "R\$" +
                                          widget.distribuicoes[index]
                                              .percentualObjetivo
                                              .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "Atual",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    Text(
                                      "R\$" +
                                          widget.distribuicoes[index]
                                              .percentualAtual
                                              .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
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

  Icon corPorOrientacao(String orientacao) {
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
