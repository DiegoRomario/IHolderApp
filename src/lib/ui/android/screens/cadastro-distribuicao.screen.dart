import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/Idistribuicao.bloc.dart';
import 'package:iholder_app/blocs/distribuicao-por-ativo.bloc.dart';
import 'package:iholder_app/ui/shared/widgets/cadastro-distribuicao-table.dart';
import 'package:iholder_app/ui/shared/widgets/data-loader.widget.dart';
import 'package:provider/provider.dart';

class CadastroDistribuicaoScreen extends StatefulWidget {
  final String tipoDistribuicao;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  // final IDistribuicaoBloc bloc;

  CadastroDistribuicaoScreen(this.tipoDistribuicao);

  @override
  _CadastroDistribuicaoScreenState createState() =>
      _CadastroDistribuicaoScreenState();
}

class _CadastroDistribuicaoScreenState
    extends State<CadastroDistribuicaoScreen> {
  List<Item> _data = generateItems(3);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      appBar: AppBar(
        title: Text(widget.tipoDistribuicao),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: _buildPanel(context),
        ),
      ),
    );
  }

  Widget _buildPanel(BuildContext context) {
    var bloc = Provider.of<DistribuicaoPorAtivoBloc>(context);
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        var _formKey = GlobalKey<FormState>();
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
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
    this.headerValue,
    this.isExpanded = false,
  });
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  var teste = new List<Item>();
  teste.add(
    Item(
      headerValue: 'Por ativo',
    ),
  );
  teste.add(
    Item(
      headerValue: 'Por produto',
    ),
  );
  teste.add(
    Item(
      headerValue: 'Por tipo de investimento',
    ),
  );
  return teste;
}
