import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/Idistribuicao.bloc.dart';
import 'package:iholder_app/blocs/distribuicao-por-ativo.bloc.dart';
import 'package:iholder_app/blocs/distribuicao-por-produto.bloc.dart';
import 'package:iholder_app/blocs/distribuicao-por-tipo.bloc.dart';
import 'package:iholder_app/models/tipo-distribuicao.enum.dart';
import 'package:iholder_app/ui/shared/widgets/data-loader.widget.dart';
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
  var _sending = false;
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
          future: bloc.obterDistribuicao(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Loader();
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                return bloc.distribuicoes.length > 0
                    ? TabBarView(
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
                      )
                    : Center(child: Text("Nenhum item encontrado"));
            }
            return Text("Erro desconhecido");
          },
        ),
        floatingActionButton: Visibility(
          child: _sending
              ? CircularProgressIndicator()
              : FloatingActionButton(
                  onPressed: _sending
                      ? null
                      : () {
                          recalcular();
                        },
                  child: Icon(MdiIcons.ballotRecount),
                ),
        ),
      ),
    );
  }

  recalcular() async {
    String response;
    if (bloc.distribuicoes.length == 0) {
      response = "Nenhum registro encontrado";
    } else {
      setState(() {
        _sending = true;
      });
      response = await bloc.recalcular().whenComplete(
        () {
          setState(
            () {
              _sending = false;
            },
          );
        },
      ).catchError(
        (onError) {
          final snackBar = SnackBar(content: Text(onError.message));
          widget._scaffoldKey.currentState.showSnackBar(snackBar);
        },
      );
    }
    if (response != null) {
      final snackBar = SnackBar(
        content: Text(response),
      );
      widget._scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }
}
