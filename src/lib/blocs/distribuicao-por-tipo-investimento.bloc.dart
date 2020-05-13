import 'package:flutter/widgets.dart';
import 'package:iholder_app/models/distribuicao-por-tipo-investimento-view-model.dart';
import 'package:iholder_app/repositories/distribuicao-por-tipo-investimento.repository.dart';

class DistribuicaoPorTipoInvestimentoBloc extends ChangeNotifier {
  final categoryRepository = new DistribuicaoPorTipoInvestimentoRepository();

  List<DistribuicaoPorTipoInvestimentoViewModel>
      distribuicoesPorTipoInvestimento;

  DistribuicaoPorTipoInvestimentoBloc() {
    obterDistribuicaoPorTipoInvestimento();
  }

  obterDistribuicaoPorTipoInvestimento() {
    categoryRepository.getAll().then((data) {
      this.distribuicoesPorTipoInvestimento = data;
      notifyListeners();
    });
  }
}
