import 'package:iholder_app/models/distribuicao-view-model.dart';

abstract class IDistribuicaoBloc {
  var mostraTabela = true;
  List<DistribuicaoViewModel> distribuicoes;
  IDistribuicaoBloc();
  alteraFormatoVisualizacao();
  obterDistribuicao();
}
