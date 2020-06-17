import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/Idistribuicao.bloc.dart';
import 'package:iholder_app/blocs/distribuicao-por-ativo.bloc.dart';
import 'package:iholder_app/ui/shared/widgets/cadastro-distribuicao-table.dart';
import 'package:iholder_app/ui/shared/widgets/data-loader.widget.dart';
import 'package:provider/provider.dart';

class CadastroDistribuicaoScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  _CadastroDistribuicaoScreenState createState() =>
      _CadastroDistribuicaoScreenState();
}

class _CadastroDistribuicaoScreenState
    extends State<CadastroDistribuicaoScreen> {
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    IDistribuicaoBloc bloc = Provider.of<DistribuicaoPorAtivoBloc>(context);

    return Scaffold(
      key: widget._scaffoldKey,
      appBar: AppBar(
        title: Text("Distribuição por ativo"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: DataLoader(
              object: bloc.distribuicoes,
              callback: () {
                return CadastroDistribuicaoTable(
                  bloc: bloc,
                  formKey: _formKey,
                  scaffoldKey: widget._scaffoldKey,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
