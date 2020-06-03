import 'package:iholder_app/models/ativo-view-model.dart';
import 'package:iholder_app/models/cotacao-view-model.dart';
import 'package:iholder_app/repositories/ativo.repository.dart';

class AtivoService {
  var repository = new AtivoRepository();
  List<AtivoViewModel> ativos;

  AtivoService() {
    repository.obterTodos().then(
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

  Future<CotacaoViewModel> consutarCotacao(String ticker, String produtoDescricao) async {
    try {
      return await repository.consultarCotacao(ticker, produtoDescricao);
    } catch (ex) {
      throw ex;
    }
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
