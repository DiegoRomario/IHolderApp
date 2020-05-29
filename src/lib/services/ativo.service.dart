import 'package:iholder_app/models/ativo-view-model.dart';
import 'package:iholder_app/repositories/ativo.repository.dart';

class AtivoService {
  var produtoRepository = new AtivoRepository();
  List<AtivoViewModel> ativos;

  AtivoService() {
    produtoRepository.obterTodos().then(
      (data) {
        this.ativos = data;
      },
    );
  }

  String obterPorTicker(String ticker) {
    AtivoViewModel ativo = ativos.firstWhere(
        (e) => e.ticker + " - " + e.descricao == ticker,
        orElse: () => null);
    return ativo?.id;
  }

  List<String> obterSugestao(String query) {
    List<AtivoViewModel> matches = List();
    matches.addAll(ativos);

    matches.retainWhere(
        (s) => s.ticker.toLowerCase().contains(query.toLowerCase()));

    var sList =
        matches.map((val) => val.ticker + " - " + val.descricao).toList();

    return sList;
  }
}
