import 'package:flutter/widgets.dart';
import 'package:iholder_app/models/distribuicao-divisao.dart';
import 'package:iholder_app/models/distribuicao-view-model.dart';
import 'package:iholder_app/models/distribuicao.dart';
import 'package:iholder_app/repositories/distribuicao.repository.dart';
import 'Idistribuicao.bloc.dart';

class DistribuicaoPorAtivoBloc extends ChangeNotifier
    implements IDistribuicaoBloc {
  var mostraTabela = true;
  final distribuicoesRepository =
      new DistribuicaoRepository("DistribuicaoPorAtivo");

  List<DistribuicaoViewModel> distribuicoes;

  DistribuicaoPorAtivoBloc() {
    obterDistribuicao();
  }

  alteraFormatoVisualizacao() {
    mostraTabela = !mostraTabela;
    notifyListeners();
  }

  obterDistribuicao() async {
    await distribuicoesRepository.obterTodos().then((data) {
      this.distribuicoes = data;
      notifyListeners();
    });
  }

  Future<String> salvar(Distribuicao ativo) async {
    try {
      var response = await distribuicoesRepository.salvar(ativo);
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
}
