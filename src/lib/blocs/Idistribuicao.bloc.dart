import 'package:iholder_app/models/distribuicao-divisao.dart';
import 'package:iholder_app/models/distribuicao-view-model.dart';
import 'package:iholder_app/models/distribuicao.dart';

abstract class IDistribuicaoBloc {
  var mostraTabela = true;
  List<DistribuicaoViewModel> distribuicoes;
  IDistribuicaoBloc();
  alteraFormatoVisualizacao();
  obterDistribuicao();
  Future<String> salvar(Distribuicao ativo);
  Future<String> dividir(DistribuicaoDivisao divisao);
}
