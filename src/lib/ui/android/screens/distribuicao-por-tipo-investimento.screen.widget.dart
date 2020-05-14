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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: new Icon(MdiIcons.formatListBulletedSquare)),
              Tab(icon: new Icon(MdiIcons.viewGrid)),
            ],
          ),
          title: Text('Distribuição por tipo investimento'),
        ),
        body: TabBarView(
          children: [
            DataLoader(
              object: bloc.distribuicoesPorTipoInvestimento,
              callback: () {
                return DistribuicaoPorTipoInvestimentoTable(
                  distribuicoes: bloc.distribuicoesPorTipoInvestimento,
                );
              },
            ),
            DataLoader(
              object: bloc.distribuicoesPorTipoInvestimento,
              callback: () {
                return DistribuicaoPorTipoInvestimentoGrid(
                  distribuicoes: bloc.distribuicoesPorTipoInvestimento,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
