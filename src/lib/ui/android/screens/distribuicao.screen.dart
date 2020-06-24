import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/Idistribuicao.bloc.dart';
import 'package:iholder_app/blocs/distribuicao-por-ativo.bloc.dart';
import 'package:iholder_app/blocs/distribuicao-por-produto.bloc.dart';
import 'package:iholder_app/blocs/distribuicao-por-tipo.bloc.dart';
import 'package:iholder_app/models/tipo-distribuicao.enum.dart';
import 'package:iholder_app/ui/shared/widgets/distribuicao-grid.widget.dart';
import 'package:iholder_app/ui/shared/widgets/distribuicao-table.widget.dart';
import 'package:iholder_app/ui/shared/widgets/loader.widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class DistribuicaoScreen extends StatefulWidget {
  final ETipoDistribuicao tipoDistribuicao;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  DistribuicaoScreen(this.tipoDistribuicao);

  @override
  _DistribuicaoScreenState createState() => _DistribuicaoScreenState();
}

class _DistribuicaoScreenState extends State<DistribuicaoScreen> {
  bool _sending = false;
  IDistribuicaoBloc bloc;
  @override
  Widget build(BuildContext context) {
    String descricaoTela;
    switch (widget.tipoDistribuicao) {
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
        key: widget._scaffoldKey,
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
        body: FutureBuilder(
          initialData: List(),
          future: bloc.obterDistribuicao(recalcular: _sending),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Loader(
                    message: _sending ? "Recalculando" : "Carregando");
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (_sending) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    final snackBar = SnackBar(
                      content: Text("Recalculo efetuado com sucesso"),
                    );
                    widget._scaffoldKey.currentState.showSnackBar(snackBar);
                  });
                }
                return bloc.distribuicoes.length > 0
                    ? TabBarView(
                        children: [
                          DistribuicaoTable(distribuicoes: bloc.distribuicoes),
                          DistribuicaoGrid(distribuicoes: bloc.distribuicoes)
                        ],
                      )
                    : Center(child: Text("Nenhum item encontrado"));
            }
            return Text("Erro desconhecido");
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: _sending
              ? Theme.of(context).disabledColor
              : Theme.of(context).accentColor,
          onPressed: _sending ? null : recalcular,
          child: Icon(MdiIcons.ballotRecount),
        ),
      ),
    );
  }

  recalcular() async {
    setState(() {
      _sending = true;
    });
  }
}
