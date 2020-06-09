import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/Idistribuicao.bloc.dart';
import 'package:iholder_app/blocs/distribuicao-por-ativo.bloc.dart';
import 'package:iholder_app/blocs/distribuicao-por-produto.bloc.dart';
import 'package:iholder_app/blocs/distribuicao-por-tipo.bloc.dart';
import 'package:iholder_app/models/tipo-distribuicao.enum.dart';
import 'package:iholder_app/ui/shared/widgets/cadastro-distribuicao-table.dart';
import 'package:iholder_app/ui/shared/widgets/data-loader.widget.dart';
import 'package:provider/provider.dart';

class CadastroDistribuicaoScreen extends StatefulWidget {
  final String tipoDistribuicao;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  CadastroDistribuicaoScreen(this.tipoDistribuicao);

  @override
  _CadastroDistribuicaoScreenState createState() =>
      _CadastroDistribuicaoScreenState();
}

class _CadastroDistribuicaoScreenState
    extends State<CadastroDistribuicaoScreen> {
  List<Item> _data = generateItems();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      appBar: AppBar(
        title: Text(widget.tipoDistribuicao),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: _gerarPaineis(context),
        ),
      ),
    );
  }

  Widget _gerarPaineis(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        IDistribuicaoBloc bloc;
        String descricaoTela;
        switch (item.tipoDistribuicao) {
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
        var _formKey = GlobalKey<FormState>();
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text("Por $descricaoTela"),
            );
          },
          body: Form(
            key: _formKey,
            child: DataLoader(
              object: bloc.distribuicoes,
              callback: () {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: CadastroDistribuicaoTable(
                    bloc: bloc,
                    formKey: _formKey,
                    scaffoldKey: widget._scaffoldKey,
                  ),
                );
              },
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

class Item {
  Item({
    this.tipoDistribuicao,
    this.isExpanded = false,
  });
  ETipoDistribuicao tipoDistribuicao;
  bool isExpanded;
}

List<Item> generateItems() {
  var tipos = new List<Item>();
  tipos.add(
    Item(
      tipoDistribuicao: ETipoDistribuicao.ativo,
    ),
  );
  tipos.add(
    Item(
      tipoDistribuicao: ETipoDistribuicao.produto,
    ),
  );
  tipos.add(
    Item(
      tipoDistribuicao: ETipoDistribuicao.tipo,
    ),
  );
  return tipos;
}
