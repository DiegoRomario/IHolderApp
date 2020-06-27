import 'package:flutter/widgets.dart';
import 'package:iholder_app/models/distribuicao-divisao.dart';
import 'package:iholder_app/models/distribuicao-view-model.dart';
import 'package:iholder_app/models/distribuicao.dart';
import 'package:iholder_app/repositories/distribuicao.repository.dart';
import 'Idistribuicao.bloc.dart';

class DistribuicaoPorProdutoBloc extends ChangeNotifier
    implements IDistribuicaoBloc {
  var mostraTabela = true;
  final distribuicoesRepository =
      new DistribuicaoRepository("DistribuicaoPorProduto");

  List<DistribuicaoViewModel> distribuicoes;

  DistribuicaoPorProdutoBloc() {
    distribuicoes = new List<DistribuicaoViewModel>();
  }

  alteraFormatoVisualizacao() {
    mostraTabela = !mostraTabela;
    notifyListeners();
  }

  Future<List<DistribuicaoViewModel>> obterDistribuicao(
      {bool recalcular = false}) async {
    if (recalcular == true) {
      await distribuicoesRepository.recalcular();
    }
    await distribuicoesRepository.obterTodos().then((data) {
      this.distribuicoes = data;
    });
    return distribuicoes;
  }

  Future<String> salvar(Distribuicao produto) async {
    try {
      var response = await distribuicoesRepository.salvar(produto);
      await obterDistribuicao();
      return response;
    } catch (ex) {
      throw ex;
    }
  }

  Future<String> dividir(DistribuicaoDivisao divisao) async {
    try {
      var response = await distribuicoesRepository.dividir(divisao);
      await obterDistribuicao();
      return response;
    } catch (ex) {
      throw ex;
    }
  }

  Future<String> recalcular() async {
    try {
      var response = await distribuicoesRepository.recalcular();
      await obterDistribuicao();
      return response;
    } catch (ex) {
      throw ex;
    }
  }
}
