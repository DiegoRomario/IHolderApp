import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/Idistribuicao.bloc.dart';
import 'package:iholder_app/blocs/distribuicao-por-ativo.bloc.dart';
import 'package:iholder_app/blocs/distribuicao-por-produto.bloc.dart';
import 'package:iholder_app/blocs/distribuicao-por-tipo.bloc.dart';
import 'package:iholder_app/models/tipo-distribuicao.enum.dart';
import 'package:iholder_app/ui/shared/widgets/cadastro-distribuicao-table.dart';
import 'package:iholder_app/ui/shared/widgets/loader.widget.dart';
import 'package:provider/provider.dart';

class CadastroDistribuicaoScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ETipoDistribuicao tipoDistribuicao;

  CadastroDistribuicaoScreen(this.tipoDistribuicao);
  @override
  _CadastroDistribuicaoScreenState createState() =>
      _CadastroDistribuicaoScreenState();
}

class _CadastroDistribuicaoScreenState
    extends State<CadastroDistribuicaoScreen> {
  var _formKey = GlobalKey<FormState>();
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

    return Scaffold(
      key: widget._scaffoldKey,
      appBar: AppBar(
        title: Text("Cadastro de distribuição por $descricaoTela"),
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
              return CadastroDistribuicaoTable(
                bloc: bloc,
                formKey: _formKey,
                scaffoldKey: widget._scaffoldKey,
              );
          }
          return Text("Erro desconhecido");
        },
      ),
    );
  }
}
