import 'package:flutter/material.dart';
import 'package:iholder_app/models/distribuicao-por-tipo-investimento-view-model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DistribuicaoPorTipoInvestimentoGrid extends StatefulWidget {
  final List<DistribuicaoPorTipoInvestimentoViewModel> distribuicoes;

  const DistribuicaoPorTipoInvestimentoGrid({@required this.distribuicoes});
  @override
  _DistribuicaoPorTipoInvestimentoGridState createState() =>
      _DistribuicaoPorTipoInvestimentoGridState();
}

class _DistribuicaoPorTipoInvestimentoGridState
    extends State<DistribuicaoPorTipoInvestimentoGrid> {
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
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.monetization_on),
                        title: Text(widget
                            .distribuicoes[index].descricaoTipoInvestimento),
                        subtitle: Text("casa, carro, teste, abc 123"),
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
}
