import 'package:flutter/widgets.dart';
import 'package:iholder_app/models/ativo-em-carteira-view-model.dart';
import 'package:iholder_app/models/ativo-em-carteira.dart';
import 'package:iholder_app/repositories/ativo-em-carteira.repository.dart';

class AtivoEmCarteiraBloc extends ChangeNotifier {
  var repository = new AtivoEmCarteiraRepository();
  List<AtivoEmCarteiraViewModel> ativosEmCarteira;
  AtivoEmCarteiraBloc();

  // obterAtivosEmCarteira() async {
  //   ativosEmCarteira = await repository.obterTodos();
  //   notifyListeners();
  // }

  Future<List<AtivoEmCarteiraViewModel>> obterAtivosEmCarteira() async {
    try {
      List<AtivoEmCarteiraViewModel> result = await repository.obterTodos();
      return result;
    } catch (ex) {
      throw ex;
    }
  }

  Future<String> salvar(AtivoEmCarteira ativoEmCarteira) async {
    try {
      var response = await repository.salvar(ativoEmCarteira);
      // obterAtivosEmCarteira();
      return response;
    } catch (ex) {
      throw ex;
    }
  }
}
