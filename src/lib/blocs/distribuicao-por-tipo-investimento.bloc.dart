import 'package:flutter/widgets.dart';
import 'package:iholder_app/models/distribuicao-por-tipo-investimento-view-model.dart';
import 'package:iholder_app/repositories/distribuicao-por-tipo-investimento.repository.dart';

class DistribuicaoPorTipoInvestimentoBloc extends ChangeNotifier {
  var mostraTabela = true;
  final distribuicoesRepository =
      new DistribuicaoPorTipoInvestimentoRepository();

  List<DistribuicaoPorTipoInvestimentoViewModel>
      distribuicoesPorTipoInvestimento;

  DistribuicaoPorTipoInvestimentoBloc() {
    obterDistribuicaoPorTipoInvestimento();
  }

  alteraFormatoVisualizacao() {
    mostraTabela = !mostraTabela;
    notifyListeners();
  }

  obterDistribuicaoPorTipoInvestimento() {
    distribuicoesRepository.getAll().then((data) {
      this.distribuicoesPorTipoInvestimento = data;
      notifyListeners();
    });
  }
}
