import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/Idistribuicao.bloc.dart';
import 'package:iholder_app/ui/shared/widgets/cadastro-distribuicao-table.dart';
import 'package:iholder_app/ui/shared/widgets/data-loader.widget.dart';

class CadastroDistribuicaoScreen extends StatelessWidget {
  final String tipoDistribuicao;
  final IDistribuicaoBloc bloc;

  const CadastroDistribuicaoScreen(this.tipoDistribuicao, this.bloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tipoDistribuicao),
      ),
      body: DataLoader(
        object: bloc.distribuicoes,
        callback: () {
          return CadastroDistribuicaoTable(
            distribuicoes: bloc.distribuicoes,
          );
        },
      ),
    );
  }
}
