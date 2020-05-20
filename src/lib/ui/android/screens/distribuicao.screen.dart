import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/Idistribuicao.bloc.dart';
import 'package:iholder_app/ui/shared/widgets/data-loader.widget.dart';
import 'package:iholder_app/ui/shared/widgets/distribuicao-grid.widget.dart';
import 'package:iholder_app/ui/shared/widgets/distribuicao-table.widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DistribuicaoScreen extends StatelessWidget {
  final String tipoDistribuicao;
  final IDistribuicaoBloc bloc;

  const DistribuicaoScreen(this.tipoDistribuicao, this.bloc);

  @override
  Widget build(BuildContext context) {
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
          title: Text(tipoDistribuicao),
        ),
        body: TabBarView(
          children: [
            DataLoader(
              object: bloc.distribuicoes,
              callback: () {
                return DistribuicaoTable(
                  distribuicoes: bloc.distribuicoes,
                );
              },
            ),
            DataLoader(
              object: bloc.distribuicoes,
              callback: () {
                return DistribuicaoGrid(
                  distribuicoes: bloc.distribuicoes,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
