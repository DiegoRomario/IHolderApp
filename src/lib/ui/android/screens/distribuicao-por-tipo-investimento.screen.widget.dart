import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/distribuicao-por-tipo-investimento.bloc.dart';
import 'package:iholder_app/ui/shared/widgets/data-loader.widget.dart';
import 'package:iholder_app/ui/shared/widgets/distribuicao-por-tipo-investimento-grid.widget.dart';
import 'package:iholder_app/ui/shared/widgets/distribuicao-por-tipo-investimento-table.widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class DistribuicaoPorTipoInvestimentoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<DistribuicaoPorTipoInvestimentoBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Distribuição por tipo investimento"),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  bloc.alteraFormatoVisualizacao();
                },
                tooltip: 'Alterna visualização entre grid e tabela',
                icon: Icon(
                  bloc.mostraTabela
                      ? MdiIcons.viewGrid
                      : MdiIcons.formatListBulletedSquare,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          DataLoader(
            object: bloc.distribuicoesPorTipoInvestimento,
            callback: () {
              return bloc.mostraTabela == true
                  ? DistribuicaoPorTipoInvestimentoTable(
                      distribuicoes: bloc.distribuicoesPorTipoInvestimento,
                    )
                  : DistribuicaoPorTipoInvestimentoGrid(
                      distribuicoes: bloc.distribuicoesPorTipoInvestimento,
                    );
            },
          ),
        ],
      ),
    );
  }
}
