import 'package:flutter/widgets.dart';
import 'package:iholder_app/models/distribuicao-view-model.dart';
import 'package:iholder_app/repositories/distribuicao.repository.dart';

class DistribuicaoBloc extends ChangeNotifier {
  var mostraTabela = true;
  final distribuicoesRepository = new DistribuicaoRepository();

  List<DistribuicaoViewModel> distribuicoesPorTipoInvestimento;

  DistribuicaoBloc() {
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
