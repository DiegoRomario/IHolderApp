import 'package:flutter/widgets.dart';
import 'package:iholder_app/models/ativo-view-model.dart';
import 'package:iholder_app/models/ativo.dart';
import 'package:iholder_app/models/cotacao-view-model.dart';
import 'package:iholder_app/repositories/ativo.repository.dart';

class AtivoBloc extends ChangeNotifier {
  var repository = new AtivoRepository();
  bool forcaAtualizacao = false;
  List<AtivoViewModel> ativos;
  AtivoBloc() {
    ativos = new List<AtivoViewModel>();
  }

  Future<List<AtivoViewModel>> obterAtivos() async {
    try {
      if (ativos.length == 0 || forcaAtualizacao) {
        ativos = await repository.obterTodos();
      }
      forcaAtualizacao = false;
      return ativos;
    } catch (ex) {
      throw ex;
    }
  }

  Future<String> salvar(Ativo ativo) async {
    try {
      var response = await repository.salvar(ativo);
      forcaAtualizacao = true;
      return response;
    } catch (ex) {
      throw ex;
    }
  }

  Future<String> alterarSituacao(AtivoViewModel ativo) async {
    try {
      var response = await repository.alterarSituacao(ativo);
      forcaAtualizacao = true;
      return response;
    } catch (ex) {
      throw ex;
    }
  }

  String obterPorTicker(String ticker) {
    AtivoViewModel ativo = ativos.firstWhere(
        (e) => e.ticker + " - " + e.descricao == ticker,
        orElse: () => null);
    return ativo?.id;
  }

  Future<CotacaoViewModel> consutarCotacao(
      String ticker, String produtoDescricao) async {
    try {
      return await repository.consultarCotacao(ticker, produtoDescricao);
    } catch (ex) {
      throw ex;
    }
  }

  Future<List<String>> obterSugestao(String query) async {
    List<AtivoViewModel> matches = List();

    if (this.ativos.length == 0) {
      await obterAtivos();
    }

    matches.addAll(ativos);
    matches.retainWhere(
        (s) => s.ticker.toLowerCase().contains(query.toLowerCase()));
    var sList =
        matches.map((val) => val.ticker + " - " + val.descricao).toList();
    return sList;
  }
}
