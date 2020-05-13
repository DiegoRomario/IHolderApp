import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/distribuicao-por-tipo-investimento.bloc.dart';
import 'package:iholder_app/ui/shared/widgets/distribuicao-por-tipo-investimento-list.widget.dart';
import 'package:provider/provider.dart';

class PainelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DistribuicaoPorTipoInvestimentoBloc bloc =
        Provider.of<DistribuicaoPorTipoInvestimentoBloc>(context);
    return Scaffold(body: DistribuicoesTable());
  }
}
