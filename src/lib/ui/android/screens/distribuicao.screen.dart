import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/Idistribuicao.bloc.dart';
import 'package:iholder_app/blocs/distribuicao-por-ativo.bloc.dart';
import 'package:iholder_app/blocs/distribuicao-por-produto.bloc.dart';
import 'package:iholder_app/blocs/distribuicao-por-tipo.bloc.dart';
import 'package:iholder_app/models/tipo-distribuicao.enum.dart';
import 'package:iholder_app/ui/shared/widgets/data-loader.widget.dart';
import 'package:iholder_app/ui/shared/widgets/distribuicao-grid.widget.dart';
import 'package:iholder_app/ui/shared/widgets/distribuicao-table.widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class DistribuicaoScreen extends StatelessWidget {
  final ETipoDistribuicao tipoDistribuicao;

  DistribuicaoScreen(this.tipoDistribuicao);

  @override
  Widget build(BuildContext context) {
    IDistribuicaoBloc bloc;
    String descricaoTela;
    switch (tipoDistribuicao) {
      case ETipoDistribuicao.ativo:
        bloc = Provider.of<DistribuicaoPorAtivoBloc>(context);
        descricaoTela = "ativos";
        break;
      case ETipoDistribuicao.produto:
        bloc = Provider.of<DistribuicaoPorProdutoBloc>(context);
        descricaoTela = "produtos";
        break;
      case ETipoDistribuicao.tipo:
        bloc = Provider.of<DistribuicaoPorTipoBloc>(context);
        descricaoTela = "tipos";
        break;
    }
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: new Icon(MdiIcons.formatListBulletedSquare)),
              Tab(icon: new Icon(MdiIcons.viewGrid)),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white38,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.all(5.0),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.0, color: Colors.red[300]),
              insets: EdgeInsets.zero,
            ),
          ),
          title: Text("Distribuição por $descricaoTela"),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("recalculando...");
          },
          child: Icon(MdiIcons.ballotRecount),
        ),
      ),
    );
  }
}
