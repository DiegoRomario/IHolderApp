import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/distribuicao.bloc.dart';
import 'package:iholder_app/ui/shared/widgets/data-loader.widget.dart';
import 'package:iholder_app/ui/shared/widgets/distribuicao-grid.widget.dart';
import 'package:iholder_app/ui/shared/widgets/distribuicao-table.widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class DistribuicaoPorTipoInvestimentoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<DistribuicaoBloc>(context);
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
                return DistribuicaoTable(
                  distribuicoes: bloc.distribuicoesPorTipoInvestimento,
                );
              },
            ),
            DataLoader(
              object: bloc.distribuicoesPorTipoInvestimento,
              callback: () {
                return DistribuicaoGrid(
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
