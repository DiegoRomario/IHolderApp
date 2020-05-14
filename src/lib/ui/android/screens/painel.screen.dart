import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/distribuicao-por-tipo-investimento.bloc.dart';
import 'package:iholder_app/models/distribuicao-por-tipo-investimento-view-model.dart';
import 'package:iholder_app/ui/shared/widgets/data-loader.widget.dart';
import 'package:provider/provider.dart';

import 'distribuicao-por-tipo-investimento.screen.widget.dart';

class PainelScreen extends StatefulWidget {
  @override
  _PainelScreenState createState() => _PainelScreenState();
}

class _PainelScreenState extends State<PainelScreen> {
  List<DistribuicaoPorTipoInvestimentoViewModel> distribuicoes;

  @override
  Widget build(BuildContext context) {
    final DistribuicaoPorTipoInvestimentoBloc bloc =
        Provider.of<DistribuicaoPorTipoInvestimentoBloc>(context);
    distribuicoes = bloc.distribuicoesPorTipoInvestimento;
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
      ),
      body: OpcoesPaineis(),
    );
  }
}

class OpcoesPaineis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          Material(
            color: Colors.indigo,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => DistribuicaoPorTipoInvestimentoScreen(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(8),
                width: 150,
                height: 150,
                child: Center(
                  child: Text("Distribuição por tipo de investimento",
                      style: TextStyle(color: Colors.white54),
                      textAlign: TextAlign.center),
                ),
              ),
            ),
          ),
          Material(
            color: Colors.indigo,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(8),
                width: 150,
                height: 150,
                child: Center(
                  child: Text("Distribuição por tipo de produto",
                      style: TextStyle(color: Colors.white54),
                      textAlign: TextAlign.center),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
